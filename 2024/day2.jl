using CSV
using DataFrames

# Function to determine if a report is safe
function is_safe_report(levels)
    # Validate input length
    if length(levels) < 2
        return false
    end

    # Check if levels are strictly increasing or strictly decreasing
    differences = diff(levels)
    increasing = all(x -> x > 0, differences)
    decreasing = all(x -> x < 0, differences)

    # Check if all differences are between 1 and 3
    valid_differences = all(x -> 1 ≤ abs(x) ≤ 3, differences)

    # Both conditions must be true for the report to be safe
    return (increasing || decreasing) && valid_differences
end

# Function to determine if a report is safe considering the "Problem Dampener" rule
function is_safe_with_dampener(levels::Vector{Int})
    # Check if the original report is safe
    if is_safe_report(levels)
        return true
    end

    # Check if removing one level can make it safe
    for i in 1:length(levels)
        new_levels = deleteat!(copy(levels), i)  # Remove the element at index i
        if is_safe_report(new_levels)
            return true  # If any modified version is safe, return true
        end
    end

    # If no single removal results in a safe report, return false
    return false
end

# Define the file path
ts_file = "2024/data/day2_input.txt"

# Initialize counter

global safe_count = 0
# Open the file and process each line
open(ts_file, "r") do file
    safe_count = 0 
    for line in eachline(file)
            levels = parse.(Int, split(line))
            # println("Levels: $levels")
            # println("Is safe: $(is_safe_report(levels))")
            global safe_count += is_safe_report(levels) ? 1 : 0
    end
end

println("Number of safe reports: $safe_count")


global safe_count = 0
# Open the file and process each line
open(ts_file, "r") do file
    safe_count = 0 
    for line in eachline(file)
            levels = parse.(Int, split(line))
            global safe_count += is_safe_with_dampener(levels) ? 1 : 0
    end
end

println("Number of safe reports with dampener: $safe_count")

