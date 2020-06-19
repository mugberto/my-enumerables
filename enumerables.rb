module Enumerable
  def my_each
    for element in self
      element.is_a?(Array) ? yield(element[0], element[1]) : yield(element)
    end
  end

  def my_each_with_index
    arr = self
    arr = arr.to_a unless arr.is_a? Array
    i = 0
    until i >= arr.size
      yield(arr[i], i)
      i += 1
    end
    arr
  end
end

# { liquid: 'water', solid: 'rock' }.my_each {|k, v| p "#{k} and #{v}"}
# [5,5,8,2,3].my_each {|i| p i}
# (1...10).my_each {|i| p i}
[1,2,3,3,5,6].my_each_with_index {|i, index| p "The #{i} index is at #{index}"}