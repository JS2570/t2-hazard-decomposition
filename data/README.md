# Data sources and lineage

This repository separates distributable processed input from locally supplied restricted source material.

## Japan 2010

`processed/life_table.csv` contains the Japan 2010 survivorship curve required by `run_model_c.jl`.

- Original provider: [Human Mortality Database](https://www.mortality.org/)
- Terms: [HMD User Agreement](https://www.mortality.org/Data/UserAgreement)
- Upstream processing: [JS2570/Population-Project](https://github.com/JS2570/Population-Project)
- Upstream code snapshot: `1e39c2bcd482576477511dff7a1ea77defec7875`
- Local generated source table: `data/processed/data120/hmd.csv`
- Extraction: `ISO3 == "JPN"`, `Year == 2010`; retain `ISO3,Year,Age,lx`

The HMD agreement identifies constructed HMD data as available under CC BY 4.0, subject to its attribution and source-identification requirements. Users should review the linked agreement for the current terms and cite HMD in resulting work.

## Hadza and Aché

The preserved analysis also expects survivorship workbooks associated with Blurton Jones (Hadza) and Hurtado and Hill (Aché). Redistribution rights for the local workbooks have not been established, so neither their values nor derivatives are committed.

Users must obtain authorized copies independently and place them under `data/restricted/` as described in [restricted/README.md](restricted/README.md). The `.gitignore` rules prevent those files from being committed accidentally.

## Generated outputs

MCMC chains, summaries, checkpoints, figures, and fit tables are generated under `output/` and are intentionally excluded from this code-publication phase.
