nextflow.enable.dsl=2

process QC {
    input:
    path fastq_file

    output:
    path "*.html", emit: qc_html
    path "*.zip", emit: qc_zip

    publishDir "${projectDir}/results/fastqc", mode: 'copy'

    script:
    """
    fastqc ${fastq_file} --outdir .
    """
}

process MultiQC {
    input:
    path multiqc_results

    output:
    path "multiqc_report.html"

    publishDir "${projectDir}/results", mode: 'copy'

    script:
    """
    multiqc ${projectDir}/results/fastqc --outdir .
    """
}

