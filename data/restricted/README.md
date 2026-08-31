# Restricted local inputs

This directory is intentionally empty in Git. Place authorized local copies of the following workbooks here:

```text
Hadza - Blurton Jones data.xlsx
Ache - Hurtado & Hill.xlsx
```

Do not commit either workbook or exports derived from their values until redistribution permission has been confirmed.

## Schema expected by `run_model_c.jl`

Both files use the first worksheet.

### Hadza

- The first column is interpreted as age and should be numeric or numeric text.
- A column named `lx` supplies survivorship.
- Rows with non-numeric age or `lx` are discarded.
- Remaining rows are sorted by age and survivorship is normalized to its first retained value.

The locally verified source workbook had a single populated sheet with columns `Age`, `lx`, and `mx`; the current MCMC loader uses only age and `lx`.

### Aché

- A column named `lx` supplies survivorship.
- Row order is interpreted as consecutive ages `0:(n-1)`; the loader does not use the workbook's age column.
- Rows with non-numeric `lx` are discarded.
- Survivorship is normalized to its first retained value.

The locally verified source workbook had a single populated sheet with columns `Age`, `lx`, and `mx`; the current MCMC loader uses only `lx` and row order.

Run `julia --project=. scripts/check_inputs.jl` after staging the files.
