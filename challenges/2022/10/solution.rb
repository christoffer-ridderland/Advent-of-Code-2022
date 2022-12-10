# frozen_string_literal: true
module Year2022
    class Day10 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            cycle = 1
            x = 1
            sum = 0
            data.each do |instr|
                if cycle % 40 == 20
                    p [cycle,x]
                    sum += x * cycle
                end
                if instr[0] == "addx"
                    cycle += 1
                    if cycle % 40 == 20
                        p [cycle,x]
                        sum += x * cycle
                    end
                    x += instr[1].to_i
                end
                cycle += 1
            end
            sum
        end

        def part_2
            screen = Array.new(240)
            cycle = 0
            x = 1
            data.each do |instr|
                if (x % 40 - cycle % 40).abs <= 1
                    screen[cycle] = "#"
                else
                    screen[cycle] = "."
                end
                if instr[0] == "addx"
                    cycle += 1
                    if (x % 40 - cycle % 40).abs <= 1
                        screen[cycle] = "#"
                    else
                        screen[cycle] = "."
                    end
                    x += instr[1].to_i
                end
                cycle += 1
                
                
            end
            (0...6).each do |i|
                puts screen[0 +40*i..40+40*i].join
                
            end
             
            #p screen
            "See screen: (in my case: REHPRLUB)"
        end

        private
        def handle(instr)
            case instr
            when "noop"
                $cycle += 1
            else
                $cycle += 1
                check()
                $x = instr[1].to_i
            end
            check()
        end
        def check()
            if $cycle % 40 == 20
                p $cycle
                $sum += $x * $cycle
            end
        end
        # Processes each line of the input file and stores the result in the dataset
        # def process_input(line)
        #   line.map(&:to_i)
        # end

        #Processes the dataset as a whole
        def process_dataset(set)
            set.split("\n").map{|l| l.split(" ")}
        end
    end
end
