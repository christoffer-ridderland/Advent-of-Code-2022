# frozen_string_literal: true
module Year2022
    class Day04 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file
    
        def part_1
            sum = 0
            data.each do |a,b|
                if (a[0] <= b[0]) && (a[1] >= b[1]) # b in a
                    sum += 1
                elsif (a[0] >= b[0]) && (a[1] <= b[1]) # a in b
                    sum += 1
                end
            end
            return sum
        end

        def part_2
            sum = 0
            data.each do |a,b|
                if (a[0] <= b[1]) && (b[0] <= a[1]) # ranges begin before the other stops
                    sum += 1
                end
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
            set.split("\n").map{|l| l.chomp.split(',').map{|m| m.split('-').map{ |n| n.to_i}}}
        end
    end
end
