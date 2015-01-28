require "pry"

def hangman_initializer(lives, answer)
  answer_length = answer.length
  starting_lives = lives
  guessed_letters = []
  guess = "_ " * answer_length
  hangman_player(starting_lives, guessed_letters, guess, answer)
end

def hangman_player lives, guessed_letters, guess, answer
  if !guess.include?("_")
    puts guess
    puts "You Win!"
    return
  elsif lives == 0
    puts "Out of lives, you lose"
    return
  else
    letter = texter(lives, guess, guessed_letters)
    guess = guess
    if answer.include?(letter)
      counter = 0
      answer.each_char do |current_letter|
        if current_letter == letter
          guess[counter] = letter
          counter += 2
        else
          counter += 2
        end
      end
    else
      lives -= 1
    end
    guessed_letters << letter
    hangman_player(lives, guessed_letters, guess, answer)
  end
end


def texter(life, guess, guessed_letters)
  puts "Remaining lives #{life}"
  puts ": #{guess}"
  puts "Guessed Letters: #{guessed_letters}"
  print "Guess a letter: "
  letter = gets.chomp
  if letter.downcase[/[a-z]/]
    return letter
  else
    puts "Not a letter, please try again:"
    texter(life, guess, guessed_letters)
  end
end


hangman_initializer(5, "food")