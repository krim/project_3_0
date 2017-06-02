class FindNums
  class << self
    def simple(numbers)
      min = numbers.min
      max = numbers.max
      ((min..max).to_a - numbers)[0..1]
    end

    def hard(numbers)
      result = []
      index = 0
      min = numbers.min
      max = numbers.max

      (min..max).each do |base_num|
        if base_num != numbers[index]
          result << base_num
          break if result.count == 2
          index -= 1
        end
        index += 1
      end

      result
    end
  end
end
