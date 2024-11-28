def process_array(array)
  array.each do |element|
    yield(element + 1)
  end
end

process_array([1, 2, 3]) { |result| puts result }
