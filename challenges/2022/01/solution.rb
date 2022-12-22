module Year2022
    class Day01 < Solution

        def part_1

            data.max

        end

        def part_2

            data.max(3).sum

        end


        #Processes the dataset as a whole
        def process_dataset(💩)
            💩.split("\n\n").map { |😎| 😎.split.map { |🥵| 🥵.to_i }.sum }
        end

    end
end

