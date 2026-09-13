# Reproduction check

Package assembly and test date: 2026-09-13 (Asia/Shanghai).

The following figure scripts were executed successfully from inside this staged
package after all absolute paths had been replaced by package-relative paths:

- `01_figure1_policy_batches_map.py`
- `02_figure2_entrepreneurship_map_trend.py`
- `03a_baseline_forest.py`
- `03b_parallel_trends.py`
- `04_mechanism_coefficients.py`
- `05a_heterogeneity_maps.py`
- `05b_heterogeneity_forest.py`
- `06_spatial_effects.py`
- `S01_S02_robustness_iv.py`

The generated test copies were removed after verification to avoid duplicating
large map exports. The selected reference outputs remain in `figures/final/`, and
all test outputs can be recreated with `python code/figures/run_all.py`.

Python syntax compilation also passed for every included plotting module and the
runner. Statistical equivalence to the Stata tables and all external data/map
redistribution rights still require author review as listed in
`TODO_BEFORE_PUBLICATION.md`.
