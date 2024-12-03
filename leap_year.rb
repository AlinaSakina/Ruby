def leap_year_input
  puts "Введіть рік для перевірки, чи він є високосним:"
  input = gets.chomp

  begin
    year = Integer(input)
    if leap_year?(year)
      puts "#{year} є високосним роком."
    else
      puts "#{year} не є високосним роком."
    end
  rescue ArgumentError
    puts "Помилка: введіть ціле число більше 0."
  end
end

def leap_year?(year)
  raise ArgumentError, "Рік має бути додатним цілим числом" unless year.is_a?(Integer) && year > 0
  (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
end

leap_year_input
