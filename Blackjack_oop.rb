#require pry 

class Card 
  attr_accessor :suit, :value

  def initialize(v,s)
  @value = v
  @suit = s 
  end 

  def show_card
  print "#{value} of #{suit}"
  end 

  def showing(card)
    if card.value == "Ace"
      return 11
    elsif card.value.to_i == 0 
      return 10 
    else
      return card.value.to_i
    end 
  end 

end 

#thsi is a deck of cards
class Deck 
  attr_accessor :deck

  def initialize
    @deck = []

    ['Hearts', 'Clubs', 'Spades', 'Diamonds'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].each do |face|
        @deck << Card.new(face, suit)
        
      end 
    end 
    deck.shuffle!
  end 

  def draw_card
    deck.pop
  end 
end 

class Player 
  attr_accessor :name, :hand

  def initialize(n,h)
  @name = n
  @hand = [] 

  #player starts hand with 1 card 
  hand << h 

  end 

  def new_card(newcard) 
    @hand << newcard 
  end 


  def total_hand
    total = 0 
    hand.each do |card|
      if card.value == 'Ace'
      total += 11 

      elsif card.value.to_i == 0
      total += 10 

      else  
      total += card.value.to_i  
      end 
    end
#need to correct for aces here. will loop through and count aces then subtract 10 until I get under 21 

  count_aces = 0 
  hand.each do |card|
      if card.value == 'Ace'
        count_aces += 1 
      end 
      end 

      while count_aces != 0 
        if total > 21
          total -= 10
        end
        count_aces -= 1  
      end 


    total 
  end 

#play method
  def play (player, deck)
    action = 0 

    while (action != 2 )

    puts "Press 1 to hit press 2 to stay"
    action = gets.chomp.to_i 
    
    if action == 1 
      puts "hitting #{player.total_hand}"
      sleep(1)
      player_card = deck.draw_card 
      print "You drew a "
      player.new_card(player_card)
      player_card.show_card
      sleep(1)
      player.show_hand


      puts "\nYou now have #{player.total_hand}"
      sleep(2)
        if player.total_hand > 21 
          puts "Sorry you bust, dealer wins"
          return -1 
          break 
        end 
    elsif action != 1 && action != 2 
    puts "you must enter a 1 or a 2" 
    end 
  end 

  if action == 2 
    puts "Standing on #{player.total_hand}"
    puts "Lets see what the deler has "
    sleep (2)
  end 

  end 


  def show_hand
  puts "\n#{name} your hand is now "
  puts
  print "|| "
  hand.each {|card| print card.show_card.to_s + " || "}
  puts "\n"
  sleep (1)
  end 
  
end 

class Dealer < Player 
  attr_accessor :name, :hand

  def initialize(n,h)
  @name = n
  @hand = [] 

  #player starts hand with 1 card 
  hand << h 

  end 
#overrides player play method 
  def play (dealer, deck)
    print "Dealer turns over his hole card and he has a "
    dealer.hand[1].show_card 
    sleep(2)
    dealer.show_hand
    sleep(1)

    while dealer.total_hand < 17
     puts "Dealer to hit on #{dealer.total_hand}"
     sleep(2)
     dealer.new_card(deck.draw_card)
     dealer.show_hand
    end

    


    puts "\nDealer total is #{dealer.total_hand}" 
    sleep(1)
    dealer.total_hand
    if dealer.total_hand > 21
      puts "Dealer busts you win!!!"
      return -1 
    end 
  end
 
 def show_hand
  puts "\nThe dealers hand is now "
  puts
  print "|| "
  hand.each {|card| print card.show_card.to_s + " || "}
  puts "\n"
  sleep (1)
  end 
end


#class Blackjack
# attr_accessor :player, :card, :deck, :dealer 

#  def initialize 
#    @player = Player.new(name,card)
#    @deck = Deck.new
#    @dealer = Dealer.new(dealer, card)
#    @card = Card.new(face,suit)
#  end 

#  def run

#  end

#end 

puts "Hey its you, welcome back to Blackjack"
sleep (1)
print "What was your name again?"
name = gets.chomp 


puts "Nice to see you again #{name}"
sleep(1)

play_again = 'y'

while play_again == 'y'
puts "OK lets play......"
sleep(1)
#Deck1 is an array of card objects 
deck1 = Deck.new 

#Player now has a name and a 1 card hand 
player_card = deck1.draw_card 
player1 = Player.new(name, player_card )

print "\n#{name} is dealt a "
player_card.show_card
sleep(2)

dealer_card = deck1.draw_card 
dealer = Dealer.new("Dealer", dealer_card)
print "\nDealer is dealt a "
dealer_card.show_card
sleep(2)

player_card = deck1.draw_card 
print "\n#{name} your second card is a "
player1.new_card(player_card)
player_card.show_card
sleep(2)

#need to show hand and total 
player1.show_hand
sleep(2)


dealer.new_card(deck1.draw_card)


puts "\n#{player1.name}, you have #{player1.total_hand}" 

#nextcard.show_card
print "Dealer shows a "

face = dealer.hand[0].showing(dealer.hand[0])
puts face 

#logic below accounts for blackjack for player and a tie for blackjack
if player1.total_hand == 21
  puts "BLACKJACK!!"
  sleep(1)
  if face == 10 || face == 11 
  puts "Dealer has #{face} showing lets see if he has blackjack too"
  sleep(2)
    if dealer.total_hand == 21 
    puts "Sorry, dealer has blackjack too, its a push" 
    sleep(1)
    else 
    puts "Congrats, you win!!!"
    end 
  end 


else 
  if face == 10 || face == 11 
  puts "Dealer has #{face} showing lets see if he has blackjack"
  sleep(2)
    if dealer.total_hand == 21 
    puts "Dealer Blackjack, you lose" 
    else 
    puts "the dealer does not have blackjack"
    sleep(1)
    ptotal = player1.play(player1, deck1)
   
      if ptotal != -1 
      dtotal = dealer.play(dealer, deck1)
      
        if dtotal!= -1 
          if player1.total_hand > dealer.total_hand
            puts "#{name} you win "
            puts "You have #{player1.total_hand} and the dealer has #{dealer.total_hand}"

          elsif player1.total_hand == dealer.total_hand
          puts "Its a push, sorry no winner"

          else 
            puts "Sorry you lose the dealer has #{dealer.total_hand} and you have #{player1.total_hand}"
          end 

        end 

      end 
    end 

else 
    ptotal = player1.play(player1, deck1)
      if ptotal != -1 
        dtotal = dealer.play(dealer,deck1)
          if dtotal != -1 
            if player1.total_hand > dealer.total_hand
            puts "#{name} you win "
            puts "You have #{player1.total_hand} and the dealer has #{dealer.total_hand}"

          elsif player1.total_hand == dealer.total_hand
            puts "Its a push, sorry no winner"

          else 
            puts "Sorry you lose the dealer has #{dealer.total_hand} and you have #{player1.total_hand}"
          end
        end
      end   
  end 
end 

puts "Would you like to play again press (y or n)"
play_again = gets.chomp 

if play_again == 'n'
  puts "Thanks for playing again #{name}, come back soon" 
end 
end 