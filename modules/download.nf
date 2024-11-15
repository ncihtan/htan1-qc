process DownloadFromSynapse {
    input:
    val synapse_id from params.synapse_id

    output:
    path '*.fastq.gz'

    script:
    """
    python download_synapse.py ${synapse_id}
    """
}