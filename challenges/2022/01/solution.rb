# frozen_string_literal: true



module Year2022
    class Day01 < Solution

        def part_1

            data.max

        end

        def part_2

            #data.max(3).sum

        end


        #Processes the dataset as a whole
        def process_dataset(set)
            set.split("\n\n").map { |elf| elf.split.map { |calories| calories.to_i }.sum }
        end

    end
end

