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

  def my_all?(obj = Object)
    arr = to_a
    out_value = true
    if block_given?
      arr.my_each { |i| out_value = false unless yield(i) }
    elsif obj.is_a?(Class)
      arr.my_each { |i| out_value = false unless i }
    else
      arr.my_each { |i| out_value = false unless i == obj }
    end
    out_value
  end

  def my_any?(obj = Object)
    arr = to_a
    out_value = false
    if block_given?
      arr.my_each { |i| out_value = true if yield(i) }
    elsif obj.is_a? Class
      arr.my_each { |i| out_value = true if i.is_a?(obj) }
    else
      arr.my_each { |i| out_value = true if i == obj }
    end
    out_value
  end
end

