def main()
    rounds = File.open("input.txt").readlines.map {|line| line.split(' ')}
    score = 0
    rounds.each do |round|
        score += Hash['X' => 1, 'Y' => 2, 'Z' => 3][round[1]]
        score += scoreWin(round[0], round[1])
    end
    return score
end


def scoreWin(elf, you)
    if elf == Hash['X' => 'A', 'Y' => 'B', 'Z' => 'C'][you]
        return 3
    elsif Hash['X' => 'C', 'Y' => 'A', 'Z' => 'B'][you] == elf
        return 6
    else
        return 0
    end
end

def mainb()
    rounds = File.open("input.txt").readlines.map {|line| line.split(' ')}
    score = 0
    rounds.each do |round|
        score += Hash['X' => Hash['A' => 3, 'B' => 1, 'C' => 2], 'Y' => Hash['A' => 1, 'B' => 2, 'C' => 3], 'Z' => Hash['A' => 2, 'B' => 3, 'C' => 1]][round[1]][round[0]]
        score += Hash['X' => 0, 'Y' => 3, 'Z' => 6][round[1]]
    end
    return score
end

if  __FILE__ == $0 then p main(); p mainb() end