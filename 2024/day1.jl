# using Pkg
# Pkg.add(["CSV", "DataFrames"])


using CSV
using DataFrames

# Define the file path
ts_file = "data/day1_input.txt"

# Read the TSV file into a DataFrame
df = CSV.read(ts_file, DataFrame; delim=' ', ignorerepeated=true, header=0)

# Sort each column from small to large
df_sorted = DataFrame([c => sort(df[!, c]) for c in names(df)])


# Calculate the sum of the absolute difference between column 1 and column 2 of df_sorted using `eachindex`
abs_diff_sum_sorted = sum(abs(df_sorted[i, 1] - df_sorted[i, 2]) for i in eachindex(df_sorted[:, 1]))

# Print the result
println("Sum of absolute differences (sorted DataFrame): ", abs_diff_sum_sorted)


# Calculate the total similarity score
left_list = df_sorted[:, 1]
right_list = df_sorted[:, 2]

similarity_score = sum(left_value * count(==(left_value), right_list) for left_value in left_list)

# Print the similarity score
println("Total similarity score: ", similarity_score)
