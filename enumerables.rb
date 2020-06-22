module Enumerable
  def my_each
    return enum_for unless block_given?

    if is_a? Hash
      arr = to_a
      i = 0
      while i < arr.length
        yield arr[i][0], arr[i][1]
        i += 1
      end
    else
      obj = is_a?(Array) ? self : to_a
      i = 0
      while i < obj.length
        yield obj[i]
        i += 1
      end
    end
  end

  def my_each_with_index
    return enum_for unless block_given?

    arr = is_a?(Array) ? self : to_a
    arr = arr.to_a unless arr.is_a? Array
    i = 0
    until i >= arr.size
      yield(arr[i], i)
      i += 1
    end
    self
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

  def my_all?
    return true unless block_given?

    bool = true
    case self
    when Hash
      my_each { |k, v| bool = false if yield(k, v) == false }
    else
      my_each { |i| bool = false if yield(i) == false }
    end
    bool
  end
end

# p({ liquid: 'water', solid: 'rock', gas: 'air', metal: 'copper' }.my_select { |_k, v| v.include? 'a' })
# p (1..10).my_select
# (1...10).my_each {|i| p i}
# p [2,3,4,5].my_all? {|i| i.is_a? Numeric}
# p(("a".."z").my_all? {|i| i.is_a? String} )
# [["a", "b"], ["c", "d"]].my_each { |i| p i }
# [2,3,4,5].my_each_with_index {|x| print x, " -- " }

# hash = {}
# %w[cat dog wombat].my_each_with_index
#=> {"cat"=>0, "dog"=>1, "wombat"=>2}
