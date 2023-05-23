# frozen_string_literal: true
module Year2022
    class Day19 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            p data
            nil
        end

        def part_2
            nil
        end

        private

        # Processes the dataset as a whole
        def process_dataset(set)
            rows = set.split("\n")
            rows.map do |row|
                row.
                gsub(/(Blueprint)\s\d(:)/, "").
                gsub(/\s\D+/, " ").
                split(" ").map(&:to_i)
            end
            p rows
            blueprints = []
            rows.each do |row|
                blueprints << Blueprint.new(row[0], row[1], row[2], row[3], row[4], row[5])
            end
            return blueprints
        end

        class Blueprint
            attr_accessor :ore, :clay, :obsidian, :geode
            attr_writer :ore, :clay, :obsidian, :geode
            def initialize(oreCostOre,
                 clayCostOre,
                  obsidianCostOre,
                   obsidianCostClay,
                    geodeCostOre,
                     geodeCostObsidian)
                @ore = Material.new(oreCostOre, 0, 0)
                @clay = Material.new(clayCostOre, 0, 0)
                @obsidian = Material.new(obsidianCostOre, obsidianCostClay, 0)
                @geode = Material.new(geodeCostOre, 0, geodeCostObsidian)
            end
            
        end
        class Material
            attr_accessor :ore, :clay, :obsidian
            def initialize(ore, clay, obsidian)
                @ore = ore
                @clay = clay
                @obsidian = obsidian
            end

        end
        class Fleet
            attr_accessor :ore, :clay, :obsidian, :geode
            
            def initialize()
                @ore = 1
                @clay = 0
                @obsidian = 0
                @geode = 0
            end
        end
        
    end
end
