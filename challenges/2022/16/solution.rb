# frozen_string_literal: true
module Year2022
    class Day16 < Solution
        # @input is available if you need the raw data input
        # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

        def part_1
            $dists, $flows = Marshal.load(Marshal.dump(data))

            opened = Set[]
            $cache = Hash.new

            return dfs_bitmask(30, "AA", 0)

        end

        def part_2
            $dists, $flows = Marshal.load(Marshal.dump(data))
            $cache = Hash.new
            maxs = 0

            # A bitmask is faster than a set
            bm = (1 << $dists.keys.length) - 1
            p bm/2

            (0..bm/2).each do |i|
                maxs = [maxs, dfs_bitmask(26, "AA", i) + dfs_bitmask(26, "AA", bm^i)].max
                p i
            end
            return maxs

        end

        private
        def dfs_bitmask(time, valve, bitmask)
            if $cache[[time, valve, bitmask]] != nil
                return $cache[[time, valve, bitmask]]
            end
            max = 0
            $dists[valve].each do |neightbour, dst|
                bit = 1 << $dists.keys.index(neightbour)
                if (bitmask & bit) != 0
                    next
                end
                timeRemaining = time - dst - 1

                if timeRemaining <= 0
                    next
                end
                max = [max,
                    dfs_bitmask(timeRemaining, neightbour, bitmask | bit) + $flows[neightbour] * timeRemaining ].max
                
            end
            
            $cache[[time, valve, bitmask]] = max
            return max
        end

        def dfs(time, valve, opened)
            if $cache.keys.include? [time, valve, opened]
                return $cache[[time, valve, opened]]
            end
            max = 0
            opened = opened.add(valve)
            $dists[valve].each do |neightbour, dst|
                if opened.include?(neightbour)
                    next
                end
                timeRemaining = time - dst - 1

                if timeRemaining <= 0
                    next
                end
                max = [max,
                    dfs(timeRemaining, neightbour, Set[valve] + opened) + $flows[neightbour] * timeRemaining ].max
                
            end
            
            $cache[[time, valve, $opened]] = max
            return max
        end
        #def dfs(time, valve, opened)
        #    if $cache[[time, valve, opened]] != nil
        #        return $cache[[time, valve, opened]]
        #    end
        #    if time <= 0 
        #        return 0
        #    end
        #    score = $dists[valve].map {|vlv, dst| dfs(time - dst, vlv, opened)}.max
        #    if !opened.include?(valve)
        #        score = [score, $flows[valve] * (time - 1) + dfs(time - 1, valve, opened.add(valve))].max
        #    end
        #    $cache[[time, valve, opened]] = score
        #    if score != 0
        #        p "valve: #{valve}, time: #{time}, opened: #{opened}, score: #{score}"
        #    end
        #    return score
        #end

        def process_dataset(set)
            flows, tunnels = flows_and_tunnels(set)
            dists = Hash.new
            keys = flows.keys
            nonEmpty = []
            keys.each do |key|
                if key != "AA" && flows[key] == 0
                    next
                end
                if key != "AA"
                    nonEmpty << key
                end
                dists[key] = {
                    key => 0,
                    "AA"  => 0
                }
                visited = Set[key]
        
                queue = [[0, key]]
        
                while queue.length > 0
                    dist, pos = queue.shift
        
                    tunnels[pos].each do |neightbour|
                        if visited.include?(neightbour)
                            next
                        end
                        visited.add(neightbour)
                        if !(flows[neightbour] == 0)
                            dists[key][neightbour] = dist + 1
                        end
                        queue.append([dist + 1, neightbour])
                    end
                end
                dists[key].delete(key)
                if key != "AA"
                    dists[key].delete("AA")
                end
            end
            return dists, flows
        
        end


        def flows_and_tunnels(input)
            rows = input.split("\n")
            flows = Hash.new
            tunnels = Hash.new
            keys = []
            rows.each do |valve|
                name = valve.gsub( /(Valve )/, '').gsub(/ (has)[\s\S]*/, '')
                rate = valve.gsub(/[\s\S]*(=)/, '').gsub(/(;)[\s\S]*/, '').to_i
                caves = valve.gsub(/[\s\S]*(valv)\w+[\s]/, '').split(", ")
                
                flows[name] = rate
                tunnels[name] = caves
            end
            return flows, tunnels

        end

    end
end
