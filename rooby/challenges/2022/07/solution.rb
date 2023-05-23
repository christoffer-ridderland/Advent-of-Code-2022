# frozen_string_literal: true
module Year2022
    class Day07 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            sum = 0
            data.flatten.each do |dirsize|
                if dirsize <= 100000
                    sum += dirsize
                end

            end
            sum
        end

        def part_2
            total = 70000000
            used = data.bitsize
            data.flatten.sort.each do |dirsize|
                if total - used + dirsize >= 30000000
                    return dirsize
                end
            end
        end

        private


        # Processes the dataset as a whole
        def process_dataset(set)
            root = nil
            current = nil
            set.split("\n").each do |line|
                args = line.split(" ")
                case args
                when ["$","cd", "/"]
                    root = Dir.new("/")
                    current = root
                when ["$","cd", ".."]
                    current = current.parent
                when ["$","cd", args[2]]
                    current = current.children.find { |child| child.name == args[2] }
                when ["$","ls"]
                    next
                when ["dir", args[1]]
                    dir = Dir.new(args[1])
                    current.add_child(dir)
                else
                    file = File.new(args[1], args[0].to_i)
                    current.add_child(file)
                end
            end
            root
        end
        
    end

    class Dir
        attr_accessor :name, :parent, :children
        def initialize(name)
            @name = name
            @parent = nil
            @children = []
        end
        def to_s()
            [@name, @children.map{|child| child.to_s}]
        end

        def add_child(child)
            @children << child
            child.parent = self
        end

        def set_parent(parent)
            @parent = parent
        end

        def bitsize
            if @children == []
                0
            end
            
            @children.map{|child| child.bitsize}.sum()
        
        end

        def flatten()
            flat = []
            @children.each do |child|
                if child.class == Dir
                    flat << child.bitsize
                    child.flatten().each do |subchild|
                        flat << subchild
                    end
                end
                
            end
            flat
        end
        
    end

    class File
        attr_accessor :name, :parent, :bitsize
        def initialize(name, bitsize)
            @name = name
            @bitsize = bitsize
        end

        def to_s()
            [@name, @bitsize]
        end
    end
end
