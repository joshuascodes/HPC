#!/usr/bin/env nextflow

Channel
    .fromPath('/data/ficklin_class/AFS505/course_material/data/all.pep')
    .splitFasta(by : 5000, file:true)
    .set { split_ch }

process blast {

    input:
    path 'query' from split_ch

    output:
    file 'output_results' into match_ch

    " blastp -query $query -db /data/ficklin_class/AFS505/course_material/data/swissprot -outfmt 6 -num_threads ${task.cpus} -evalue 1e-6 > output_results "
}

match_ch
    .collectFile(name : 'match_ch.txt')


