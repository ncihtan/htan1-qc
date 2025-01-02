
# Nextflow Pipeline for Genomic Data QC and MultiQC Reporting

## Overview
This pipeline is designed to download `.fastq.gz` files from a Synapse repository, run quality control (QC) using FastQC, and generate a combined report using MultiQC.

## Requirements
- **Nextflow**: Install from [nextflow.io](https://www.nextflow.io/).
- **Python**: Ensure Python 3.x is installed.
- **SynapseClient**: Install using `pip install synapseclient`.
- **FastQC** and **MultiQC**: Ensure these tools are installed and available in your `PATH`, or use containers if preferred.
- **Docker/Singularity** (optional): To use containers for reproducibility.

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/project.git
   cd project
   ```

2. Ensure dependencies are installed:
   ```bash
   pip install synapseclient
   ```

3. Log in to Synapse:
   - Ensure you are logged in using `synapse login` or have a `.synapseConfig` file set up in your home directory.

## Running the Pipeline
Run the pipeline with a prepared sample sheet (csv):
```bash
nextflow run main.nf --input_csv /absolute/path/to/input.csv
```

### Parameters
input_csv: Absolute path to the input CSV file. This file should have two columns:

- filename: The exact name of the file to download (e.g., file1.fastq.gz).
- synapse_id: The Synapse ID containing the file (e.g., syn12345678)

## Output
- The pipeline generates a `multiqc_report.html` file that combines all the QC outputs in a single report.
- Individual FastQC result files are stored in the `fastqc_results/` directory.

## Notes
- The pipeline only processes `.fastq.gz` files. Ensure your Synapse data folder contains these files.
- If using Docker or Singularity, adjust the `nextflow.config` to include container paths.

## Troubleshooting
- Ensure Synapse authentication is set up properly.
- Verify that `FastQC` and `MultiQC` are installed or available in your container.

## Example Usage
Use `input.csv'` in `/test` to test the pipeline
```bash
nextflow run main.nf --input_csv /path/to/input.csv
```
This will download all `.fastq.gz` files from the specified Synapse ID, run QC on them, and produce a `multiqc_report.html` summarizing the QC results.
