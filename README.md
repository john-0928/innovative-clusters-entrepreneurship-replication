# How innovative industrial clusters affect entrepreneurship in Chinese cities

This draft replication package contains the Stata code, processed city-level panel datasets, spatial-weight inputs, precomputed spatial matrices, and reported result tables supporting the manuscript *How innovative industrial clusters affect entrepreneurship in Chinese cities*. The primary balanced panel covers 284 Chinese prefecture-level cities from 2009 through 2024 (4,544 city-year observations). The study treats the phased 2013, 2014, 2017 and 2023 pilot cohorts as a quasi-natural experiment.

This revised draft also contains the curated Python code, figure-ready input
tables, required map layers, and selected high-resolution exports for the current
main and supplementary figures. All included figure scripts use package-relative
paths and were rerun successfully during package assembly.

## Important publication status

This package is technically organized for a Zenodo draft, but it is not ready for public release until the authors complete the rights, provenance, metadata, and software-environment items in `TODO_BEFORE_PUBLICATION.md`. The manuscript identifies the main data sources, but access dates, exact editions, construction code, and redistribution terms for the processed city-level indicators remain incomplete.

## Recommended Zenodo record type

Use one combined **Dataset** record titled as a replication package, with the Stata code included. This is preferable here because the code depends directly on the bundled data and the data are the larger research object. If a journal explicitly requires separate data and code DOIs, split this draft only after confirming that requirement and link the two records with related identifiers.

## Directory structure

```text
code/
  master_analysis.do              portable analysis script
  check_dependencies.do           non-installing dependency check
  original/                       exact supplied script
  figures/                        portable Python figure scripts and runner
data/
  stata/                          authoritative .dta files with normalized names
  csv/                            preservation-friendly mirrors
  dataset_inventory.csv           file roles, dimensions, keys, and checksums
  data_dictionary.csv             variable labels, definitions, and missingness
  figure_inputs/                  figure-ready workbooks and event-time CSV
documentation/
  final_result_tables.docx         exact supplied results document
results/
  tables_csv/                      text-preserving CSV extraction of all 17 tables
environment/
  STATA_DEPENDENCIES.md            required commands and version-capture instructions
metadata/
  zenodo_metadata_template.md      fields to paste into a Zenodo draft
  manuscript_extracted_metadata.md metadata and availability details extracted from the paper
provenance/
  sources_and_processing.md        provenance form to complete
outputs/                            generated when the cleaned script is run
figures/
  final/                            selected manuscript/reference exports
  generated/                        outputs from the reproducibility test run
maps/                               map layers required by the figure scripts
.zenodo.json.template              GitHub-to-Zenodo metadata template
```

## How to run

1. Extract the archive to a writable folder.
2. Open Stata and change the working directory to the package root, the folder containing this README.
3. Run `do "code/check_dependencies.do"`.
4. Install or restore any missing user-written packages in a controlled environment and record their versions.
5. Run `do "code/master_analysis.do"`.

To reproduce the figures, install the Python packages listed in
`environment/requirements-figures.txt`, then run:

```bash
python code/figures/run_all.py
```

The figure runner writes to `figures/generated/` and does not overwrite
`figures/final/`.

The cleaned script uses only relative paths and creates its own output folders. It also sets the random seed to `10101` before the placebo simulation. The original code did not set a seed before that simulation, so a newly generated placebo distribution may not match the supplied result exactly.

## Changes made to the working copy

- Replaced the original hard-coded desktop paths with project-relative paths.
- Corrected the extra quotation mark in the `w1.dta` load command.
- Reloaded the main panel before the PSM-DID block. The original script left the placebo-simulation dataset in memory, which does not contain the variables required by PSM-DID.
- Added a fixed seed before the placebo simulation and exported the placebo figure.
- Redirected generated tables, figures, logs, and derived data to `outputs/`.
- Exported the descriptive treatment-group means that were previously calculated and then discarded.
- Preserved the exact original do-file in `code/original/`.
- Added a curated, numbered set of portable Python plotting scripts.
- Added figure-ready source tables and the map layers actually referenced by the
  scripts.
- Added selected final PNG/PDF/SVG exports and excluded redundant historical
  drafts and very large AI/SVG working files.

These changes address portability and an evident state-management error. They do not validate the statistical specifications or guarantee numerical equality with the submitted tables. The manuscript also states that data-cleaning, variable-construction and figure-generation code will be available, but those components were not present in the supplied code archive.

## Data notes

- The data are city-level or city-pair aggregates. No person-level fields were identified by the structural review.
- Geographic names and city identifiers are present in some files. The manuscript states that the enterprise-level registration microdata cannot be publicly shared because of database access and commercial licensing restrictions. Confirm separately that redistribution of the processed city-year aggregates is permitted.
- Major sources identified in the manuscript are the China Industrial and Commercial Registered Enterprise Database, China City Statistical Yearbook, Ministry of Science and Technology policy documents, China National Intellectual Property Administration, Peking University Digital Financial Inclusion Index, and Zero2IPO Private Equity Database.
- The manuscript defines the human-capital variable per million residents, but the Stata label says per 10,000 residents. It defines financial development as loans/GDP, while the Stata label suggests an interpolated logarithmic measure. Resolve both conflicts before release.
- The three precomputed weight matrices contain 284 rows and 284 columns but no explicit row identifier. Their row and column ordering must be documented and verified before release.
- The exact original do-file contains the former local Windows username in its path strings. Decide whether to retain that audit copy in the public release or publish only the portable script.
- CSV files are convenience copies for preservation and inspection. The `.dta` files remain authoritative because CSV cannot preserve Stata storage types, variable labels, value labels, or extended missing values.

## Verification performed

All 13 Stata files were readable. Candidate keys were unique and complete for the primary city-year panels, the traffic-distance pair table, and the source matrices where identifiers were present. The cleaned code passed a static path and syntax-risk audit, but it was not executed because Stata was not available in the preparation environment.

## Citation

Replace the placeholders in `CITATION.cff.template` and the Zenodo metadata template. After Zenodo assigns a DOI, cite the specific published version rather than this draft filename.

For GitHub-to-Zenodo archiving, complete and rename `CITATION.cff.template` to `CITATION.cff` and `.zenodo.json.template` to `.zenodo.json` before creating the GitHub release. If both metadata files are present, Zenodo uses `.zenodo.json` for the archived release, while GitHub uses `CITATION.cff` to display citation guidance.
