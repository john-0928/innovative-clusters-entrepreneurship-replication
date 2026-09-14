# TODO Before Publication

Do not publish the Zenodo record until every blocking item is resolved.

## Blocking metadata

- [x] Extracted manuscript title: *How innovative industrial clusters affect entrepreneurship in Chinese cities*.
- [x] Corrected the creator list on 2026-09-14 to five authors in this order: Biao Li, Mengtong Chen, Siyang She, Jihong Chen, and Jianghao Xu.
- [x] Recorded Jihong Chen and Jianghao Xu as corresponding authors; removed the previous incorrect corresponding-author designation for Siyang She.
- [x] Added the supplied corresponding-author emails for Jihong Chen and Jianghao Xu.
- [x] Recorded Biao Li's affiliation as China Center for Special Economic Zone Research, Shenzhen University, and Mengtong Chen's affiliation as Shenzhen University.
- [ ] Add ORCIDs for the corrected five-author list if any are available; otherwise omit them.
- [x] Added a repository description based on the manuscript abstract.
- [ ] Add the journal article DOI as a related identifier after it exists. Do not enter the article DOI as the DOI of this dataset.
- [ ] Confirm the publication date and package version.

## Data scope, rights and provenance

- [x] Confirmed by structural review that the package contains no firm-level or person-level records.
- [x] The uploader confirmed on 2026-09-13 that the bundled processed datasets may be uploaded publicly.
- [ ] Major sources were extracted from the manuscript; still identify the source of population, internet, coordinates, traffic distances, market integration, talent employment, domestic demand and external demand, and map each released variable to its exact source.
- [ ] Source URLs were extracted where present; still record database editions, access dates, extraction filters and all transformations performed outside the supplied do-file.
- [ ] Record the source-license or data-use basis supporting public redistribution of the derived observations.
- [ ] If a later source review identifies a restriction, remove the affected data or replace it with permitted construction instructions and a permitted derived subset.
- [ ] Confirm that city names, geographic identifiers, and coordinates do not create contractual or disclosure concerns under the source agreements.
- [ ] Review and, if appropriate, remove `code/original/master_data_analysis_code_original.do`, which preserves a local Windows username in its path strings.
- [ ] Scrub or approve the Word document's embedded author and last-editor metadata before publication.

## Blocking reproducibility review

- [ ] Record the exact Stata release and operating system used for the submitted results.
- [ ] Record versions and installation sources for every user-written command listed in `environment/STATA_DEPENDENCIES.md`.
- [ ] Run `code/check_dependencies.do` and then `code/master_analysis.do` in a fresh environment.
- [ ] Compare every generated table and figure with the supplied final results and explain any difference.
- [ ] Add the missing raw-to-panel cleaning and variable-construction code, or state clearly that this record begins from prepared analysis datasets.
- [ ] Revise the manuscript's Code availability statement so it distinguishes this analysis-data-and-Stata-code DOI from the planned separate figure-data-and-code DOI.
- [ ] Decide whether seed `10101` is the intended seed for the placebo simulation. The original script did not define one before that block.
- [ ] Verify that the row and column order of all three 284 x 284 weight matrices exactly matches the city ordering of the spatial panel.
- [ ] Confirm the unit and construction of traffic distance and the coordinate reference system for longitude/latitude.
- [ ] Confirm that the PSM-DID reload inserted in the cleaned script reflects the authors' intended analysis state.

## Blocking documentation and licensing

- [ ] Review the manuscript-derived fields added to `data/data_dictionary.csv`, resolve the financial-development and human-capital definition conflicts, and complete variables still marked undocumented.
- [x] Selected the MIT License for the Stata code and created `LICENSE-code.txt`.
- [x] Selected CC BY 4.0 for data and documentation and created `LICENSE-data.txt`.
- [x] Added the corrected five authors as copyright holders.
- [x] Converted the GitHub/Zenodo citation, metadata, and license templates required for the first release into final root files.

## Final Zenodo checks

- [ ] Create the first Zenodo draft and choose resource type **Dataset** for this analysis-data-and-Stata-code package.
- [ ] Upload the final ZIP, fill metadata, and save the draft.
- [ ] Optionally reserve the DOI before publication if it must appear in the paper or README.
- [ ] Preview the record and download the uploaded ZIP once to verify integrity.
- [ ] Publish only after coauthors approve the files, metadata, rights, and visibility setting.
- [ ] After the figure-data-and-code record is published, link the two Zenodo records using **Is supplemented by** / **Is supplement to**.
