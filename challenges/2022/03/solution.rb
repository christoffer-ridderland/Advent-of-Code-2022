# frozen_string_literal: true
module Year2022
    class Day03 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            inputs = data.map{|l| l.chomp.split("")}.map{|l| [l[0..l.length/2.floor-1], l[l.length/2..-1]]}
            prios = ["OFFSET OFF-BY-ONE-ERROR", *('a'..'z'), *('A'..'Z')]
            sum = 0
            inputs.each do |(a,b)|
                sum += prios.index((a & b)[0])
            end
            return sum
        end

        def part_2
            inputs = data.each_slice(3).to_a.map{|l| l.map{|elf| elf.chomp.split("")}}
            prios = ["OFFSET OFF-BY-ONE-ERROR", *('a'..'z'), *('A'..'Z')]
            sum = 0
            inputs.each do |(a,b,c)|
                sum += prios.index((a & b & c)[0])
            end
            return sum
        end

        private
        # Processes each line of the input file and stores the result in the dataset
        # def process_input(line)
        #   line.map(&:to_i)
        # end

        # Processes the dataset as a whole
        def process_dataset(set)
            set.split("\n")
        end
    end
end
