# frozen_string_literal: true
module Year2022
    class Day10 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file


        
        def part_1
            🐭 = 1
            🦕 = 1
            🐙 = 0
            data.each do |🙉|
                if 🐭 % 40 == 20
                    p [🐭,🦕]
                    🐙 += 🦕 * 🐭
                end
                if 🙉[0] == "addx"
                    🐭 += 1
                    if 🐭 % 40 == 20
                        p [🐭,🦕]
                        🐙 += 🦕 * 🐭
                    end
                    🦕 += 🙉[1].to_i
                end
                🐭 += 1
            end
            🐙
        end

        def part_2
            🙊 = Array.new(240)
            🙈 = 0
            🙉 = 1
            data.each do |🐵|
                if (🙉 % 40 - 🙈 % 40).abs <= 1
                    🙊[🙈] = "#"
                else
                    🙊[🙈] = "."
                end
                if 🐵[0] == "addx"
                    🙈 += 1
                    if (🙉 % 40 - 🙈 % 40).abs <= 1
                        🙊[🙈] = "#"
                    else
                        🙊[🙈] = "."
                    end
                    🙉 += 🐵[1].to_i
                end
                🙈 += 1
                
                
            end
            (0...6).each do |i|
                puts 🙊[0 +40*i..40+40*i].join
                
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
