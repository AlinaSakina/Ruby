def precedence(op)
  case op
  when '+', '-'
    1
  when '*', '/'
    2
  else
    0
  end
end

def is_operator?(c)
  ['+', '-', '*', '/'].include?(c)
end

def to_rpn(expression)
  output = []
  operators = []

  expression.split.each do |token|
    if token =~ /\d+/  
      output << token
    elsif is_operator?(token)
      while operators.any? && precedence(operators.last) >= precedence(token)
        output << operators.pop
      end
      operators << token
    end
  end

  while operators.any?
    output << operators.pop
  end

  output.join(' ')
end

# Основна частина програми
puts "Введіть математичний вираз (наприклад, '2 + 1 * 4'):"
input = gets.chomp
output = to_rpn(input)
puts "RPN: #{output}"
