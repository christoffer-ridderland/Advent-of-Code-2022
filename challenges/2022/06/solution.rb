# frozen_string_literal: true
module Year2022
    class Day06 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            signal = @input
            count = 0
            while !("a".."z").all?{|c| signal[0..3].count(c) <= 1}
                count += 1
                signal = signal[1..-1]
            end
            p signal[0..3]
            count + 4
        end

        def part_2
            signal = @input
            count = 0
            while !("a".."z").all?{|c| signal[0..13].count(c) <= 1}
                count += 1
                signal = signal[1..-1]
            end
            p signal[0..3]
            count + 14
        end

        private
        # Processes each line of the input file and stores the result in the dataset
        # def process_input(line)
        #   line.map(&:to_i)
        # end

        # Processes the dataset as a whole
        def process_dataset(set)
            set
        end
    end
end
