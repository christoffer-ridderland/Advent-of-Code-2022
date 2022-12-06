
module Year2022
    class Day04 < Solution

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

        # Processes the dataset as a whole
        def process_dataset(set)
            set.split("\n").map{|l| l.chomp.split(',').map{|m| m.split('-').map{ |n| n.to_i}}}
        end
    end
end
