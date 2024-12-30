process DownloadFromSynapse {
    input:
    val synapse_id

    output:
    path '*.fastq.gz', optional: true

    script:
    """
    python3 ${baseDir}/modules/download_synapse.py ${synapse_id}
    """
}
