#!/usr/bin/env python3
import requests
import json
from os import listdir
from os.path import isfile, join

prefixes = """@prefix fhir: <http://hl7.org/fhir/> .
@prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix sct:  <http://snomed.info/id#> .
@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .
"""

LEN_START = len("POLAR_WP_1.1_v2-")
LEN_END = len(".json")
mypath = "."
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
onlyjson = [f for f in onlyfiles if f.endswith(".json")]
# onlyjson = ["POLAR_WP_1.1_v2-Polar-WP1.1-00001.json"]
headers = {"Content-Type": "application/fhir+json"}
with open("paths.txt") as path_file:
    paths = path_file.read().splitlines()

full_text = prefixes.splitlines()

num_of_target_patients = 10

for f in onlyjson:
    name = f[LEN_START:-LEN_END]
    with open(f) as file:
        text = file.read()
        r = requests.post("http://localhost:8080/fhir/", data=text, headers=headers)
        if r.status_code == requests.codes.ok:
            patient = requests.get(f"http://localhost:8080/fhir/Patient/{name}",
                                   headers={"accept": "application/fhir+json"},
                                   params={"_format": "rdf"})
            patient_text = [line for line in patient.text.splitlines() if not line.startswith("@prefix")]
            conditions = requests.get("http://localhost:8080/fhir/Condition",
                                      headers={"accept": "application/fhir+json"},
                                      params={"_format": "rdf", "subject": f"Patient/{name}"})
            conditions_text = [line for line in conditions.text.splitlines() if not line.startswith("@prefix")]
            if len(paths) <= 0 or num_of_target_patients <= 0:
                conditions_text = [line.replace("Osteroporose", "Arthritis") for line in conditions_text]
            if len(paths) > 0:
                patient_text[-1] = patient_text[-1][:-1] + ";"
                patient_text.append(f"\tfhir:haplotype\t\t\"{paths.pop()}\" .")
                num_of_target_patients -= 1
            full_text.extend(patient_text)
            full_text.extend(conditions_text)
            print(name)
            # print("\n".join(conditions_text))
        else:
            print(name, json.dumps(r.json(), indent=2, sort_keys=True))

with open("out.ttl", "w+") as out:
    out.writelines([line + "\n" for line in full_text])
