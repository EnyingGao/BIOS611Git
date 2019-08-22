
demographic_data_cleaned.csv: ./data/demographic_data.csv
	Rscript read_demo.R

lab_data_cleaned.csv: ./data/lab_data1.csv ./data/lab_data2.csv ./data/lab_data3.csv ./data/lab_data4.csv
	Rscript read_lab.R

medhist_data_cleaned.csv: ./data/medhist_data1.csv ./data/medhist_data2.csv
	Rscript read_medhist.R

data_cleaned.csv: demographic_data_cleaned.csv lab_data_cleaned.csv medhist_data_cleaned.csv
	Rscript combine_data.R

model1.RData: data_cleaned.csv
	Rscript model1.R

model2.RData: data_cleaned.csv
	Rscript model2.R
