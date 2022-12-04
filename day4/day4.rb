
def main()
    inputs = File.open("input.txt").readlines.map{|l| l.chomp.split(',').map{|m| m.split('-').map{ |n| n.to_i}}}
    sum = 0
    inputs.each do |a,b|
        if (a[0] <= b[0]) && (a[1] >= b[1]) # b in a
            sum += 1
        elsif (a[0] >= b[0]) && (a[1] <= b[1]) # a in b
            sum += 1
        end
    end
    return sum
end
def mainb()
    inputs = File.open("input.txt").readlines.map{|l| l.chomp.split(',').map{|m| m.split('-').map{ |n| n.to_i}}}
    sum = 0
    inputs.each do |a,b|
        if (a[0] <= b[1]) && (a[1] >= b[0]) # b in a
            sum += 1
        end
    end
    return sum
end

if  __FILE__ == $0 then p main(); p mainb() end