module Year2022
    class Day06 < Solution

        def part_1
            detectStart 4
        end

        def part_2
            detectStart 14
        end

        private

        def detectStart(n)
            signal = @input
            count = 0
            letters = ("a".."z")
            while !letters.all?{|c| signal[0..n-1].count(c) <= 1}
                count += 1
                signal = signal[1..-1]
            end
            count + n
        end
    end
end
