require 'pry-byebug'

class ArraySeparate

  def self.start(arr1, arr2, debug: false)
    ArraySeparate.new(arr1, arr2, debug: false).separate
  end

  def initialize(arr1, arr2, debug: false)
    @arr1 = arr1
    @arr2 = arr2
    @debug = debug
  end

  def separate
    arr1_sum = @arr1.sum
    arr2_sum = @arr2.sum
    count = @arr1.length + @arr2.length
    half_summ = (arr1_sum + arr2_sum) / count

    @arr1.sort!
    @arr2.sort!

    count.times do
      ar1_value = @arr1.shift
      ar2_value = @arr2.shift
      if ar1_value < half_summ
        @arr1.push ar1_value
      else
        @arr2.push ar1_value
      end
      if ar2_value < half_summ
        @arr1.push ar2_value
      else
        @arr2.push ar2_value
      end
    end

    @arr1.sort!
    @arr2.sort!

    debug_message @arr1.join(", ")
    debug_message @arr2.join(", ")
    debug_message '-------------'

    [@arr1, @arr2]
  end

  private

  def debug_message(value)
    puts value if @debug
  end

end
