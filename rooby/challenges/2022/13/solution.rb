require 'json'
module Year2022
    class Day13 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            packets = Marshal.load(Marshal.dump(data))
            sum = 0
            packets.map { |left, right| compare(left, right) }.each_with_index do |ordering, i|
                sum += i + 1 if ordering == :left
            end
            sum
        end

        def part_2
            pairs = Marshal.load(Marshal.dump(data))
            packets = []
            pairs.each do |left, right|
                packets << left
                packets << right
            end
            packets << [[2]]
            packets << [[6]]
            ordered = []
            packets.each do |packet|
                ordered = insert(ordered, packet)
            end
            (ordered.index([[6]]) + 1) * (ordered.index([[2]]) + 1)
        end

        private
        def insert(array, value)
            return [value] if array.empty?
            array.each_with_index do |item, i|
                result = compare(value, item)
                if result == :left
                    array.insert(i, value)
                    return array
                end
            end
            array << value
            array
        end
        def compare(left, right)
            return :equal if left == right
            if left.is_a?(Array) && right.is_a?(Array)
                (0...[left.length, right.length].min).each do |i|
                    result = compare(left[i], right[i])
                    return result unless result == :equal
                    p result
                end
                if left.length < right.length
                    :left
                elsif left.length > right.length
                    :right
                else
                    :equal
                end
            elsif left.is_a?(Array) && right.is_a?(Integer)
                return compare(left, [right])
            elsif left.is_a?(Integer) && right.is_a?(Array)
                return compare([left], right)
            elsif left.is_a?(Integer) && right.is_a?(Integer)
                return :equal if left == right
                left < right ? :left : :right
                
            else
                raise "Invalid comparison"
            end
            
        end

        #end
        # Processes the dataset as a whole
        def process_dataset(set)
            set.split("\n\n").map { |line| line.split("\n").map { |line| JSON.parse(line) } }
            
        end
    end
end
