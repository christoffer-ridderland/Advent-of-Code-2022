module Year2022
    class Day06 < Solution

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

        # Processes the dataset as a whole
        def process_dataset(set)
            set
        end
    end
end
