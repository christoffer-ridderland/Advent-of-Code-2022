# frozen_string_literal: true
module Year2022
    class Day02 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            score = 0
            data.each do |elf, you|
                score += Hash['X' => 1, 'Y' => 2, 'Z' => 3][you]
                score += scoreWin(elf, you)
            end
            return score
        end

        def part_2
            score = 0
            data.each do |elf, you|
                score += Hash['X' => Hash['A' => 3, 'B' => 1, 'C' => 2], 'Y' => Hash['A' => 1, 'B' => 2, 'C' => 3], 'Z' => Hash['A' => 2, 'B' => 3, 'C' => 1]][you][elf]
                score += Hash['X' => 0, 'Y' => 3, 'Z' => 6][you]
            end
            return score
        end

        private
        # Processes each line of the input file and stores the result in the dataset
        # def process_input(line)
        #   line.map(&:to_i)
        # end

        def scoreWin(elf, you)
            if elf == Hash['X' => 'A', 'Y' => 'B', 'Z' => 'C'][you]
                return 3
            elsif Hash['X' => 'C', 'Y' => 'A', 'Z' => 'B'][you] == elf
                return 6
            else
                return 0
            end
        end

        #Processes the dataset as a whole
        def process_dataset(set)
            set.split("\n").map {|line| line.split(' ')}
        end
    end
end
