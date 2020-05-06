require "pry"
class CommandLineInterface

    require "tty-prompt"


    def run
    logo
    login
    instance_of_user
    
    menu_1
    end

def instance_of_user
    @user = Customer.all.find {|a| a.username == @username}
end


def clear
    print "\e[2J\e[f"
end


def logo
    puts ''
    a = Artii::Base.new :font => 'roman'
    puts a.asciify('GameStore')
    loading
end 

def loading
    spinner = TTY::Spinner.new("[:spinner] Loading GameStore ...", format: :pulse_2)
    spinner.auto_spin
    sleep(1)
    spinner.stop('Done!')
end

def loading_2
    spinner = TTY::Spinner.new("[:spinner] Loading main menu ...", format: :bouncing_ball)
    spinner.auto_spin
    sleep(1)
    spinner.stop('Done!')
end 

def main_menu_logo
    prompt = Artii::Base.new
    puts a.asciify('Welcome to the GameStore')
end
# This will be the first menu
def menu_1
    system"clear"
    # create, read, update, delete
    # List of games = Read
    # My games for sale = Read
    # Post a New game for sale = Create
    # Delete a game for sele = Delete
    # My account + Change my Username + Change my Password = Update
    loading_2
    puts ''
    puts ''

	puts "##########################################################################"
	puts "#                            Games Store                                 #"
	puts "#-------------------------------------------------------------------------"
	puts "#                                                                        #"
    puts "#    Welcome to the main menu! From here you can do the following:       #"
    puts "#                                                                        #"
    puts "#       Type in the number on the left side of your desired option       #"
    puts "#                                                                        #"
	puts "#       1) List of games                                                 #"
	puts "#       2) My games for sale                                             #"
	puts "#       3) Post a New game for sale                                      #"
    puts "#       4) Delete a game you're selling                                  #"
    puts "#       5) My account                                                    #"
    puts "#       6) Exit                                                          #"
	puts "#                                                                        #"
	puts "##########################################################################"
    puts"\n\n"
    puts "Type in a number"
    input = gets.chomp
    if input == "1"
        puts ''
        puts 'List of games'
        #method
        list_of_games 
    elsif input == "2"
        puts ''
        puts ''
        #method
        user_games_for_sale
    elsif input == "3"
        #method
        post_game_for_sale
    elsif input == "4"
        #method
        delete_a_game_post
    elsif input == "5"
        system"clear"
        #method
    puts "##########################################################################"
	puts "#                            Games Store                                 #"
	puts "#-------------------------------------------------------------------------"
	puts "#                                                                        #"
    puts "#                          User account Menu                             #"
    puts "#                                                                        #"
    puts "#       Type in the number on the left side of your desired option       #"
    puts "#                                                                        #"
	puts "#       1) Change my Username                                            #"
	puts "#       2) Change my Password                                            #"
    puts "##########################################################################"

    puts "\n\n"
    puts "Type in a number"
    input = gets.chomp
    if input == "1"
        #method
        update_username
    elsif input == "2"
        puts ''
        puts ''
        #method
        update_password
    end
    elsif input == "6"

        puts "See you soon!"
        sleep(3)
        print "\e[2J\e[f"
        exit!
    
    else 
        invalid_response
        puts ''
        menu 
    end 
    
    
    def invalid_response
        puts Paint["I'm not familiar with that command. Please try again", :red, :bright, :underline]
    end
end

# This is the loging method that we used at the start of the program
# There are something missing like
# 1 Able to create a User if there it is a new customer
# 2 Hide the password with a mask some how

def customer_list
    Customer.all.map {|x|x.username}
end 

def login
    #first puts a answer and get the input of the customer
    puts "Please enter your username:"   
    @username = gets.chomp
    temp = Customer.find_by(username: @username)
    #this if statement tells that is wrong start again the method or continue
    
    if !temp
       puts "Please check again" 
       login
    else
        puts "Perfect, Now your password:" 
    
        password = gets.chomp
        temp_2 = Customer.find_by(password: password)
        # Same as the last if statemant but with the password
        if !temp_2
            puts "Wrong password, please try again"
            login
        else
            puts "Welcome back #{temp.username}"
        end
    end
end


def list_of_games
    system"clear"
    puts "-------------------------------------------------------------------------"
    puts "This is the list of games"
    puts "-------------------------------------------------------------------------"

    Game.all.map do |d|
        puts "#{d.title},"
        puts 
    end
    puts ''
    puts "Please type \'back\' to return to main menu"
     input = gets.chomp
     if input == "back"
    menu_1
    else 
    list_of_games
    puts ''
    invalid_response
    end
end


def user_games_for_sale
    system"clear"

    puts "These are all your games for sale"

    #logging
    #username: Manuel (como un input)
    game = Game.all.each do|g|  
        if g.customer_id == @user.id
        puts "#{g.title},"
        end

    end
    puts ''
    puts "Please type \'back\' to return to main menu"
     input = gets.chomp
     if input == "back"
    menu_1
    else 
    list_of_games
    puts ''
    invalid_response
    end
end


def create_recipt
    Receipt.create(customer_id: @user.id, game_id: Game.last.id, total_price: @price)
    puts "##########################################################################"
	puts "#                            Games Store                                 #"
	puts "#-------------------------------------------------------------------------"
    puts "#       This is your confimation that the game was Posted"
    puts "#"
    puts "#       The game was posted by  the user: #{@user.username}"
    puts "#"
    puts "#       Title: #{@title}"
    puts "#       Genre: #{@genre}"
    puts "#       Price: #{@price}"
    puts "#"
    puts "##########################################################################"
end

def post_game_for_sale
    system"clear"
    #Tomorrow need to make a recipt and show it in console for the requirements of the project.
    puts "What is the title of your game?"
    @title = gets.chomp
    puts "What is the genre of the game?"
    @genre = gets.chomp
    puts "what is the price of the game?"
    @price = gets.chomp

    Game.create(title: @title, genre: @genre, price: @price, customer_id: @user.id)

    create_recipt


    puts ''
    puts "Please type \'back\' to return to main menu"
     input = gets.chomp
     if input == "back"
    menu_1
    else 
    list_of_games
    puts ''
    invalid_response
    end
end

def delete_a_game_post
    system"clear"
    puts "What is the title of the game you want to delete"
    puts ''
    game = gets.chomp

    Game.all.find_by(title: game).destroy

    puts ''
    puts "These are your games for sale now"
    user_games_for_sale
    
    puts ''
    puts "Please type \'back\' to return to main menu"
     input = gets.chomp
     if input == "back"
    menu_1
    else 
    list_of_games
    puts ''
    invalid_response
    end
end

def update_username
    system"clear"
    puts "Pleas type your new Username"

    new_username = gets.chomp

    @user.update(username: new_username)
    puts "Your username has been updated."

    puts ''
    puts "Please type \'back\' to return to main menu"
     input = gets.chomp
     if input == "back"
    menu_1
    else 
    list_of_games
    puts ''
    invalid_response
    end
end

def update_password
    system"clear"
    puts "Please type in your password to change it"

    acutal_password = gets.chomp

    if acutal_password == @user.password

    puts "Now your new password"
    new_password = gets.chomp


    @user.update(password: new_password)
    puts "Your password have been updated."

    elsif

        puts "Wrong password, please try again"
        update_password
    end

    puts ''
    puts "Please type \'back\' to return to main menu"
     input = gets.chomp
     if input == "back"
    menu_1
    else 
    list_of_games
    puts ''
    invalid_response
    end
end
end

