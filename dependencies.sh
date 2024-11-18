#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit
fi

# Install Homebrew (if not installed)
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Install SynapseClient
if ! python3 -c "import synapseclient" &> /dev/null
then
    echo "Installing SynapseClient..."
    pip3 install synapseclient
else
    echo "SynapseClient is already installed."
fi

# Install Nextflow
if ! command -v nextflow &> /dev/null
then
    echo "Installing Nextflow..."
    curl -s https://get.nextflow.io | bash
    mv nextflow /usr/local/bin/
else
    echo "Nextflow is already installed."
fi

# Install FastQC
if ! command -v fastqc &> /dev/null
then
    echo "Installing FastQC..."
    brew install fastqc
else
    echo "FastQC is already installed."
fi

# Install MultiQC
if ! command -v multiqc &> /dev/null
then
    echo "Installing MultiQC..."
    pip3 install multiqc
else
    echo "MultiQC is already installed."
fi