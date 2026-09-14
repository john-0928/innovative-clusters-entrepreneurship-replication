# Data Scope and Disclosure Review

Review date: 2026-09-13

## Scope reviewed

The review covered the CSV mirrors of all 13 released Stata datasets. The Stata and CSV versions were previously verified to have matching dimensions, and the Stata files are byte-identical to the supplied analytical datasets.

## Findings

- The main, placebo, and spatial analytical panels contain city-year observations. The main panel has 4,544 records: 284 cities over 16 years.
- The traffic-distance dataset contains all 80,656 directed city pairs (284 x 284).
- The remaining files contain annual Moran's I results, city coordinates and identifiers, or 284 x 284 spatial-weight matrices.
- No enterprise-level registration rows were found.
- No fields for firm name, registered address, legal representative, contact person, telephone number, mobile number, email address, personal identity number, or unified social credit code were found.
- The only readable geographic descriptors are city name, province name, broad region, and Hu-line side in the placebo dataset. Other files primarily use city identifiers, coordinates, analytical variables, or matrix entries.
- The uploader confirmed that the bundled processed datasets may be uploaded publicly. The original enterprise-level registration database is not included.

## Remaining publication metadata

This structural review establishes the data level and absence of direct firm/person identifiers. The repository should still retain source attribution, access dates, data-construction documentation, and a data license compatible with the applicable source terms.
