# frozen_string_literal: true
module Year2022
    class Day12 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            #p data[0].map(&:to_s)
            griddy = Marshal.load(Marshal.dump(data))
            current = [find_start(griddy)]
            steps = 0
            while true
                steps += 1
                current.each do |square|
                    square.isVisited = true
                end
                nexts = current.map{|square| square.neighbors(griddy)}.flatten.uniq
                nexts.each do |square|
                    if square.isGoal
                        return steps
                    end
                end
                current = nexts
                current = current.reject{|square| square.isVisited}
                #p current.map(&:to_s)
            end
        end

        def part_2
            griddy = Marshal.load(Marshal.dump(data))
            starts = find_potential_start(griddy)
            allSteps = []
            starts.each_with_index do |start,i|
                #p i
                current = [start]
                steps = 0
                foundGoal = false
                while !foundGoal
                    steps += 1
                    current.each do |square|
                        square.isVisited = true
                    end

                    nexts = current.map{|square| square.neighbors(griddy)}.flatten.uniq
                    nexts.each do |square|
                        if square.isGoal
                            foundGoal = true
                        end
                    end
                    if nexts.empty? #no more squares to visit
                        steps = "unreachable"
                        break
                    end
                    current = nexts
                    current = current.reject{|square| square.isVisited}
                    
                end
                allSteps << steps
                griddy.map {|line| line.map{|square| square.isVisited = false}} # need to reset the grid
            end

            return allSteps.reject{|step| step == "unreachable"}.min
        end

        private
        # Processes each line of the input file and stores the result in the dataset
        # def process_input(line)
        #   line.map(&:to_i)
        # end

        # Processes the dataset as a whole
        def process_dataset(set)
            
            grid = set.split("\n").map{|line| line.split("")}
            
            grid.each_with_index do |line, i|
                line.each_with_index do |char, j|
                    grid[i][j] = Square.new(i, j, char)
                end
            end
            return grid
        end
        class Square
            attr_reader :x, :y, :h, :isStart, :isGoal, :isVisited
            attr_writer :isVisited
            def initialize(x, y, h)
                @x = x
                @y = y
                @h = height(h)
                @isStart = h == "S"
                @isGoal = h == "E"
                @isVisited = false
            end
            def neighbors(grid)
                neighbors = []
                neighbors << grid[x + 1][y] if x + 1 < grid.length
                neighbors << grid[x - 1][y] if x - 1 >= 0
                neighbors << grid[x][y + 1] if y + 1 < grid[x].length
                neighbors << grid[x][y - 1] if y - 1 >= 0
                neighbors = neighbors.reject{|square| square.h > @h + 1}.reject{|square| square.isVisited}
            end
            def height(letter)
                if letter == "S"
                    letter = "a"
                elsif letter == "E"
                    letter = "z"
                end
                letter.ord - "a".ord
            end
            def to_s #for debugging
                "(#{x}, #{y}, #{h})"

            end
        end
        def find_start(grid)
            grid.each do |line|
                line.each do |square|
                    return square if square.isStart
                end
            end
        end
        def find_potential_start(grid)
            squares = []
            grid.each do |line|
                line.each do |square|
                   squares << square if square.h == 0
                end
            end
            squares
        end
    end
end
