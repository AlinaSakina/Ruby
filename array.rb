def average(arr)
  return 0 if arr.empty?  #якщо масив порожній, повертаємо 0

  unless arr.all? { |element| element.is_a?(Numeric) }  #помилка при вводі тексту
    raise ArgumentError, "Усі елементи масиву повинні бути числами."
  end

  sum = arr.sum #підсумовуємо елементи
  sum.to_f / arr.size  #обчислюємо середнє як float
end


#тестування
def test_average
  result1 = average([1, 2, 3])
  puts "Test 1: Середнє значення масиву [1, 2, 3] = #{result1} (очікувано 2.0)"

  result2 = average([10, 20, 30, 40])
  puts "Test 2: Середнє значення масиву [10, 20, 30, 40] = #{result2} (очікувано 25.0)"

  result3 = average([0, 0, 0, 0])
  puts "Test 3: Середнє значення масиву [0, 0, 0, 0] = #{result3} (очікувано 0.0)"

  result4 = average([5])
  puts "Test 4: Середнє значення масиву [5] = #{result4} (очікувано 5.0)"

  result5 = average([])
  puts "Test 5: Середнє значення порожнього масиву = #{result5} (очікувано 0)"

  result6 = average(["АртурМорган"])
  puts "Test 6: Середнє значення порожнього масиву = #{result6} (очікувана помилка)"
end

test_average
