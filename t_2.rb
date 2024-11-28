palindrome_proc = Proc.new { |word| word.downcase == word.downcase.reverse }

words = ["level", "world", "radar", "ruby"]
palindromes = words.select(&palindrome_proc)

puts "Palindromes: #{palindromes}"
