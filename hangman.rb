require "pry"

def hangman_initializer
  dictionary = []
  File.open("/usr/share/dict/words", "r").each_line do |line|
    line.chomp! 
    if line.length >=3 && line.length <= 10
      dictionary.push line
    end
  end
  puts "Welcome to Hangman. Type 'quit' to end the game at any time."
  print "Want to supply a word or phrase? Enter y/n: "
  single = gets.chomp
  if single.downcase == "quit"
    puts "Thanks for playing"
    exit
  elsif single == "n" 
    prng = Random.new
    answer = dictionary[prng.rand(dictionary.size)]
  elsif single != "n" && single != "y"
    puts "Invalid Input"
    return
  else
    print "Enter answer word or phrase: "
    answer = gets.chomp
    if answer == "quit"
      puts "Thanks for playing"
      exit
    else
      system "clear"
    end
  end

  starting_lives = 10
  answer_length = answer.length
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
    puts "Answer was #{answer}"
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
  if letter.downcase == "quit"
    puts "Thanks for Playing"
    exit
  else
    puts ""
    if letter.downcase[/[a-z]/] && !guessed_letters.include?(letter.downcase) && letter.length == 1
      return letter.downcase
    elsif letter.downcase[/[a-z]/] && letter.length == 1
      puts "Letter already guessed, please try again: "
      texter(life, guess, guessed_letters)
    else
      puts "Not a single letter, please try again: "
      texter(life, guess, guessed_letters)
    end
  end
end


hangman_initializer