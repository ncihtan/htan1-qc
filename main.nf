nextflow.enable.dsl=2

include { DownloadFromSynapse } from "./modules/download.nf"
include { QC; MultiQC } from "./modules/qc_multiqc.nf"

workflow {
    // Get the Synapse ID from command-line arguments or use a default value
    synapse_id = params.synapse_id ?: 'syn22093319'

    // Download files from Synapse
    downloaded_files = DownloadFromSynapse(synapse_id)

    // Properly filter to get only .fastq.gz files
    fastq_files = downloaded_files.flatten().filter { it.toString().endsWith('.fastq.gz') }

    // Run QC on each .fastq.gz file
    qc_results = fastq_files | QC

    // Create a channel that points to the results/fastqc directory
    multiqc_input = Channel.fromPath("${projectDir}/results/fastqc")

    // Run MultiQC on the collected QC results
    MultiQC(multiqc_input)
}
