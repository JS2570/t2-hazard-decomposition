using CSV
using DataFrames
using XLSX

const REPOSITORY_ROOT = normpath(joinpath(@__DIR__, ".."))
const LIFE_TABLE_PATH = joinpath(REPOSITORY_ROOT, "data", "processed", "life_table.csv")
const HADZA_PATH = joinpath(REPOSITORY_ROOT, "data", "restricted", "Hadza - Blurton Jones data.xlsx")
const ACHE_PATH = joinpath(REPOSITORY_ROOT, "data", "restricted", "Ache - Hurtado & Hill.xlsx")

function require_columns(table::DataFrame, required::Vector{Symbol}, label::String)
    missing_columns = setdiff(required, propertynames(table))
    isempty(missing_columns) || error("$label is missing columns: $(join(missing_columns, ", "))")
end

function validate_life_table()
    isfile(LIFE_TABLE_PATH) || error("Missing Japan input: $LIFE_TABLE_PATH")
    table = CSV.read(LIFE_TABLE_PATH, DataFrame)
    require_columns(table, [:ISO3, :Year, :Age, :lx], "Japan life table")

    rows = table[(table.ISO3 .== "JPN") .& (table.Year .== 2010), :]
    nrow(rows) > 0 || error("Japan life table contains no JPN 2010 rows")
    issorted(rows.Age) || error("Japan ages are not sorted")
    all((0.0 .<= rows.lx) .& (rows.lx .<= 1.0)) || error("Japan lx must lie between 0 and 1")
    all(diff(rows.lx) .<= 0.0) || error("Japan lx must be non-increasing")
    isapprox(Float64(first(rows.lx)), 1.0; atol=1e-12) || error("Japan lx must start at 1")

    println("Japan input: OK ($(nrow(rows)) rows, ages $(first(rows.Age))-$(last(rows.Age)))")
end

function read_first_sheet(path::String, label::String)
    isfile(path) || error("Missing restricted $label workbook: $path")
    return DataFrame(XLSX.readtable(path, 1))
end

function validate_hadza()
    table = read_first_sheet(HADZA_PATH, "Hadza")
    ncol(table) > 0 || error("Hadza workbook has no columns")
    require_columns(table, [:lx], "Hadza workbook")
    first_column = names(table)[1]
    first_column == "Age" || @warn "Hadza loader treats the first column as age" first_column
    println("Hadza workbook schema: OK (first column $first_column; lx present)")
end

function validate_ache()
    table = read_first_sheet(ACHE_PATH, "Aché")
    require_columns(table, [:lx], "Aché workbook")
    nrow(table) > 0 || error("Aché workbook contains no rows")
    println("Aché workbook schema: OK (lx present; $(nrow(table)) ordered rows)")
end

validate_life_table()
validate_hadza()
validate_ache()
println("All MCMC input checks passed")
