# frozen_string_literal: true
module Year2022
    class Day11 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            $monkeys = Marshal.load(Marshal.dump(data))

            (0...20).each do |i|
                $monkeys.each_with_index do |m, j|
                    #p "Round: #{i}, monkey: #{j} - #{m.getItems}"
                end
                $monkeys.each_with_index do |m, j|
                    m.getItems.each do |item|
                        worry = (m.inspect(item)/ 3.0).floor

                        to = m.to(worry % m.getDivTest == 0)
                        $monkeys[to].grab(worry)
                    end
                    m.reset()
                end
            end
            $monkeys.map{|m| m.getBuissness}.max(2).inject(:*)
            
        end

        def part_2
            $monkeys = Marshal.load(Marshal.dump(data))
            divis = 1
            $monkeys.each do |m|
                divis *= m.getDivTest()
            end
            #return nil
            (0...10000).each do |i|
                $monkeys.each_with_index do |m, j|
                    m.getItems.each do |item|
                        worry = m.inspect(item)
                        worry = worry % divis
                        
                        to = m.to(worry % m.getDivTest == 0)
                        $monkeys[to].grab(worry)
                    end
                    m.reset()
                end
            end
            $monkeys.map{|m| m.getBuissness}.max(2).inject(:*)
        end

        private


        # Processes the dataset as a whole
        def process_dataset(set)
            monkeys_data = set.split("\n\n").map{|monkey| monkey.split("\n")}
            monkeys = []
            monkeys_data.each_with_index do |m, i|
                items = m[1].split(":")[1].split(", ").map(&:to_i)
                
                operation = m[2].split("=")[1].split(" ").map{|x| !["+", "*", "old"].include?(x) ? x.to_i : x}

                divTest = m[3].delete("  Test: divisible by ").to_i
                lobs = Hash[true:m[4].delete("    If true: throw to monkey ").to_i, false:m[5].delete("    If false: throw to monkey ").to_i]
                monkeys[i] = Monkey.new(items, operation, divTest, lobs)
                
            end
            monkeys
        end
        
        class Monkey
            
            attr_reader :number, :items, :operation, :test, :lobs
            def initialize(items, operation, divTest, lobs)
                @items = items
                @operation = operation
                @divTest = divTest
                @lobs = lobs
                @monkeyBuissness = 0
            end

            def getBuissness()
                @monkeyBuissness
            end
            def getItems()
                @items
            end
            def getItem()
                @items.pop
            end

            def getDivTest()
                @divTest
            end

            def to(bool)
                @lobs[bool.to_s.to_sym]
            end
            
            def inspect(item)
                    @monkeyBuissness += 1
                    worry = @operation[2] == "old" ? item*item : [item, operation[2]].inject(operation[1].to_sym)
                    worry


            end
            
            def grab(item)
                @items << item
            end
            def reset()
                @items = []
            end

        end
    end
end
