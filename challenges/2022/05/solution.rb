module Year2022
    class Day05 < Solution

        def part_1
            crates, moves = Marshal.load(Marshal.dump(data)) #deep copy
            cargo = crates.clone

            moves.each do |move, from , to|
                move.times do
                    cargo[to-1] << cargo[from-1].pop
        
                end
            end

            lasts = ""
            cargo.each do |col|
                lasts += col.last
            end

            return lasts
        end

        def part_2
            crates, moves = Marshal.load(Marshal.dump(data)) #deep copy
            cargo = crates.clone
            p cargo
        
            moves.each do |move, from , to|
        
                tmp = cargo[from-1].pop(move)
                tmp.each do |c|
                    cargo[to-1] << c
                end
            end
            lasts = ""
            cargo.each do |col|
                lasts += col.last
            end
            lasts
        end

        private

        #Processes the dataset as a whole
        def process_dataset(set)
            cargo, moves = set.split("\n\n")
            cargo = cargo.split("\n")[0..-2].map {|l| l.chomp.split('')}.transpose().map {|l| l.reverse}
            cargo.map {|l| l.delete(' ')}
            cargo.map {|l| l.delete('[')}
            cargo.map {|l| l.delete(']')}
            cargo.delete_if {|l| l == []}

            moves = moves.split("\n").map {|l| l.split(" ")}
            moves.map{ |move| move.delete("move")}
            moves.map{ |move| move.delete("from")}
            moves.map{ |move| move.delete("to")}
            moves = moves.map {|l| l.map {|c| c.to_i}}

            return cargo, moves
        end
    end
end
