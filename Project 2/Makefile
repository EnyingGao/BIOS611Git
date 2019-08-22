# Data Cleaning
newdata.csv: Death.csv SDGPM25.csv Project_2_functions.R
	Rscript combine_data.R

newdata1.csv: aap_air_quality_database_2018_v12.csv Project_2_functions.R
	Rscript cleaned_data1.R

newdata2.csv: Database_Source_apport_studies.csv
	Rscript cleaned_data2.R

# Knit Project_2 Rmarkdown
Project_2.html: newdata.csv newdata1.csv newdata2.csv
	Rscript -e "rmarkdown::render('Project_2.Rmd')"

# Workflow      
Project_2_workflow.png: Project_2.html
	make Project_2.html -Bnd | ./makefile2graph/make2graph | dot -Tpng -o Project_2_workflow.png