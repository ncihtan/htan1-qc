import sys
import synapseclient
import os

def download_files(synapse_id):
    syn = synapseclient.Synapse()
    syn.login()  # Assumes user is logged in with credentials or has a .synapseConfig file set up

    # Get all files in the specified Synapse entity
    files = syn.getChildren(synapse_id)

    downloaded_files = []
    for file in files:
        if file['name'].endswith('.fastq.gz'):
            entity = syn.get(file['id'], downloadLocation='.')
            downloaded_files.append(entity.name)
            print(f"Downloaded: {entity.name}")
    
    if not downloaded_files:
        print("No .fastq.gz files found in the specified Synapse ID.")

if __name__ == "__main__":
    synapse_id = sys.argv[1]
    download_files(synapse_id)
