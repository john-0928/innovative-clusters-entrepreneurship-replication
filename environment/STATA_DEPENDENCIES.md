# Stata Environment and Dependencies

The supplied analysis script did not state a Stata release or package versions. Reproducibility therefore requires a fresh-environment run and a version record before publication.

## Built-in commands used

The script uses standard data-management and estimation commands including `collapse`, `merge`, `reshape`, `xtset`, `xtreg`, `hausman`, `lrtest`, `test`, `testnl`, `postfile`, and `graph export`.

## User-written commands detected

| Commands | Common package or module | Purpose |
|---|---|---|
| `reghdfe` | reghdfe, with supporting dependencies such as ftools | High-dimensional fixed-effects regression |
| `eststo`, `esttab` | estout | Store and export estimates |
| `psmatch2`, `pstest`, `psgraph` | psmatch2 | Propensity-score matching diagnostics |
| `ivreg2` | ivreg2, often with ranktest | Instrumental-variable estimation |
| `bacondecomp` | bacondecomp | Goodman-Bacon decomposition |
| `csdid` | csdid, with its dependencies | Heterogeneity-robust DID estimation |
| `geodist` | geodist | Great-circle distance calculation |
| `spatwmat`, `spatgsa` | spatial-analysis add-ons; exact installation source must be recorded | Spatial weights and global autocorrelation |
| `xsmle` | xsmle | Spatial panel-data models |

Run `code/check_dependencies.do` to print the installed ado-file locations. Do not add automatic installation commands to the replication script: automatic installs can silently retrieve newer package releases and change results.

Before publication, save the following to a plain-text environment record:

```stata
about
which reghdfe
which esttab
which psmatch2
which ivreg2
which bacondecomp
which csdid
which geodist
which spatwmat
which spatgsa
which xsmle
adopath
```

The package was statically prepared without Stata, so successful execution and result equivalence remain blocking checks.
