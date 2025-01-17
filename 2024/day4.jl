function count_xmas_occurrences(grid)
    directions = [(1,0), (0,1), (1,1), (1,-1), (-1,0), (0,-1), (-1,-1), (-1,1)]
    rows, cols = size(grid)
    target_word = "XMAS"
    word_length = length(target_word)
    count = 0

    for r in 1:rows, c in 1:cols
        if grid[r, c] == 'X'
            for (dr, dc) in directions
                if check_direction(grid, r, c, dr, dc, target_word, rows, cols)
                    count += 1
                end
            end
        end
    end
    return count
end

function check_direction(grid, r, c, dr, dc, word, rows, cols)
    for i in 1:length(word)
        nr, nc = r + (i-1)*dr, c + (i-1)*dc
        if nr < 1 || nr > rows || nc < 1 || nc > cols || grid[nr, nc] != word[i]
            return false
        end
    end
    return true
end

# Read from file
grid = permutedims(reduce(hcat, collect.(readlines("2024/data/day4_input.txt"))))


# Call the function and print the result
result = count_xmas_occurrences(grid)
println("Number of times XMAS appears: $result")
