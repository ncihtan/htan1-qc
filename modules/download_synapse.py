import sys
import pandas as pd
import synapseclient
import os

def download_files_from_csv(csv_file):
    # Initialize Synapse client
    syn = synapseclient.Synapse()
    syn.login()  # Assumes user credentials are set up

    # Load CSV file
    df = pd.read_csv(csv_file)

    downloaded_files = []
    for _, row in df.iterrows():
        synapse_id = row['synapse_id']
        file_name = row['file_name']

        # Fetch file from Synapse
        entity = syn.get(synapse_id, downloadLocation='.')
        if entity.name == file_name:
            downloaded_files.append(entity.name)
            print(f"Downloaded: {entity.name}")
        else:
            print(f"File {file_name} not found for Synapse ID {synapse_id}")

    if not downloaded_files:
        print("No files downloaded from the provided CSV file.")

if __name__ == "__main__":
    csv_file = sys.argv[1]
    download_files_from_csv(csv_file)
