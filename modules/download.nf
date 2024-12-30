process DownloadFromCSV {
    input:
    path csv_file

    output:
    path '*.fastq.gz', optional: true

    script:
    """
    python3 ${baseDir}/modules/download_synapse_csv.py ${csv_file}
    """
}
