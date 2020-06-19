module Enumerable
  module Enumerable
    def my_each
      return enum_for unless block_given?

      obj = self
      obj = obj.to_a unless obj.is_a? Array
  
      i = 0
      while i < obj.size
        obj[i].is_a?(Array) ? yield(obj[i][0], obj[i][1]) : yield(obj[i])
        i += 1
      end
      obj
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