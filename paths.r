#paths.r file for Averill et al. ISMEJ in revision.

#high-level directory structure.----
#master data directory.
host <- system('hostname', intern=T)
#data directory conditional to which computer you are working on. Default directory is my university cluster.
data.dir <- '/projectnb/talbot-lab-data/caverill/Averill_ISMEJ_2018_data/'
#conditional data directory assignment.
#If I am working on pecan2, find the data here.
if(host == 'pecan2'){data.dir <- '/fs/data3/caverill/Averill_ISMEJ_2018_data/'}
system(paste0('mkdir -p ',data.dir))

#original_data: files received from authors or downloaded from the internet.
raw.dir <- paste0(data.dir,'original_data/')
system(paste0('mkdir -p ',raw.dir))

#pecan_gen: files generated on pecan2.
pecan.dir <- paste0(data.dir,'pecan_gen/')
system(paste0('mkdir -p ',pecan.dir))

#scc_gen: files generated on the scc/geo/whatever.
scc.dir <- paste0(data.dir,'scc_gen/')
system(paste0('mkdir -p ',scc.dir))

#Tedersoo 2014 Files.----
#original raw data.
 ted_raw_otu.path <- paste0(raw.dir,'alldata.biom_rdp_tedersoo_otu.txt')
 ted_raw_map.path <- paste0(raw.dir,'merging seq and site data.csv')
ted_raw_time.path <- paste0(raw.dir,'tedersoo2014_dates.csv')

#tedersoo pecan gen data
ted_clean_map.path <- paste0(pecan.dir,'map_tedersoo2014_filtered.rds')
ted_clean_otu.path <- paste0(pecan.dir,'otu_tedersoo2014_norm.rds')
#post model fitting data for figures and tables.
ted_model_output.path <- paste0(pecan.dir,'tedersoo_R1_data_fitted_st.env.rds')
ted_monte_carlo_results.path <- paste0(pecan.dir,'tedersoo_monte_carlo_results.rds')

#tedersoo bootstrap run on scc.
ted_bootstrap_st.env_output.path <- paste0(scc.dir,'tedersoo2014_bootstrap_st.env_data.rds')
ted_bootstrap_st.only_output.path <- paste0(scc.dir,'tedersoo2014_bootstrap_st.only_data.rds')


#Talbot 2014 Files.----
#raw files.
tal_raw_otu.path <- paste0(raw.dir,'DOB_Soil_OTU_Table_11Feb13_UNITETAX_with_taxonomy.csv')
tal_raw_map.path <- paste0(raw.dir,'Talbot2014_mapping_with_spatial.rds')
tal_ref_sim.path <- paste0(raw.dir,"Talbot2014_brayCurtis500Avg_All.csv")
#pecan_gen: clean for analysis paths.
tal_clean_map.path <- paste0(pecan.dir,'tal_map_filtered.rds')
tal_clean_otu.path <- paste0(pecan.dir,'tal_otu_filtered.rds')
#post model fitting data for figures and tables.
tal_model_output.path <- paste0(pecan.dir,'talbot_R1_data_fitted_st.env.rds')
#scc_gen: bootstrap results.
tal_bootstrap_st.env_output.path <- paste0(scc.dir,'talbot2014_bootstrap_st.env_data.rds')
tal_bootstrap_st.only_output.path <- paste0(scc.dir,'talbot2014_bootstrap_st.only_data.rds')

#Kivlin 2016 Files.----
#original_data: raw files.
kiv_raw_bac_otu.path <- paste0(raw.dir,'BacteriaOTUTable_2016_04_15.csv')
kiv_raw_bac_map.path <- paste0(raw.dir,'BacteriaENVNoPrimaryNoFeb2012_2015_08_02.csv')
kiv_raw_fun_otu.path <- paste0(raw.dir,'FungiDeSeq2NoSampleSingletonsNoPlants2015_11_04.csv')
kiv_raw_fun_map.path <- paste0(raw.dir,'ENVfungiNoPrimaryNoFeb2012_2015_10_16.csv')
#pecan_gen: data formatting.
kiv_clean_bac_otu.path <- paste0(pecan.dir,'kivlin.bacteria_otu_formatted.rds')
kiv_clean_bac_map.path <- paste0(pecan.dir,'kivlin.bacteria_map_formatted.rds')
kiv_clean_fun_otu.path <- paste0(pecan.dir,'kivlin.fungi_otu_formatted.rds')
kiv_clean_fun_map.path <- paste0(pecan.dir,'kivlin.fungi_map_formatted.rds')
#pecan_gen: models and parameters.
kiv_bac_figure_data.path <- paste0(pecan.dir,'kiv_bac_figure_data.rds')
kiv_fun_figure_data.path <- paste0(pecan.dir,'kiv_fun_figure_data.rds')
      kiv_bac_param.path <- paste0(pecan.dir,'kiv_bac_param.rds')
      kiv_fun_param.path <- paste0(pecan.dir,'kiv_fun_param.rds')
#pecan_gen: bootstrap results.
kiv_bac_bootstrap.path <- paste0(pecan.dir,'kiv_bac_bootstrap.rds')
kiv_fun_bootstrap.path <- paste0(pecan.dir,'kiv_fun_bootstrap.rds')
kiv_bac_sub100_bootstrap.path <- paste0(pecan.dir,'kiv_bac_sub100_bootstrap.rds')
kiv_fun_sub100_bootstrap.path <- paste0(pecan.dir,'kiv_fun_sub100_bootstrap.rds')

#BCI 50ha Files.----
#orginal_data: raw files.
bci_1982.path <- paste0(raw.dir,'PlotDataReport03-29-2017_1363819166.txt')
bci_1985.path <- paste0(raw.dir,'PlotDataReport03-29-2017_1423293327.txt')
bci_1990.path <- paste0(raw.dir,'PlotDataReport03-29-2017_1763020009.txt')
bci_1995.path <- paste0(raw.dir,'PlotDataReport03-29-2017_1829558876.txt')
bci_2000.path <- paste0(raw.dir,'PlotDataReport03-29-2017_386593922.txt')
bci_2005.path <- paste0(raw.dir,'PlotDataReport03-29-2017_1934497808.txt')
bci_2010.path <- paste0(raw.dir,'PlotDataReport03-29-2017_209651249.txt')
bci_2015.path <- paste0(raw.dir,'PlotDataReport03-29-2017_960836467.txt')

#pecan_gen: map, otu, sub_map, sub_otu and matrix lists.
bci_map_clean.path <- paste0(pecan.dir,'BCI_map.rds')
bci_otu_clean.path <- paste0(pecan.dir,'BCI_otu.rds')
  bci_sub_map.path <- paste0(pecan.dir,'BCI_sub.otu.rds')
  bci_sub_otu.path <- paste0(pecan.dir,'BCI_sub.map.rds')
bci_all_matrix_list.path <- paste0(pecan.dir,'BCI_matrix_list.rds')
bci_sub_matrix_list.path <- paste0(pecan.dir,'sub_BCI_matrix_list.rds')

#scc_gen: BCI analysis and bootstrap results.
    bci_fitted.path <- paste0(scc.dir,'BCI_data_fitted.rds')
bci_MRM_output.path <- paste0(scc.dir,'BCI_MRM_output.rds')
bci_MRM_params.path <- paste0(scc.dir,'BCI_MRM_parms.rds')
bci_all_boostrap.path <- paste0(scc.dir,'out_bci_bootstrap.rds')
bci_sub_bootstrap.path <- paste0(scc.dir,'out_bci_bootstrap_sub.100.rds')


#NEON Harvard Forest Files.----
#original_data: raw data files for creating map and otu files.
harv_neon_raw_map.path <- paste0(raw.dir,'NEON_rawFilesList.csv')
harv_neon_raw_otu.path <- paste0(raw.dir,'NEON_SV.table.rds')
harv_neon_raw_loc.path <- paste0(raw.dir,'dp1.10086.00_output.rds') #plot coordinates, etc.

#pecan_gen: clean map and otu files.
harv_neon_clean_map.path <- paste0(pecan.dir,'harv_neon_clean_map.rds')
harv_neon_clean_otu.path <- paste0(pecan.dir,'harv_neon_clean_otu.rds')
#pecan_gen: analysis with fitted normalized values and parameters.
harv_neon_fig_data.path <- paste0(pecan.dir,'harv_neon_fig_data.rds')
harv_neon_params.path <- paste0(pecan.dir,'harv_neon_params.rds')
#pecan_gen: bootstrap data output.
harv_neon_all_boostrap.path <- paste0(pecan.dir,'harv_neon_all_bootstrap.rds')
harv_neon_sub_boostrap.path <- paste0(pecan.dir,'harv_neon_sub_bootstrap.rds')


#Figure Files.----
#These are stored these in main project repository, rather than the data repository.
#Main Figures. Figure 1 is a conceptual figure made in powerpoint, and so is not included here. (embarassing I know...)
fig_2.path <- 'Figures/Fig_2._fitted_vs_observed.png'
fig_3.path <- 'Figures/Fig_3._space_time_fits.png'
fig_4.path <- 'Figures/Fig_4._space_time_fits_with_env.png'

#Supplementary Figures.
fig_S01.path <- 'Figures/Fig_S01._histograms_space_time_distance_methods_validation.png'
fig_S02.path <- 'Figures/Fig_S02._histograms_space_time_distance_analysis.png'
fig_S03.path <- 'Figures/Fig_S03._histograms_time_sampled.png'
fig_S04.path <- 'Figures/Fig_S04._map_of_samples.png'
fig_S05.path <- 'Figures/Fig_S05._validation_fits.png'
fig_S06.path <- 'Figures/Fig_S06._covariate_correlations_LT.png'
fig_S07.path <- 'Figures/Fig_S07._covariate_correlations_JT.png'
fig_S08.path <- 'Figures/Fig_S08._LT_space_time_distances_vs_predictors.png'
fig_S09.path <- 'Figures/Fig_S09._JT_space_time_distances_vs_predictors.png'
fig_S10.path <- 'Figures/Fig_S10._Monte_Carlo_results.png'

#Tables.
 table_1.path <- 'Figures/table_1.csv'
table_S1.path <- 'Figures/table_S1.csv'
