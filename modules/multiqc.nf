process MultiQC {
    input:
    path qc_results_files

    output:
    path 'multiqc_report.html'

    script:
    """
    multiqc ${qc_results_files} --outdir .
    """
}
