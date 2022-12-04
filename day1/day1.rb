
def main()
    return File.open("input.txt").read().split("\n\n").map {|elf| elf.split().map {|calories| calories.to_i}.sum}.max
end
def mainb()
    return File.open("input.txt").read().split("\n\n").map {|elf| elf.split().map {|calories| calories.to_i}.sum}.max(3).sum
end
#p File.open("input.txt").read().split("\n\n").map {|elf| elf.split().map {|calories| calories.to_i}.sum}.each_with_index.max[1]

if  __FILE__ == $0 then p main(); p mainb() end