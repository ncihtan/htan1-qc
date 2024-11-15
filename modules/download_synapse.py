import sys
import synapseclient
import os

def download_files(synapse_id):
    syn = synapseclient.Synapse()
    syn.login()  # Assumes user is logged in with credentials or has a .synapseConfig file set up

    # Get all files in the specified Synapse entity
    files = syn.getChildren(synapse_id)

    for file in files:
        if file['name'].endswith('.fastq.gz'):
            entity = syn.get(file['id'], downloadLocation='.')
            print(f"Downloaded: {entity.name}")

if __name__ == "__main__":
    synapse_id = sys.argv[1]
    download_files(synapse_id)