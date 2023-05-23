# frozen_string_literal: true
module Year2022
    class Day15 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            input = 2000000
            tst = 10
            line = input
            sb = Marshal.load(Marshal.dump(data))
            cant = []
            sb.each do |sensor, beacon|
                sx, sy = sensor
                bx, by = beacon
                if left_right([sensor, beacon], line) == "don't reach"
                    next
                end
                l, r = left_right([sensor, beacon], line)
                (l..r).each do |x|
                    cant << x
                end
                
            end
            sb.each do |_, beacon|
                bx, by = beacon
                if by == line
                    cant.delete(bx)
                end
            end
            cant.uniq.count
        end
        def part_2
            sb = Marshal.load(Marshal.dump(data))
            sensors = sb.map{|sensor, beacon| [sensor, manhattan_distance(sensor[0], sensor[1], beacon[0], beacon[1])]}
            tst = 20
            input = 4000000
            max = input
            (0..max).each do |y|
                x = 0
                while x < max
                    result = skips(sensors, x, y)
                    if result == "OUT OF RANGE"
                        return x * 4000000 + y
                    end
                    x += result + 1
                end
            end
        end

        private
        def skips(sensors, x, y)
            sensors.each do |sensor, beaconDist|
                sx, sy = sensor
                dist = manhattan_distance(sx, sy, x, y)
                if dist <= beaconDist
                    dx = sx - x
                    dy = sy - y
                    return dx + beaconDist - dy.abs
                end
            end
            return "OUT OF RANGE"
        end
        def deltas(x1, y1, x2, y2)
            dx = x1 - x2
            dy = y1 - y2
            return dx, dy
        end
        def manhattan_distance(x1, y1, x2, y2)
            (x1 - x2).abs + (y1 - y2).abs
        end
        def left_right(pair, yLine)
            sx, sy = pair[0]
            bx, by = pair[1]
            dist = manhattan_distance(sx, sy, bx, by) 
            down = manhattan_distance(sx, sy, sx, yLine)
            delta = dist - down
            if delta < 0
                return "don't reach"
            end
            left = sx - delta
            right = sx + delta
            return left, right

        end
        # Processes the dataset as a whole
        def process_dataset(set)
            set.split("\n").map { |line| line.delete("^0-9,:-").split(":").map{|xy| xy.split(",").map(&:to_i)}}
        end
    end
end
