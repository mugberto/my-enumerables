module Enumerable
  def my_each
    return enum_for unless block_given?

    if is_a? Hash
      (obj = to_a).length.times { |i| yield obj[i][0], obj[i][1] }
    else
      (obj = is_a?(Array) ? self : to_a).length.times { |i| yield obj[i] }
    end
  end

  def my_each_with_index
    return enum_for unless block_given?

    (arr = is_a?(Array) ? self : to_a).size.times { |i| yield(arr[i], i) }
  end

  def my_select
    return enum_for unless block_given?

    if is_a? Hash
      hash = {}
      my_each { |k, v| hash[k] = v if yield(k, v) }
      hash
    else
      arr = []
      my_each { |i| arr << i if yield i }
      arr
    end
  end

  def my_all?(obj = Object)
    out_value = true
    if block_given?
      my_each { |i| out_value = false unless yield(i) }
    elsif obj.is_a?(Class)
      my_each { |i| out_value = false unless i }
    else
      my_each { |i| out_value = false unless i == obj }
    end
    out_value
  end

  def my_any?(obj = Object)
    out_value = false
    if block_given?
      my_each { |i| out_value = true if yield(i) }
    elsif obj.is_a? Class
      my_each { |i| out_value = true if i.is_a?(obj) }
    else
      my_each { |i| out_value = true if i == obj }
    end
    out_value
  end

  def my_none?(obj = Object)
    out_value = true
    if block_given?
      my_each { |i| out_value = false if yield(i) }
    elsif obj.is_a?(Class)
      my_each { |i| out_value = false if i }
    else
      my_each { |i| out_value = false if i == obj }
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

  # my_map that takes a proc
  def my_map2(my_proc)
    arr = []
    my_each { |i| arr << my_proc.call(i) }
    arr
  end

  # my_map that takes a proc or block
  def my_map3(my_proc)
    arr = []
    block_given? ? my_each { |i| arr << yield(i) } : my_each { |i| arr << my_proc.call(i) }
    arr
  end

  def my_inject(*args)
    if block_given? && args[0].nil?
      acc = to_a[0]
      to_a[1..-1].my_each { |i| acc = yield(acc, i) }
    elsif block_given?
      acc = args[0]
      my_each { |i| acc = yield(acc, i) }
    elsif args.size == 2
      acc = args[0]
      my_each { |i| acc = acc.send(args[1], i) }
    elsif args.size == 1
      acc = to_a[0]
      to_a[1..-1].my_each { |i| acc = acc.send(args[0], i) }
    end
    acc
  end
end

# multiply_els method to test #my_inject
def multiply_els(arr)
  arr.my_inject(:*)
end
