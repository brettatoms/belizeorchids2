#!/usr/bin/env python3

import os
import csv
import json
from pathlib import Path

wfo_orchidaceae_classification_path = (
    Path(os.environ["HOME"])
    / "Downloads"
    / "Orchidaceae"
    / "Orchidaceae_wfo-7000000429"
    / "classification.csv"
)

data_path = "belizeorchids/data/orchids.json"

with open(wfo_orchidaceae_classification_path) as classifications:
    reader = csv.DictReader(classifications)
    with open(data_path) as orchid_data_f:
        orchid_data = json.load(orchid_data_f)
        for row in reader:
            scientificName = row["scientificName"]
            if scientificName in orchid_data:
                orchid_data[scientificName]["wfo_taxon_id"] = row["taxonID"]
                orchid_data[scientificName]["ipni_id"] = row["scientificNameID"]

        print(json.dumps(orchid_data, indent=4))
