nextflow.enable.dsl=2

include { DownloadFromCSV } from "./modules/download.nf"
include { QC; MultiQC } from "./modules/qc_multiqc.nf"

workflow {
    // Get the CSV file path from command-line arguments
    csv_file = file(params.csv_file ?: 'input.csv')

    // Download files specified in the CSV
    downloaded_files = DownloadFromCSV(csv_file)

    // Properly filter to get only .fastq.gz files
    fastq_files = downloaded_files.flatten().filter { it.toString().endsWith('.fastq.gz') }

    // Run QC on each .fastq.gz file
    qc_results = fastq_files | QC

    // Create a channel that points to the results/fastqc directory
    multiqc_input = Channel.fromPath("${projectDir}/results/fastqc")

    // Run MultiQC on the collected QC results
    MultiQC(multiqc_input)
}
