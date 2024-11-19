def find_raisins(cake)
  raisins = []
  cake.each_with_index do |row, i|
    row.chars.each_with_index do |cell, j|
      raisins << [i, j] if cell == 'o'
    end
  end
  raisins
end

def slice_cake(cake)
  raisins = find_raisins(cake)
  total_pieces = raisins.length

  return [] unless total_pieces > 1 && total_pieces < 10

  solutions = []
  height = cake.length
  width = cake.first.length

  (1..total_pieces).each do |row_split|
    next unless height % row_split == 0
    row_step = height / row_split
    slices = []

    (0...height).step(row_step).each do |i|
      slice = cake[i, row_step].join("\n")
      slices << slice
    end

    if slices.all? { |slice| slice.count('o') == 1 }
      solutions << slices
    end
  end

  (1..total_pieces).each do |col_split|
    next unless width % col_split == 0
    col_step = width / col_split
    slices = []

    (0...height).each do |i|
      row_slices = cake[i].chars.each_slice(col_step).map(&:join)
      slices << row_slices
    end

    transposed_slices = slices.transpose
    if transposed_slices.all? { |slice| slice.join.count('o') == 1 }
      solutions << transposed_slices.map { |slice| slice.join("\n") }
    end
  end

  (1..total_pieces).each do |split|
    next unless height % split == 0 && width % split == 0
    row_step = height / split
    col_step = width / split
    mixed_slices = []

    (0...height).step(row_step).each do |i|
      (0...width).step(col_step).each do |j|
        mixed_slice = []
        (i...(i + row_step)).each do |row|
          mixed_slice << cake[row][j...(j + col_step)]
        end
        mixed_slices << mixed_slice
      end
    end

    if mixed_slices.all? { |slice| slice.join.count('o') == 1 }
      solutions << mixed_slices
    end
  end

  solutions
end

cake1 = [
  ".o......",
  "......o.",
  "....o...",
  "..o....."
]

cake2 = [
  "........",
  "..o.....",
  "...o....",
  "........"
]

[cake1, cake2].each_with_index do |cake, index|
  puts "Торт #{index + 1}:"
  results = slice_cake(cake)

  if results.any?
    puts "Можливі розрізання:"
    results.each_with_index do |result, slice_index|
      puts "Розрізання #{slice_index + 1}:"
      result.each do |slice|
        puts slice
        puts "---"
      end
    end
  else
    puts "Не вдалося знайти рішень."
  end
  puts "\n"
end
