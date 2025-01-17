function extract_and_sum_multiplications(filename::String)
    # Define a regular expression to match "mul({int},{int})" where {int} is an integer
    regex = r"mul\((\d+),(\d+)\)"
    
    # Initialize the sum
    total_sum = 0
    
    # Open and read the file
    open(filename, "r") do file
        for line in eachline(file)
            # Use each match of the regex in the line
            for m in eachmatch(regex, line)
                # Extract the two integer groups from the regex match
                a = parse(Int, m.captures[1])
                b = parse(Int, m.captures[2])
                # Multiply and add to the total sum
                total_sum += a * b
            end
        end
    end
    
    return total_sum
end

function extract_and_sum_multiplications_with_condition(filename::String)

    # Define regular expressions to match "mul({int},{int})", "do()", and "don't()"
    mul_regex = r"mul\((\d+),(\d+)\)"
    do_regex = r"do\(\)"
    dont_regex = r"don't\(\)"
    
    # Initialize the sum and the state of mul instructions (enabled by default)
    total_sum = 0
    mul_enabled = true
    
    # Open and read the file
    open(filename, "r") do file
        for line in eachline(file)
            # Use each match of the line, allowing sequential processing of "do()" or "don't()" instructions
            for m in eachmatch(r"$do_regex|$dont_regex|$mul_regex", line)
                if occursin(do_regex, m.match)
                    mul_enabled = true
                elseif occursin(dont_regex, m.match)
                    mul_enabled = false
                elseif occursin(mul_regex, m.match) && mul_enabled
                    # Extract the two integer groups from the regex match
                    a = parse(Int, m.captures[1])
                    b = parse(Int, m.captures[2])
                    # Multiply and add to the total sum
                    total_sum += a * b
                end
            end
        end
    end
    
    return total_sum
end

file_path = "2024/data/day3_input.txt"

result = extract_and_sum_multiplications(file_path)
println("The total sum is: ", result)

result = extract_and_sum_multiplications_with_condition(file_path)
println("The total sum with condition is: ", result)
