module Enumerable
  def my_each
    for element in self
      element.is_a?(Array) ? yield(element[0], element[1]) : yield(element)
    end
  end
end

# { liquid: 'water', solid: 'rock' }.my_each {|k, v| p "#{k} and #{v}"}
# [5,5,8,2,3].my_each {|i| p i}
# (1...10).my_each {|i| p i}
