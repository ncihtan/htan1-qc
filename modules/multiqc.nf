process MultiQC {
    input:
    path results from params.input_results

    output:
    path 'multiqc_report.html'

    script:
    """
    multiqc ${results} --outdir .
    """
}