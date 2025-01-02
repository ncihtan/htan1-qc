import sys
import synapseclient
import os
import csv

def download_files_from_csv(csv_file):
    syn = synapseclient.Synapse()
    syn.login()  # Assumes user is logged in with credentials or has a .synapseConfig file set up

    # Read the CSV file
    with open(csv_file, 'r') as file:
        reader = csv.DictReader(file)
        
        for row in reader:
            synapse_id = row.get('synapse_id')
            filename = row.get('filename')

            if not synapse_id or not filename:
                print("Missing 'synapse_id' or 'filename' in CSV row. Skipping...")
                continue

            # Fetch files in the Synapse folder/entity
            try:
                files = syn.getChildren(synapse_id)
                for file in files:
                    if file['name'] == filename:
                        entity = syn.get(file['id'], downloadLocation='.')
                        print(f"Downloaded: {entity.name}")
                        break
                else:
                    print(f"File '{filename}' not found in Synapse ID '{synapse_id}'.")
            except Exception as e:
                print(f"Error processing Synapse ID '{synapse_id}': {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 download_synapse.py <input_csv>")
        sys.exit(1)

    input_csv = sys.argv[1]
    input_csv_path = os.path.abspath(input_csv) 

    if not os.path.exists(input_csv_path):
        print(f"Input CSV file '{input_csv_path}' does not exist.")
        sys.exit(1)

    download_files_from_csv(input_csv_path)