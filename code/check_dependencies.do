********************************************************************************
* Dependency check
* Run from the package root before master_analysis.do.
* This script does not install anything or alter the user's Stata environment.
********************************************************************************

clear
local required reghdfe eststo esttab psmatch2 pstest psgraph ivreg2 bacondecomp csdid geodist spatwmat spatgsa xsmle
local missing ""

foreach command of local required {
    capture which `command'
    if _rc {
        display as error "Missing command: `command'"
        local missing "`missing' `command'"
    }
    else {
        display as result "Found command: `command'"
        which `command'
    }
}

if "`missing'" != "" {
    display as error "Install or restore the packages providing these commands before running the analysis:`missing'"
    exit 499
}

display as result "All required user-written commands were found."
