process QC {
    input:
    path file from params.input_files

    output:
    path 'fastqc_results/*' into qc_results

    script:
    """
    fastqc ${file} --outdir fastqc_results
    """
}