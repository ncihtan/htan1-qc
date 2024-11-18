nextflow.enable.dsl=2

process QC {
    input:
    path fastq_file

    output:
    path "fastqc_results/*", emit: qc_output

    script:
    """
    mkdir -p fastqc_results
    fastqc ${fastq_file} --outdir fastqc_results
    """
}
