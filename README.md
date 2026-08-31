# t²: A Metric for Decomposing Hazard

This repository contains an a generative simulation for predicting the potential proportion of deaths attributed intrinsic and extrinsic components. It is a publication-staging repository for the code and its input provenance; generated chains, figures, checkpoints, and reported results are intentionally excluded.

The runnable analysis is [run_model_c.jl](run_model_c.jl). The runnable file changes only its six machine-specific path declarations. See [docs/provenance.md](docs/provenance.md) for the integrity record.

## Status

This is research code under validation, not a validated software release. Read [docs/validation-status.md](docs/validation-status.md) before interpreting or publishing results.

**Notice before running the code**

The default workflow is exceptionally computationally expensive: it performs four MCMC runs of 500,000 iterations, with simulation-based likelihood evaluations using 20 replicates of 20,000 individuals. Do not launch the default analysis merely as an installation test.

No software license or formal citation metadata has been assigned yet. Source visibility does not grant permission to reuse or redistribute the software. Data-source terms are documented separately in [data/README.md](data/README.md).

## Repository layout

```text
run_model_c.jl                 Runnable Model C workflow
reference/THE_ONE              Unmodified supplied source snapshot
scripts/check_inputs.jl        Local input-schema validation
scripts/verify_source.jl       Source hash and path-only-diff validation
data/processed/life_table.csv  Compact Japan 2010 upstream-pipeline input
data/restricted/               Local-only Hadza and Aché workbooks
docs/                          Provenance and validation status
output/                        Generated locally and ignored by Git
```

The preprocessing and data-acquisition application is deliberately not copied here. It remains the upstream [Population Project](https://github.com/JS2570/Population-Project). This repository records which upstream snapshot and generated table supplied the included Japan input.

## Requirements

- Julia 1.10.12


Instantiate the pinned environment:

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

## Stage the restricted inputs

Place these exact filenames in `data/restricted/`:

```text
Hadza - Blurton Jones data.xlsx
Ache - Hurtado & Hill.xlsx
```

The workbooks are not distributed here because their redistribution rights have not been established. Their required structure and sourcing notes are in [data/restricted/README.md](data/restricted/README.md).

Validate all inputs without running the MCMC:

```bash
julia --project=. scripts/check_inputs.jl
```

`COUNTRY_TABLE_PATH` is retained in the path block to keep the runnable source structurally faithful, but the current workflow never reads that table and no `country_table.csv` is required.

## Run

After the input check passes:
## Scope

This first code release contains only the human single-λ Model C workflow. Chimpanzee, Sweden/Keyfitz, counterfactual, poster-generation, two-segment, and earlier broken saving variants are outside its scope.
```bash
julia --project=. --threads auto run_model_c.jl
```

The program writes chains, checkpoint files, summaries, diagnostics, and figures under `output/model_c_revised/`. The entire output tree is ignored by Git.


