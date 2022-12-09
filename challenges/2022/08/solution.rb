# frozen_string_literal: true
module Year2022
    class Day08 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            
            sum = 0
            (0..data.length-1).each do |x|
                (0..data[0].length-1).each do |y|
                    if isVisible(x,y) && x != 0 && y != 0 && x != data.length-1 && y != data[0].length-1
                        sum += 1
                    end
                end
            end
            sum + 99*4 - 4
        end

        def part_2
            current = 0
            (0..data.length-1).each do |x|
                (0..data[0].length-1).each do |y|
                    if current < score(x,y)
                        current = score(x,y)
                    end
                end
            end
            current
        end
        
        def isVisible(x,y)
            max = data[x][y]
            tmp = x - 1
            passes = true
            ## check left
            while tmp >= 0
                if data[tmp][y] >= max then passes = false end
                tmp -= 1
            end
            if passes then return true end
            tmp = y - 1
            passes = true
            ## check up
            while tmp >= 0
                if data[x][tmp] >= max then passes = false end
                tmp -= 1
            end
            if passes then return true end
            tmp = x + 1
            passes = true
            ## check right
            while tmp < data.length
                if data[tmp][y] >= max then passes = false end
                tmp += 1
            end
            if passes then return true end
            tmp = y + 1
            passes = true
            ## check down
            while tmp < data[0].length
                if data[x][tmp] >= max then passes = false end
                tmp += 1
            end
            if passes then return true end
            return false

        end

        def score(x,y)
            max = data[x][y]
            sum1 = 0
            sum2 = 0
            sum3 = 0
            sum4 = 0
            ## check left
            tmp = x - 1
            while tmp >= 0
                sum1 += 1
                if data[tmp][y] >= max then break end
                tmp -= 1
            end
            ## check up
            tmp = y - 1
            while tmp >= 0
                sum2 += 1
                if data[x][tmp] >= max then break end
                tmp -= 1
            end
            ## check right
            tmp = x + 1
            while tmp < data.length
                sum3 += 1
                if data[tmp][y] >= max then break end
                tmp += 1
            end

            
            ## check down
            tmp = y + 1
            while tmp < data[0].length
                sum4 += 1
                if data[x][tmp] >= max then break end
                tmp += 1
            end
            sum1 * sum2 * sum3 * sum4

        end
        

        private

        # Processes the dataset as a whole
        def process_dataset(set)
            set.split("\n").map{|l| l.split("").map(&:to_i)}
        end
    end
end


