
module Year2022
    class Day14 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            occup, voids = data

            falls = 0
            while true
                sand = {x: 500, y: 0}

                while true
                    result = fall(sand, occup, voids)
                    if result == "GOING INF!"
                        return falls
                    elsif result == "FALLING"
                        next
                    elsif result == "STOPPING"
                        occup[[sand[:x], sand[:y]]] = true
                        break
                    else
                        raise "Invalid fall state"
                    end
                end
                falls += 1
            end
            
        end

        def part_2
            occup, _ = process_dataset(@input)
            floor = occup.keys.map {|x, y| y}.max + 2
            p floor
            falls = 0
            while true
                sand = {x: 500, y: 0}
                if occup[[sand[:x], sand[:y]]]
                    return falls
                end

                falls += 1

                while true
                    result = fallb(sand, occup, floor)
                    
                    if result == "FALLING"
                        next
                    elsif result == "STOPPING"
                        occup[[sand[:x], sand[:y]]] = true
                        break
                    else
                        raise "Invalid fall state"
                    end
                end
            end
        end

        private
          
        def fall(sand, occup, voids)
            if sand[:y] >= voids[sand[:x]]
                return "GOING INF!"
            end
            if !occup[[sand[:x], sand[:y] + 1]]
                sand[:y] += 1
                return "FALLING"
            elsif
                !occup[[sand[:x] - 1, sand[:y]+1]]
                sand[:x] -= 1
                sand[:y] += 1
                return "FALLING"
            elsif
                !occup[[sand[:x] + 1, sand[:y]+1]]
                sand[:x] += 1
                sand[:y] += 1
                return "FALLING"
            else
                return "STOPPING"
            end
        end

        def fallb(sand, occup, floor)
            if sand[:y] == floor - 1
                return "STOPPING"
            end
            if !occup[[sand[:x], sand[:y] + 1]]
                sand[:y] += 1
                return "FALLING"
            elsif
                !occup[[sand[:x] - 1, sand[:y]+1]]
                sand[:x] -= 1
                sand[:y] += 1
                return "FALLING"
            elsif
                !occup[[sand[:x] + 1, sand[:y]+1]]
                sand[:x] += 1
                sand[:y] += 1
                return "FALLING"
            else
                return "STOPPING"
            end
        end


        # Processes the dataset as a whole
        def process_dataset(set)
            vectors = set.split("\n").map { |vector| vector.split(" -> ").map {|coordinate| coordinate.split(",").map(&:to_i)} }
            rocks = []
            voids = Hash.new{|h,k| h[k] = 0 }
            vectors.each do |vector|
                (1...vector.length).each do |i|
                    x, y = vector[i]
                    px, py = vector[i-1]
                    if x == px
                        if y > py
                            ysmall = py
                            ybig = y
                        else
                            ysmall = y
                            ybig = py
                        end
                        (ysmall..ybig).each do |ry|
                            rocks << Occupied.new(x, ry)
                        end
                    elsif y == py
                        if x > px
                            xsmall = px
                            xbig = x
                        else
                            xsmall = x
                            xbig = px
                        end
                        (xsmall..xbig).each do |rx|
                            rocks << Occupied.new(rx, y)
                        end
                    else
                        raise "Invalid vector"
                    end
                end
            end
            rocks = rocks.uniq
            coords = rocks.map {|rock| [rock.x, rock.y]}
            rocks.each do |rock|
                if rock.y >= voids[rock.x]
                    voids[rock.x] = rock.y + 1
                end 
            end
            occupCoords = Hash.new { |h,k| h[k] = false }
            coords.each do |x, y|
                occupCoords[[x, y]] = true
            end
            return occupCoords, voids
        end

        class Occupied
            attr_reader :x, :y
            def initialize(x, y)
                @x = x
                @y = y
            end
            def to_s
                "#{x}, #{y}"
            end
        end
    end
    
end

