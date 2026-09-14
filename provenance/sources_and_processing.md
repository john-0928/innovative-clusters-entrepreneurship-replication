# Sources and Processing

The main data sources and variable constructions below were extracted from the supplied manuscript. A structural review found no enterprise-level or person-level records in the release package, and the uploader confirmed on 2026-09-13 that the bundled processed datasets may be uploaded publicly. The manuscript remains the source for the intended descriptions but does not fully reproduce data preparation or document every applicable license term.

## Source register

| Variable group | Original source or database | URL given in manuscript | Coverage or use | Remaining requirement |
|---|---|---|---|---|
| New-enterprise registrations | China Industrial and Commercial Registered Enterprise Database | https://microdata.sozdata.com/#/login | Firm name, registered address, registration date, industry classification and operating status; aggregated to city-year | The original firm-level data are excluded. The uploader confirmed public upload of the released city-year aggregates; record the access date, extraction query, and applicable redistribution basis. |
| Innovative industrial cluster pilots | Ministry of Science and Technology of China designation documents and policy announcements | https://www.most.gov.cn/xxgk/xinxifenlei/fdzdgknr/qtwj/qtwj2013/201307/t20130702_106869.html | Pilot cohorts in 2013, 2014, 2017 and 2023 | Archive the full set of designation documents and document city matching. |
| City statistical controls | China City Statistical Yearbook (2009-2024), prefecture statistical yearbooks and official statistical bulletins | http://www.tjnjw.com/diqufb/ | GDP, loans, sector value added, wages, fiscal variables, university students, hospital beds and related city controls | Record exact editions, table numbers, access dates, interpolation decisions and bulletin citations. |
| Patent applications | China National Intellectual Property Administration | http://epub.cnipa.gov.cn/ | Component of technology agglomeration | Record query, application type, date basis and city matching. |
| Digital finance | Peking University Digital Financial Inclusion Index | https://idf.pku.edu.cn/zsbz/bjdxszphjrzs/index.htm | Financing-constraint mechanism | Record index edition, level/dimension selected and access terms. |
| Venture capital | Zero2IPO Private Equity Database | https://max.pedata.cn/client/login/ | City venture-capital investment divided by population | The uploader confirmed public upload of the released city-year values; record the query, access date, and applicable redistribution basis. |
| Resource-based city classification | State Council National Resource-based City Sustainable Development Plan (2013-2020) | Not provided | Heterogeneity grouping | Add authoritative document URL and coding crosswalk. |
| Market integration | Annual median split of a market integration index following Tan et al. (manuscript reference 49) | Not provided | High/low marketization grouping | Identify the underlying index dataset and construction. |
| Coordinates and traffic-line distances | Not identified in the manuscript | Not provided | Geographic, economic-geographic and distance-ring spatial analyses | Identify the routing/coordinate source, coordinate reference system, distance algorithm, access date, and applicable attribution terms. |

## Variable construction extracted from the manuscript

- **Urban entrepreneurial vitality:** newly registered firms per 100 residents in each city-year. The alternative outcome is the natural logarithm of annual newly registered firms.
- **Firm preprocessing:** exclude records with missing addresses, invalid registration dates or abnormal operating statuses; match firms to prefecture-level cities by registered address; aggregate by registration year.
- **Sector classification:** manufacturing and services follow GB/T 4754-2002; services are divided into producer and consumer services. The detailed industry-code crosswalk was not supplied.
- **Policy exposure:** `treat` marks ever-designated pilot cities; `post` begins in the first designation year; `did = treat x post`.
- **Controls:** log GDP; loans/GDP; industrial upgrading index based on sector value-added shares weighted 1, 2 and 3; log average urban employee wage; budget expenditure/revenue; university students per population; log hospital beds.
- **Mechanisms:** talent employment share; a technology composite based on fiscal science-and-technology expenditure and standardized patent applications per capita; Peking University digital finance; population-standardized venture capital; per-capita retail sales; per-capita merchandise exports.
- **Preprocessing:** all continuous variables were winsorized at the 1st and 99th percentiles. Missing observations were reportedly imputed by linear interpolation and cross-checked against local yearbooks and statistical bulletins. Cities with substantial gaps were excluded.
- **Final sample:** balanced panel of 284 cities from 2009 to 2024, yielding 4,544 city-year observations.

## Definition conflicts requiring author confirmation

- The manuscript defines human capital as university students per **million** residents; the embedded Stata label says per **10,000** residents.
- The manuscript defines financial development as year-end financial-institution loans divided by GDP; the embedded Stata label refers to an interpolated logarithmic measure.
- The code and coefficient order imply the coding of `area`, `level` and `market`, but no coding table was supplied.

## Scope of this first DOI record

This first record covers prepared city-level analysis datasets and the supplied Stata empirical-analysis code, including DID, robustness, mechanism and spatial analyses. Raw-to-panel cleaning and variable-construction scripts were not present in the supplied archive and must either be added or described as outside this record's reproducibility boundary. Figure-source data and full figure-generation code will be deposited in a separate DOI record and linked to this one.

## File provenance

- The authoritative Stata files in `data/stata/` are byte-identical copies of the supplied datasets, renamed for portable paths.
- `data/csv/` was generated from the Stata files with categorical conversion disabled so stored codes remain codes.
- The exact supplied analysis script is preserved in `code/original/`.
- `code/master_analysis.do` is a portable working copy with the changes listed in the README.
- `results/tables_csv/` is a text-preserving extraction of the 17 tables in the supplied results document; values were not recalculated.
