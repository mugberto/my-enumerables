module Enumerable
  def my_each
    collection = self
    if collection.is_a? Hash
      for element in collection
        yield element[0], element[1]
      end
    else
      for element in collection
        yield element
      end
    end
  end
end