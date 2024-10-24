def precedence(op)
  case op
  when '+' then 1
  when '-' then 1
  when '*' then 2
  when '/' then 2
  else 0
  end
end

def infix_to_rpn(expression)
  output = []
  operators = []

  tokens = expression.scan(/-?\d+|[+\-*\/()]/)

  tokens.each do |token|
    if token =~ /-?\d/
      output << token
    elsif token == '('
      operators.push(token)
    elsif token == ')'
      while operators.last != '('
        output << operators.pop
      end
      operators.pop
    else
      while !operators.empty? && precedence(operators.last) >= precedence(token)
        output << operators.pop
      end
      operators.push(token)
    end
  end

  while !operators.empty?
    output << operators.pop
  end

  output.join(' ')
end

def evaluate_rpn(rpn)
  stack = []

  tokens = rpn.split

  tokens.each do |token|
    if token =~ /-?\d/
      stack.push(token.to_i)
    else
      b = stack.pop
      a = stack.pop

      case token
      when '+'
        stack.push(a + b)
      when '-'
        stack.push(a - b)
      when '*'
        stack.push(a * b)
      when '/'
        if b == 0
          raise ZeroDivisionError, "Помилка: ділення на нуль!"
        else
          stack.push(a / b)
        end
      end
    end
  end

  stack.pop
end

puts "Введіть математичний вираз (наприклад, 2 + 1 * -4):"
input = gets.chomp
output = infix_to_rpn(input)
begin
  puts "Введений вираз: #{input}"
  puts "Вираз у RPN: #{output}"
rescue ZeroDivisionError => e
  puts e.message
end







