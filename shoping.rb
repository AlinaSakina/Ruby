class ShoppingCart
  def initialize
    @items = []  #масив для зберігання товарів
  end

  def add_item(name, price)
    @items << { name: name, price: price }  #додаємо товар як хеш з ім'ям і ціною
  end

  def total_price
    @items.sum { |item| item[:price] }  #обчислюємо загальну вартість товарів у кошику
  end

  def list_items
    @items.each do |item|
      puts "Товар: #{item[:name]}, Ціна: #{item[:price]}"
    end
  end
end

#використання програми
cart = ShoppingCart.new
cart.add_item("Ноутбук", 1200.5)
cart.add_item("Мишка", 50)
cart.add_item("Клавіатура", 100)

cart.list_items
puts "Загальна вартість: #{cart.total_price}"

#тести програми
def test_shopping_cart_empty
  cart = ShoppingCart.new
  result = cart.total_price
  puts "Test 1: Загальна вартість при порожньому кошику = #{result} (очікувано 0)"
  puts result == 0 ? "Test passed" : "Test failed"
end

def test_shopping_cart_single_item
  cart = ShoppingCart.new
  cart.add_item("Книга", 250)
  result = cart.total_price
  puts "Test 2: Загальна вартість при одному товарі (Книга) = #{result} (очікувано 250)"
  puts result == 250 ? "Test passed" : "Test failed"
end

def test_shopping_cart_zero_price_item
  cart = ShoppingCart.new
  cart.add_item("Книга", 250)
  cart.add_item("Купон на знижку", 0)
  result = cart.total_price
  puts "Test 3: Загальна вартість з товаром з ціною 0 = #{result} (очікувано 250)"
  puts result == 250 ? "Test passed" : "Test failed"
end

def test_shopping_cart_fractional_price_item
  cart = ShoppingCart.new
  cart.add_item("Сік", 3.5)
  cart.add_item("Шоколад", 2.99)
  result = cart.total_price
  puts "Test 4: Загальна вартість з товарами з дробовими цінами = #{result} (очікувано 6.49)"
  puts result == 6.49 ? "Test passed" : "Test failed"
end

def run_tests
  test_shopping_cart_empty
  test_shopping_cart_single_item
  test_shopping_cart_zero_price_item
  test_shopping_cart_fractional_price_item
end

run_tests


