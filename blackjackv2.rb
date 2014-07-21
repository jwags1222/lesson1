#blackjackv2

#fill the deck 
deck1 = [[2, "two of Hearts"], [3, "three of Hearts"], [4, "four of Hearts"], [5, "five of Hearts"], [6, "six of Hearts"], [7, "seven of Hearts"],
[8, "eight of Hearts"], [9, "nine of Hearts"], [10, "ten of Hearts"], [10, "Jack of Hearts"], [10, "Queen of Hearts"], [10, "King of Hearts"],
[11, "Ace of Hearts"], [2, "two of Clubs"], [3, "three of Clubs"], [4, "four of Clubs"], [5, "five of Clubs"], [6, "six of Clubs"], [7, "seven of Clubs"],
[8, "eight of Clubs"], [9, "nine of Clubs"], [10, "ten of Clubs"], [10, "Jack of Clubs"], [10, "Queen of Clubs"], [10, "King of Clubs"],
[11, "Ace of Clubs"], [2, "two of Spades"], [3, "three of Spades"], [4, "four of Spades"], [5, "five of Spades"], [6, "six of Spades"], [7, "seven of Spades"],
[8, "eight of Spades"], [9, "nine of Spades"], [10, "ten of Spades"], [10, "Jack of Spades"], [10, "Queen of Spades"], [10, "King of Spades"],
[11, "Ace of Spades"], [2, "two of Diamonds"], [3, "three of Diamonds"], [4, "four of Diamonds"], [5, "five of Diamonds"], [6, "six of Diamonds"], [7, "seven of Diamonds"],
[8, "eight of Diamonds"], [9, "nine of Diamonds"], [10, "ten of Diamonds"], [10, "Jack of Diamonds"], [10, "Queen of Diamonds"], [10, "King of Diamonds"],
[11, "Ace of Diamonds"]]

#this method will get a new deck.  Will only be used after a number of plays. There is likely an easier way to do this I'm sure  
def newdeck_shuffle (deck)
deck = [[2, "two of Hearts"], [3, "three of Hearts"], [4, "four of Hearts"], [5, "five of Hearts"], [6, "six of Hearts"], [7, "seven of Hearts"],
[8, "eight of Hearts"], [9, "nine of Hearts"], [10, "ten of Hearts"], [10, "Jack of Hearts"], [10, "Queen of Hearts"], [10, "King of Hearts"],
[11, "Ace of Hearts"], [2, "two of Clubs"], [3, "three of Clubs"], [4, "four of Clubs"], [5, "five of Clubs"], [6, "six of Clubs"], [7, "seven of Clubs"],
[8, "eight of Clubs"], [9, "nine of Clubs"], [10, "ten of Clubs"], [10, "Jack of Clubs"], [10, "Queen of Clubs"], [10, "King of Clubs"],
[11, "Ace of Clubs"], [2, "two of Spades"], [3, "three of Spades"], [4, "four of Spades"], [5, "five of Spades"], [6, "six of Spades"], [7, "seven of Spades"],
[8, "eight of Spades"], [9, "nine of Spades"], [10, "ten of Spades"], [10, "Jack of Spades"], [10, "Queen of Spades"], [10, "King of Spades"],
[11, "Ace of Spades"], [2, "two of Diamonds"], [3, "three of Diamonds"], [4, "four of Diamonds"], [5, "five of Diamonds"], [6, "six of Diamonds"], [7, "seven of Diamonds"],
[8, "eight of Diamonds"], [9, "nine of Diamonds"], [10, "ten of Diamonds"], [10, "Jack of Diamonds"], [10, "Queen of Diamonds"], [10, "King of Diamonds"],
[11, "Ace of Diamonds"]]

deck.shuffle!
end 


#declare the player and dealer hands
dealers_hand = Array.new
players_hand = Array.new 

#shuffle the first deck 
deck1.shuffle!

#removes card from the shuffled deck
def draw_card (deck)
  deck.pop
end 

#this is the dealers play, method takes in the dealers hand, and the deck and returns an arrray 
#of a integer representing the hand value and a boolean var to represent if the dealer had busted
def dealer_play (hand, deck)

hand_value = hand.first.first + hand.last.first # initial hand value 
bj_or_busted= [hand_value, false] 

puts "Dealer turns over his hole card and has a #{hand.last.last}"
puts "He has #{hand_value}"
sleep(2)

  while hand_value < 17 
    puts "Dealer to hit"
    sleep(2)
    new_card = draw_card (deck)
    hand_value = new_card.first + hand_value 
    
    if hand_value > 21 && new_card.first == 11
      hand_value = hand_value - 10 # make the ace worth one 
    end 

    puts "Dealer draws a #{new_card.last}, he has #{hand_value}"

  end

  if hand_value >21 
  puts "YOU WIN!!! dealer busts"
  bj_or_busted[0] = hand_value
  bj_or_busted[1] = true
  return bj_or_busted
  else 
  puts "Dealer stands on #{hand_value}"
  bj_or_busted[0] = hand_value
  end  
return bj_or_busted
end 

#similar to the dealer play method except with user interation
def player_play (hand, deck, name)
  hand_value = hand.first.first + hand.last.first
  
  bj_or_busted = [hand_value, false]
  
  bj_or_busted[1] = is_blackjack(hand)
  
  if bj_or_busted[1]
  puts "Blackjack #{name}!!!, you win!"
  return bj_or_busted
  end 
  puts "Ok #{name}, you have #{hand_value}"
  

  puts "Press 1 to hit and 2 to stand"
  hit = gets.chomp

    while hit == "1"

    puts "Hitting #{hand_value}"
    sleep(2) 
    draw_card(deck)
    new_card = draw_card(deck)
    hand_value = new_card.first + hand_value 

    if hand_value > 21 && new_card.first == 11
      hand_value = hand_value - 10 # make the ace worth one if it makes you bust 
    end 

    puts "You drew a #{new_card.last}, you have #{hand_value}"
    bj_or_busted[0] = hand_value

    
    
    if hand_value > 21 
      puts "You've Busted, sorry dealer wins"
      bj_or_busted[1] = true 
      return bj_or_busted
    end 


    puts "Would you like to hit or stand press 1 or 2"
    hit = gets.chomp

    end
    
    if hit == 2 
    puts "Standing on #{hand_value}"
    end 
return bj_or_busted
end 

def fix_ace(card)
  if card == 11 
  card = 1 
  return card
  else
  return card  
  end 
end 

def is_blackjack(hand)
  blackjack=false
  if hand.first.first + hand.last.first == 21
    blackjack = true 
  end 
end


#starts of execution
play_again = 'y'
reshuffle = 0 
player_blackjack = false 

puts "Thanks for stopping by to play some blackjack"
print "What is your name?"
player_name = gets.chomp


while play_again == 'y'

#need to clear the hands for a new hand 
players_hand.clear
dealers_hand.clear  

reshuffle += 1 
if reshuffle > 3 
  puts "One moment, getting new deck and a new shuffle"
  sleep(3)
  newdeck_shuffle(deck1)
  puts "We're ready now"
  reshuffle = 1
end 

puts "Alright then lets play #{player_name}"
sleep(2)
players_hand << draw_card(deck1)
puts "#{player_name} is dealt a #{players_hand.last.last}"
sleep (2)

dealers_hand << draw_card(deck1)
puts "Dealer is dealt a #{dealers_hand.last.last}"
sleep(2)
players_hand << draw_card(deck1)
puts "#{player_name} was dealt a #{players_hand.last.last} for your second card"

if players_hand.first.first + players_hand.last.first == 22 
  puts "your second ace will be worth 1"
  players_hand[1][0] = 1 
end 

player_blackjack = is_blackjack(players_hand)
if player_blackjack
  puts "BLACKJACK YOU WIN"
else 
sleep(2)

#dealers_hand << draw_card(deck1)

dealers_hand << draw_card(deck1)
puts "The Dealer has #{dealers_hand.first.first} showing" 
sleep(2)


#this accounts for a dealer blackjack prior to the start of play
#it executes when dealers up card is face or ace

if dealers_hand.first.first == 10 || dealers_hand.first.first == 11 
  puts "Dealer checking for blackjack"
  sleep(2)
  peek = is_blackjack(dealers_hand)
  
  if peek
  puts "BLACKJACK, sorry dealer wins"
  puts "Dealer shows #{dealers_hand.first.last} and a #{dealers_hand.last.last}" 
  else
  puts "The dealer doesnt have blackjack" 
  end 
end

if peek != true  
player_total = player_play(players_hand, deck1, player_name)

#dealer will play only if bollean value isnt true.  True is if the player got blackjack or busted
if player_total[1] != true
  dealer_total = dealer_play(dealers_hand, deck1)
  
  #we already know the dealer doesnt have blackjack, but this wont execute if dealer busted
  if dealer_total[1] != true 
    #if we're here it means we have to compare hands. neither busted or got blackjack so larger hand wins
    if dealer_total[0] > player_total[0]
      puts "Sorry dealer wins with #{dealer_total[0]} to your #{player_total[0]}"
    elsif dealer_total[0] == player_total[0]
      puts "No winners here, the hands push.  Dealers has #{dealer_total[0]},you have #{player_total[0]}"
    else
      puts "You win with #{player_total[0]} the dealer only has #{dealer_total[0]}"
    end 
  end 
end 

end 
end 

puts "Would you like to play again #{player_name} (y/n)?"
play_again = gets.chomp

end 