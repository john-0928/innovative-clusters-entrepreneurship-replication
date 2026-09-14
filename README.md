# How innovative industrial clusters affect entrepreneurship in Chinese cities

This draft package is the first of two planned research records. It contains processed city-level analysis datasets, Stata empirical-analysis code, spatial-weight inputs, precomputed spatial matrices, and reported result tables supporting the manuscript *How innovative industrial clusters affect entrepreneurship in Chinese cities*. The primary balanced panel covers 284 Chinese prefecture-level cities from 2009 through 2024 (4,544 city-year observations). The study treats the phased 2013, 2014, 2017 and 2023 pilot cohorts as a quasi-natural experiment. Figure-source data and full figure-generation code will be deposited separately and linked by DOI.

## Important publication status

This package is technically organized for a Zenodo draft. A structural disclosure review found no enterprise-level or person-level records, and the uploader confirmed on 2026-09-13 that the bundled processed datasets may be uploaded publicly. Before final Zenodo publication, complete the remaining creator metadata, license selection, provenance details, and software-environment items in `TODO_BEFORE_PUBLICATION.md`.

## Recommended Zenodo record type

Use a **Dataset** record titled as an analysis-data and Stata-code package. This first DOI covers the prepared empirical datasets and the code that analyses them. Create a second Zenodo record later for figure-source data and full figure-generation code, then link the two records with related identifiers.

## Directory structure

```text
code/
  master_analysis.do              portable analysis script
  check_dependencies.do           non-installing dependency check
  original/                       exact supplied script
data/
  stata/                          authoritative .dta files with normalized names
  csv/                            preservation-friendly mirrors
  dataset_inventory.csv           file roles, dimensions, keys, and checksums
  data_dictionary.csv             variable labels, definitions, and missingness
documentation/
  DATA_SCOPE_AND_DISCLOSURE_REVIEW.md review confirming the released data are aggregate
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
.zenodo.json                       GitHub-to-Zenodo metadata
CITATION.cff                       citation metadata for GitHub
LICENSE                            file-level licensing summary
```

## How to run

1. Extract the archive to a writable folder.
2. Open Stata and change the working directory to the package root, the folder containing this README.
3. Run `do "code/check_dependencies.do"`.
4. Install or restore any missing user-written packages in a controlled environment and record their versions.
5. Run `do "code/master_analysis.do"`.

The cleaned script uses only relative paths and creates its own output folders. It also sets the random seed to `10101` before the placebo simulation. The original code did not set a seed before that simulation, so a newly generated placebo distribution may not match the supplied result exactly.

## Changes made to the working copy

- Replaced the original hard-coded desktop paths with project-relative paths.
- Corrected the extra quotation mark in the `w1.dta` load command.
- Reloaded the main panel before the PSM-DID block. The original script left the placebo-simulation dataset in memory, which does not contain the variables required by PSM-DID.
- Added a fixed seed before the placebo simulation and exported the placebo figure.
- Redirected generated tables, figures, logs, and derived data to `outputs/`.
- Exported the descriptive treatment-group means that were previously calculated and then discarded.
- Preserved the exact original do-file in `code/original/`.

These changes address portability and an evident state-management error. They do not validate the statistical specifications or guarantee numerical equality with the submitted tables. This first record begins from prepared analysis datasets. Raw-to-panel cleaning and variable-construction code were not present in the supplied archive. Figure-source data and full figure-generation code are intentionally reserved for a second linked record.

## Data notes

- The data are city-level or city-pair aggregates. No person-level fields were identified by the structural review.
- Geographic names, city identifiers, and coordinates are present in some files. The package contains only city-level or city-pair analytical data; it does not contain firm names, registered addresses, legal representatives, contacts, telephone numbers, email addresses, personal identifiers, or firm-level registration rows. The uploader confirmed that these bundled processed datasets may be uploaded publicly. The original enterprise-level registration microdata remain excluded.
- Major sources identified in the manuscript are the China Industrial and Commercial Registered Enterprise Database, China City Statistical Yearbook, Ministry of Science and Technology policy documents, China National Intellectual Property Administration, Peking University Digital Financial Inclusion Index, and Zero2IPO Private Equity Database.
- The manuscript defines the human-capital variable per million residents, but the Stata label says per 10,000 residents. It defines financial development as loans/GDP, while the Stata label suggests an interpolated logarithmic measure. Resolve both conflicts before release.
- The three precomputed weight matrices contain 284 rows and 284 columns but no explicit row identifier. Their row and column ordering must be documented and verified before release.
- The exact original do-file contains the former local Windows username in its path strings. Decide whether to retain that audit copy in the public release or publish only the portable script.
- CSV files are convenience copies for preservation and inspection. The `.dta` files remain authoritative because CSV cannot preserve Stata storage types, variable labels, value labels, or extended missing values.

## Verification performed

All 13 Stata files were readable. Candidate keys were unique and complete for the primary city-year panels, the traffic-distance pair table, and the source matrices where identifiers were present. The cleaned code passed a static path and syntax-risk audit, but it was not executed because Stata was not available in the preparation environment.

## License

The Stata code under `code/` is licensed under the MIT License (`LICENSE-code.txt`). Data, documentation, metadata, and result tables are licensed under the Creative Commons Attribution 4.0 International License (`LICENSE-data.txt`), except for third-party rights explicitly noted in those files.

## Citation

Citation metadata is provided in `CITATION.cff`. After Zenodo assigns a DOI, cite the specific published version and add the DOI to the repository README and citation metadata.

After the second figure-data-and-code record is published, add its DOI to this record with the relationship **Is supplemented by** (`IsSupplementedBy`). Add this first record's DOI to the figure record with **Is supplement to** (`IsSupplementTo`).

For GitHub-to-Zenodo archiving, Zenodo uses `.zenodo.json` for the archived release, while GitHub uses `CITATION.cff` to display citation guidance.
