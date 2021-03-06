#BOOTSTRAP analysis of Talbot 2014. Colin Averill Sep 21, 2017.
#SPACE TIME ONLY, no environmental covariates.
#clear R environment, load packages
rm(list=ls())
source('paths.r')
source('Scripts/functions/tic_toc.r')
library(doParallel)

#number of bootstrap simulations.
n.straps <- 10000

#register parallel environment.
registerDoParallel(cores=28)

#set output path
output.path <- tal_bootstrap_st.only_output.path

#load cleaned up map and otu files.----
otu <- readRDS(tal_clean_otu.path)
map <- readRDS(tal_clean_map.path)

#get complete cases. We need to complete case with covariates so the samples in this analysis match the environmental analysis.
old.cov.names <- c('epoch.date','doy','seas_pos','Perc.Soil.Moisture','CNRatio','pH','Perc.C','NPP','MAP','MAT','MAT_CV','MAP_CV')
new.cov.names <- c('epoch.date','doy','seas_pos','Moisture','C_N','pH','C','NPP','MAP','MAT','MAT_CV','MAP_CV')
for(i in 1:length(old.cov.names)){colnames(map)[which(names(map) == old.cov.names[i])] <- new.cov.names[i]}
#get complete cases.
to_keep <- c(new.cov.names,'latitude.dd','longitude.dd','Mapping.ID','Sample.ID')
map <- map[,colnames(map) %in% to_keep]
map <- map[complete.cases(map),]
otu <- otu[,colnames(otu) %in% map$Mapping.ID]
map <- map[order(map$Mapping.ID),]
otu <- otu[,order(colnames(otu))]

#run bootstrap loop.----
tic()
out.boot <- 
  foreach(i = 1:n.straps) %dopar% {
    #sample columns of the OTU table with replacement----
    myOrder <- sample(ncol(otu), replace = T)
    otu.j <- otu[,myOrder]
    map.j <- map[myOrder,]
    
    #calculate bray-curtis similarity. transpose of otu table necessary to get distances.
    bray.dis <- vegan::vegdist(t(otu.j), method='bray')
    bray.sim <- 1 - as.matrix(bray.dis)
    #account for zeros in bray.sim by adding the smallest similarity value in the dataset to every observation
    bray.sim <- bray.sim + min(bray.sim[bray.sim > 0])
    
    #calulate spatial distance, accounting for curvature of Earth.
    points <- map.j[,c('longitude.dd','latitude.dd')]
    space.m <- geosphere::distm(points)
    
    #remaining covariates.
    intra.m <- as.matrix(dist(map.j$seas_pos  , method='euclidean', diag=F, upper=F))
    inter.m <- as.matrix(dist(map.j$epoch.date, method='euclidean', diag=F, upper=F))
    cov.matrices <- list(bray.sim,space.m,intra.m,inter.m)
    names(cov.matrices) <- c('bray.sim','space','seas_pos','epoch.date')
    
    #analyze data subset i. 
    lower  <- lapply(cov.matrices, ecodist::lower)
    dat      <- as.data.frame(lapply(lower, c))
    
    #convert distance in m to distance in km so regression doesn't choke.
    dat$space <- dat$space / 1000
    
    #run model - lm is fine. We are testing significance with distribution of effect sizes via boostrap, not permutation via MRM.
    m <- lm(log(bray.sim) ~ space + seas_pos + epoch.date, data=dat)
    #m <- ecodist::MRM(log(bray.sim) ~ space + seas_pos + epoch.date, data = dat)
    
    #return output ----
    to_return <- coef(m)
    return(to_return)
    
    #print status update----
    cat(paste0(i,' of ',n.straps,' iterations completed...\n'))
  } #end loop. 
toc()

#collapse output list to data.frame----
output <- data.frame(do.call('rbind',out.boot))
colnames(output) <- c('intercept','space','seas_pos','epoch.date')

#save output.
saveRDS(output, output.path)

#end script.