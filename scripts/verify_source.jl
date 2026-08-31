using SHA

const REPOSITORY_ROOT = normpath(joinpath(@__DIR__, ".."))
const REFERENCE_PATH = joinpath(REPOSITORY_ROOT, "reference", "THE_ONE")
const RUNNABLE_PATH = joinpath(REPOSITORY_ROOT, "run_model_c.jl")
const EXPECTED_SHA256 = "40883bedcf72a3dac976be41ac997b1e76add8c12da75c6c5d784619c05f6a5f"

const ORIGINAL_PATH_BLOCK = """const PROJECT_ROOT = joinpath(homedir(), \"Desktop\", \"Population-Project\")
const LIFE_TABLE_PATH = joinpath(PROJECT_ROOT, \"data\", \"processed\", \"data236\", \"life_table.csv\")
const COUNTRY_TABLE_PATH = joinpath(PROJECT_ROOT, \"data\", \"processed\", \"data236\", \"country_table.csv\")
const HADZA_PATH = joinpath(PROJECT_ROOT, \"data\", \"raw\", \"HG\", \"Hadza - Blurton Jones data.xlsx\")
const ACHE_PATH = joinpath(PROJECT_ROOT, \"data\", \"raw\", \"HG\", \"Ache - Hurtado & Hill.xlsx\")
const OUTPUT_ROOT = joinpath(PROJECT_ROOT, \"output\", \"model_c_revised\")"""

const PORTABLE_PATH_BLOCK = """const PROJECT_ROOT = @__DIR__
const LIFE_TABLE_PATH = joinpath(PROJECT_ROOT, \"data\", \"processed\", \"life_table.csv\")
const COUNTRY_TABLE_PATH = joinpath(PROJECT_ROOT, \"data\", \"processed\", \"country_table.csv\")
const HADZA_PATH = joinpath(PROJECT_ROOT, \"data\", \"restricted\", \"Hadza - Blurton Jones data.xlsx\")
const ACHE_PATH = joinpath(PROJECT_ROOT, \"data\", \"restricted\", \"Ache - Hurtado & Hill.xlsx\")
const OUTPUT_ROOT = joinpath(PROJECT_ROOT, \"output\", \"model_c_revised\")"""

reference_bytes = read(REFERENCE_PATH)
runnable_bytes = read(RUNNABLE_PATH)
reference_hash = bytes2hex(sha256(reference_bytes))

reference_hash == EXPECTED_SHA256 || error(
    "Archived source hash mismatch: expected $EXPECTED_SHA256, found $reference_hash"
)

reference_text = String(reference_bytes)
occurrences = length(findall(ORIGINAL_PATH_BLOCK, reference_text))
occurrences == 1 || error("Expected the original path block exactly once; found $occurrences")

expected_runnable = replace(reference_text, ORIGINAL_PATH_BLOCK => PORTABLE_PATH_BLOCK; count=1)
runnable_bytes == Vector{UInt8}(codeunits(expected_runnable)) || error(
    "run_model_c.jl differs from the archive outside the approved path substitution"
)

println("Source verification passed")
println("  archive SHA-256: $reference_hash")
println("  runnable delta: approved six-line path block only")
