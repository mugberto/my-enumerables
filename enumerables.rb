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

  def my_select
    return enum_for unless block_given?

    obj = self
    if obj.is_a? Hash
      hash = {}
      obj.my_each { |k, v| hash[k] = v if yield(k, v) }
      hash
    else
      arr = []
      obj.my_each { |i| arr << i if yield i }
      arr
    end
  end
end

# p({ liquid: 'water', solid: 'rock', gas: 'air', metal: 'copper' }.my_select { |_k, v| v.include? 'a' })
# p (1..10).my_select
# (1...10).my_each {|i| p i}
