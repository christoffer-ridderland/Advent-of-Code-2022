def main()
    inputs = File.open("input.txt").readlines.to_a.map{|l| l.chomp.split("")}.map{|l| [l[0..l.length/2.floor-1], l[l.length/2..-1]]}
    prios = ["OFFSET OFF-BY-ONE-ERROR", *('a'..'z'), *('A'..'Z')]
    sum = 0
    inputs.each do |(a,b)|
        sum += prios.index((a & b)[0])
    end
    return sum
end


def mainb()
    inputs = File.open("input.txt").readlines.each_slice(3).to_a.map{|l| l.map{|elf| elf.chomp.split("")}}
    prios = ["OFFSET OFF-BY-ONE-ERROR", *('a'..'z'), *('A'..'Z')]
    sum = 0
    inputs.each do |(a,b,c)|
        sum += prios.index((a & b & c)[0])
    end
    return sum
end

if __FILE__ == $0 then p main(); p mainb() end