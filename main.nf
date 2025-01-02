nextflow.enable.dsl=2

include { DownloadFromSynapse } from './modules/download.nf'
include { QC } from './modules/qc.nf'
include { MultiQC } from './modules/multiqc.nf'

workflow {
    // Get the Synapse ID from command-line arguments or use a default value
    synapse_id = params.synapse_id ?: 'syn22093319'

    // Download files from Synapse
    downloaded_files = DownloadFromSynapse(synapse_id)

    // Properly filter to get only .fastq.gz files
    fastq_files = downloaded_files.flatten().filter { it.toString().endsWith('.fastq.gz') }

    // Run QC on each .fastq.gz file directly
    qc_results = QC(fastq_files)

    // Run MultiQC on the collected QC results
    MultiQC(qc_results)
}

