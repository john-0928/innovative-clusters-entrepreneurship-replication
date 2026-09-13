# TODO Before Publication

Do not publish the Zenodo record until every blocking item is resolved.

## Blocking metadata

- [x] Extracted manuscript title: *How innovative industrial clusters affect entrepreneurship in Chinese cities*.
- [ ] Add every creator in publication order, including affiliation and ORCID where available.
- [x] Added a repository description based on the manuscript abstract.
- [ ] Add the journal article DOI as a related identifier after it exists. Do not enter the article DOI as the DOI of this dataset.
- [ ] Confirm the publication date and package version.

## Blocking data-rights and provenance review

- [ ] Major sources were extracted from the manuscript; still identify the source of population, internet, coordinates, traffic distances, market integration, talent employment, domestic demand and external demand, and map each released variable to its exact source.
- [ ] Source URLs were extracted where present; still record database editions, access dates, extraction filters and all transformations performed outside the supplied do-file.
- [ ] Confirm that each source license or data-use agreement permits public redistribution of the derived observations.
- [ ] If any source prohibits redistribution, remove or restrict the affected data and publish executable construction instructions plus a permitted derived subset instead.
- [ ] Confirm that city names, geographic identifiers, and coordinates do not create contractual or disclosure concerns under the source agreements.
- [ ] Review and, if appropriate, remove `code/original/master_data_analysis_code_original.do`, which preserves a local Windows username in its path strings.
- [ ] Scrub or approve the Word document's embedded author and last-editor metadata before publication.

## Blocking reproducibility review

- [ ] Record the exact Stata release and operating system used for the submitted results.
- [ ] Record versions and installation sources for every user-written command listed in `environment/STATA_DEPENDENCIES.md`.
- [ ] Run `code/check_dependencies.do` and then `code/master_analysis.do` in a fresh environment.
- [ ] Compare every generated table and figure with the supplied final results and explain any difference.
- [x] Add the current full figure-generation code and figure-ready inputs.
- [ ] Add the still-missing raw-data cleaning and variable-construction code promised in the manuscript's Code availability statement, or revise that statement before publication.
- [ ] Decide whether seed `10101` is the intended seed for the placebo simulation. The original script did not define one before that block.
- [ ] Verify that the row and column order of all three 284 x 284 weight matrices exactly matches the city ordering of the spatial panel.
- [ ] Confirm the unit and construction of traffic distance and the coordinate reference system for longitude/latitude.
- [ ] Confirm that the PSM-DID reload inserted in the cleaned script reflects the authors' intended analysis state.
- [ ] Verify the authoritative source, redistribution terms and publication/cartographic-review requirements for every file under `maps/` before public release.

## Blocking documentation and licensing

- [ ] Review the manuscript-derived fields added to `data/data_dictionary.csv`, resolve the financial-development and human-capital definition conflicts, and complete variables still marked undocumented.
- [ ] Choose a code license and replace `LICENSE-code.txt.template` with the final license file.
- [ ] Choose a data/documentation license that is compatible with every upstream source and replace `LICENSE-data.txt.template`.
- [ ] Update copyright-holder names.
- [ ] Remove draft/template suffixes only after all placeholders are complete.

## Final Zenodo checks

- [ ] Create a Zenodo draft and choose resource type **Dataset** for the combined package.
- [ ] Upload the final ZIP, fill metadata, and save the draft.
- [ ] Optionally reserve the DOI before publication if it must appear in the paper or README.
- [ ] Preview the record and download the uploaded ZIP once to verify integrity.
- [ ] Publish only after coauthors approve the files, metadata, rights, and visibility setting.
