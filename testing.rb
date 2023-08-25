def check_column_win_con(piece)
winner = true
(0..2).to_a.each do |column|
    winner = false unless positions[column] == piece
    2.times do
    column += 3
    winner = false unless positions[column] == piece
    end
    return true if winner == true
    end
winner
end

