# Validation status

## Current status

The repository preserves a research implementation for inspection and future validation. It must not yet be described as a statistically validated package, and outputs should not support publication claims until the issues below have been reviewed and resolved or justified.

## Statistical review still required

- **Transformed proposals:** `N₀` and `λ` are proposed on the log scale. Confirm that the intended prior measure and Metropolis–Hastings acceptance calculation include the appropriate proposal-density or Jacobian treatment.
- **Simulation noise:** the likelihood calculation averages stochastic, simulation-derived log-likelihood values. Establish the inferential interpretation and assess whether the resulting transition kernel targets the intended distribution.
- **Convergence:** independently review chain mixing, effective sample sizes, sensitivity to initial values and proposal scales, and consistency across repeated runs.
- **Model interpretation:** validate that the health-threshold parameter `q_e` and the recovered intrinsic/extrinsic death attribution support the intended biological interpretation.

These are validation questions, not changes silently applied by this packaging work. The runnable source intentionally preserves the supplied implementation.

## Reproducibility and checkpoint review still required

- The code does not set or expose a deterministic random seed.
- Checkpoints do not record and restore the random-number-generator state, so a resumed run is not a bit-for-bit continuation of an uninterrupted run.
- Checkpoints do not fingerprint the settings, input data, Julia environment, or prior mode before resuming.
- Stage-completion markers and saved CSVs should be tested under interruption at every population boundary.
- The pinned Julia environment improves dependency reproducibility but does not make stochastic output numerically identical across machines or thread schedules.

## Computational warning

The defaults request four 500,000-iteration runs. Each proposal evaluates a simulation-based likelihood with 20 replicates and 20,000 individuals, and additional simulations are used for posterior recovery and fit summaries. A full run may require substantial compute time. Syntax parsing, dependency loading, and input validation are the appropriate checks for this code-publication phase; the full analysis is deferred.

## Public-release gates

Before making the repository public:

1. Complete or explicitly justify the statistical checks above.
2. Run and document an end-to-end reproduction on the pinned environment.
3. Select a software license.
4. Finalize authorship and citation metadata.
5. Confirm all input-data permissions and attribution text.
