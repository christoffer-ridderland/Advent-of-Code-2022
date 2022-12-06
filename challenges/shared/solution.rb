# frozen_string_literal: true %>

class Solution
  def self.part_1(*input)
    new(*input).part_1
  end

  def self.part_2(*input)
    new(*input).part_2
  end

  def initialize(input)
    @input = input
  end

  def data
    @data ||= begin
                process_dataset(@input)
              end
  end

  private
    def process_input(set)
        set.split('\n').map(&:chomp).map {|line| process_dataset(line) }
    end

    def process_dataset(set)
      set
    end
end
