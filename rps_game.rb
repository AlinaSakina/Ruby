if ARGV.length != 1
  puts "Будь ласка, передайте один аргумент: ваш вибір."
  puts "Приклад використання: rps_game.rb камінь"
  exit
end

player_choice = ARGV[0].downcase

valid_choices = ["камінь", "ножиці", "папір"]

unless valid_choices.include?(player_choice)
  puts "Неправильний вибір. Допустимі варіанти: камінь, ножиці, папір."
  exit
end

computer_choice = valid_choices.sample

def determine_winner(player, computer)
  if player == computer
    "Нічия!"
  elsif (player == "камінь" && computer == "ножиці") ||
        (player == "ножиці" && computer == "папір") ||
        (player == "папір" && computer == "камінь")
    "Ви виграли!"
  else
    "Комп'ютер виграв!"
  end
end

result = determine_winner(player_choice, computer_choice)
puts "Ваш вибір: #{player_choice.capitalize}"
puts "Вибір комп'ютера: #{computer_choice.capitalize}"
puts result
