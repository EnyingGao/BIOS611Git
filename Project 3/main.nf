#! /usr/bin/env nextflow

params.in_files = 'p2_abstracts/abs*'

in_files = Channel.fromPath( params.in_files )

process summary_of_single_abstract {
    container 'rocker/tidyverse'
    
    input:
    file i from in_files

    output:
    file '*.csv' into csv_out

    script:
    """
    Rscript $baseDir/bin/project3firstpart.R $i 
    """
}

process combine_all_abstracts {
    container 'rocker/tidyverse'
    publishDir './', mode: 'copy'
    
    input:
    file i from csv_out.collectFile(name: 'summary.csv', newLine: true)

    output:
    file 'combine.csv' into combine_csv_out

    script:
    """
    Rscript $baseDir/bin/project3secondpart.R $i
    """
}

process summary_of_all_abstracts {
    container 'rocker/tidyverse'
    publishDir './', mode: 'copy'

    input:
    file i from combine_csv_out

    output:
    file 'final.csv' into final_csv_out

    script:
    """
    Rscript $baseDir/bin/project3thirdpart.R $i
    """
}