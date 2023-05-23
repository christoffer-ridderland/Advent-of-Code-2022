# frozen_string_literal: true
module Year2022
    class Day09 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            pos = [0,0]
            poss = []
            rel = 5
            data.each do |d|
                dir = d[0]
                amount = d[1]
                case dir
                when "U"
                    (amount).times do
                        case rel
                        
                        when 7
                            rel = 8
                            pos[1] += 1
                            pos[0] += 1
                        when 8
                            pos[1] += 1
                        when 9
                            rel = 8
                            pos[1] += 1
                            pos[0] -= 1
                        else
                            rel += 3
                        end
                        poss << pos.dup
                    end

                when "D"
                    (amount).times do
                        case rel
                            
                        when 1
                            rel = 2
                            pos[1] -= 1
                            pos[0] += 1
                        when 2
                            pos[1] -= 1
                        when 3
                            rel = 2
                            pos[1] -= 1
                            pos[0] -= 1
                        else
                            rel -= 3
                            
                        end
                        poss << pos.dup
                    end
                when "R"
                    (amount).times do
                        case rel
                                
                        when 1
                            rel = 4
                            pos[0] += 1
                            pos[1] -= 1
                        when 4
                            rel = 4
                            pos[0] += 1
                        when 7
                            rel = 4
                            pos[0] += 1
                            pos[1] += 1
                        else
                            rel -= 1
                                
                        end
                        poss << pos.dup
                    end
                    
                when "L"
                    (amount).times do
                        case rel
                        when 3
                            rel = 6
                            pos[0] -= 1
                            pos[1] -= 1
                        when 6
                            pos[0] -= 1
                        when 9
                            rel = 6
                            pos[0] -= 1
                            pos[1] += 1
                        else
                            rel += 1
                        end
                        poss << pos.dup

                    end
                    
                end
                
            end
            out = []
            poss.each do |p|
                if !out.include?(p)
                    out << p
                end
            end
            return out.length
        end

        def part_2
            $rope = Array.new(10){[0,0]}
            dirs = Hash['U' => [0,1], 'D' => [0,-1], 'R' => [1,0], 'L' => [-1,0]]
            poss = []
            data.each do |d|
                dir = d[0]
                amount = d[1]
                (amount).times do
                    dx,dy = dirs[dir][0], dirs[dir][1]
                    $rope[0][0] += dx
                    $rope[0][1] += dy
                    (1...10).each do |i|
                        change(i)
                    end
                    poss << $rope[-1].dup
                end
            end
            out = []
            poss.each do |p|
                if !out.include?(p)
                    out << p
                end
            end
            return out.length
            
        end

        private

        def sgn(x)
            x > 0 ? 1 : (x < 0 ? -1 : 0)
        end
        def change(i)
            headx, heady = $rope[i-1]
            tailx, taily = $rope[i]
            dx = tailx - headx
            dy = taily - heady
            if dx == 0 || dy == 0
                if dx.abs > 1
                    $rope[i][0] -= sgn(dx)
                end
                if dy.abs > 1
                    $rope[i][1] -= sgn(dy)
                end
            elsif !(dx.abs == 1 && dy.abs == 1)
                $rope[i][0] -= sgn(dx)
                $rope[i][1] -= sgn(dy)
            end
        end
        # Processes the dataset as a whole
        def process_dataset(set)
            set.split("\n").map { |line| line.split(" ")}.map { |line| [line[0], line[1].to_i]}
        end
    end
end
