nextflow.enable.dsl=2

include { DownloadFromSynapse } from './modules/download.nf'
include { QC } from './modules/qc.nf'
include { MultiQC } from './modules/multiqc.nf'

workflow {
    // Get the Synapse ID from command-line arguments or use a default value
    synapse_id = params.synapse_id ?: 'syn22093319'  // Replace with your default Synapse ID if needed

    downloaded_files = DownloadFromSynapse(synapse_id)

    fastq_files = downloaded_files.filter { it.endsWith('.fastq.gz') }

    // Run QC only on .fastq.gz files
    if (fastq_files.size() > 0) {
        println "Found ${fastq_files.size()} .fastq.gz files for QC."
        qc_results = QC(fastq_files)
        MultiQC(qc_results)
    } else {
        println "No .fastq.gz files found for QC."
    }
}
