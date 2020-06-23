module Enumerable
  def my_each
    return enum_for unless block_given?

    if is_a? Hash
      to_a.length.times { |i| yield arr[i][0], arr[i][1] }
    else
      (is_a?(Array) ? self : to_a).length.times { |i| yield obj[i] }
    end
  end

  def my_each_with_index
    return enum_for unless block_given?

    (is_a?(Array) ? self : to_a).size.times { |i| yield(arr[i], i) }
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

  def my_none?(obj = Object)
    arr = to_a
    out_value = true
    if block_given?
      arr.my_each { |i| out_value = false if yield(i) }
    elsif obj.is_a?(Class)
      arr.my_each { |i| out_value = false if i }
    else
      arr.my_each { |i| out_value = false if i == obj }
    end
    out_value
  end

  def my_count(obj = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) }
    elsif obj
      my_each { |i| count += 1 if obj == i }
    else
      my_each { |_i| count += 1 }
    end
    count
  end

  def my_map
    return enum_for unless block_given?

    arr = []
    my_each { |i| arr << yield(i) }
    arr
  end

  def my_inject(*args)
    if block_given?
      acc = args[0].nil? ? self[0] : args[0]
      my_each { |i| acc = yield(acc, i) }
    elsif args.size == 2
      acc = args[0]
      my_each { |i| acc = acc.send(args[1], i) }
    elsif args.size == 1
      acc = 0
      my_each { |i| acc = acc.send(args[0], i) }
    end
    acc
  end
end
