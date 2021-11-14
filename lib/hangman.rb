#We're doing a hangman!
#Computer generated word, human guesser
#Need a "game" class to play, save, and load
#Player class to prompt for guesses, keep track of letters guessed
#Computer class to store the correct word

class Player
  attr_accessor :guess, :guessed_words, :guessed_letters
  def initialize()
    @guessed_words = []
    @guessed_letters = []
  end
  def guess()
    puts "Enter a guess"
    guess = gets.chomp
    return guess
  end

  def add_guessed_letter(letter)
    @guessed_letters.append(letter)
  end

  def add_guessed_word(word)
    @guessed_words.append(word)
  end

  def add_guess(guess)
    if guess.length == 1
      add_guessed_letter(guess)
    else
      add_guessed_word(guess)
    end
  end
end

class Computer
  attr_accessor :word, :progress
  def initialize()
    #@word = generate_word().downcase
    @word = "test"
    @progress = word.gsub(/\S/, '_ ').strip
  end

  private
  def generate_word()
    #Read in 5desk.txt
    contents = File.read("5desk.txt")
    contents.gsub!(/\r/,"").gsub!(/\n/," ")
    valid_words = contents.split(" ").filter{|word| word.length >=5 && word.length<=12}
    valid_words.sample
  end
end

class Game
  def play
    @computer = Computer.new()
    @player = Player.new()
    while true
      guess = get_valid_guess()
      @player.add_guess(guess)
      if game_over?(guess)
        return true
      end
      puts "Guessed Letters: #{@player.guessed_letters}"
      puts "Guessed Words: #{@player.guessed_words}"
    end
  end

  def get_valid_guess()
    #Guess needs to be either 1 letter, or match the size of the correct word"
    guess = @player.guess()
    if guess.length == 1
      if @player.guessed_letters.include? guess
        puts "Letter already guessed, please enter a new guess"
        get_valid_guess()
      else
        return guess
      end
    elsif guess.length == @computer.word.length
      if @player.guessed_words.include? guess
        puts "Word already guessed, please enter a new guess"
        get_valid_guess()
      else
        return guess
      end

    else
      puts "Invalid guess, please guess again"
      get_valid_guess()
    end
      
    return guess

  end

  def check_matches(guess)
  end

  def game_over?(guess)
    if guess == @computer.word
      return true
    else
      return false
    end
  end
end

computer = Computer.new()
p computer.word
p computer.progress
player = Player.new()
game = Game.new()
game.play