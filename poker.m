%   Aiden Walters
%   ITP 168 Spring 2021 
%   Homework 4
%   amwalter@usc.edu

clear; clc;

%% this section will ask the user for how many decks they wanna play with and validate the input
numberOfDecks = input('Enter number of decks to play with: ');

%the following while loop validates the input by making sure its positive
%and making sure its a whole number using the mod function

while numberOfDecks <= 0 || mod(numberOfDecks,1) ~= 0
    fprintf('incorrect input! enter a positive, integervalue! \n')
    numberOfDecks = input('Enter number of decks to play with: ');
end


%% The following code will start the round with a  while loop so that if the user wants to continue
%playing multiple times, the file will start over, and starts the user with
%$100
userCash = 100;
playAgain = 'y';
while strcmpi(playAgain, 'y') 
    
    
    
%% these first two functions will initialize the decks and shuffle based on the
%user input above
decks = initdeck(numberOfDecks);
shuffeledDeck = shuffledeck(decks);
    
    
%% the following code asks for the users bet then validates by making sure
%its a positve whole number and by making sure the bet is less than or equal the
%current amount of cash owned by the user
bet = input('Place your bet: $');

while (bet > userCash) || (bet <= 0) || (mod(bet,1) ~=0)
    fprintf('Invalid bet! must be positive integer & cannot exceed current cash \n')
    bet = input('Place your bet: $');
end


%% this section prints the users current cash
fprintf('You have $%d \n',userCash)

%% This section will deal the user 5 cards to their hand using a for loop
%each iteration will deal a card from the top of the deck, print the card,
%and then return the deck minus the top card
hand = struct('suit', [], 'value', [], 'score', []);
hand = repmat(hand,1,5);

for index = 1:5
[hand(index), restOfDeck] = dealcard(shuffeledDeck);
fprintf('%d: ',index); printcard(hand(index))
shuffeledDeck = restOfDeck;
end

handRank = calchand(hand);      %this line calculates the hand rank based on my function calchand()

%this following code will put the hand rank into words based on the index of
%the following string array. You need to add one to the index because hand
%rank starts at 0, while the string array's index starts at 1

rankString = ["Nothing! Jacks or higher to win","Pair","Two Pair","Three of a kind",...
    "Straight","FLush","Full House","Four of a Kind", "Straight Flush","Royal FLush","Five of a Kind"];

fprintf('you currently have %s\n',rankString(handRank + 1))        %this line prints the users hand rank in words based on the line of code before this line

%% This following section allows the user to swap out cards from their five card hand if they want new cards

%first it asks the user for input, then validates it by checking if the
%if the index has repeats, if the index has a value
%greater than 5 or less than 1, and by making sure there is no repeats by
%checking the length of unique(swapIndex)
swapIndex = input('Swap cards using index values and [], or 0 to keep all your cards: ');


    
    while numel(swapIndex) > 5 || max(swapIndex) > 5 || min(swapIndex) < 0 || length(swapIndex) ~= length(unique(swapIndex)) 
            
        if numel(swapIndex) > 5
            fprintf('Invalid number of cards! Try Again!\n')
        end
        
        if max(swapIndex) > 5 || min(swapIndex) < 1
            fprintf('Index values invalid! Try Again!\n')
        end 
        
        if length(swapIndex) ~= length(unique(swapIndex))
            fprintf('Duplicate values! Try Again!\n')
        end
     
        
        swapIndex = input('Swap cards using index values and [], or 0 to keep all your cards: ');
    end
    %if the user chose to swap, we then swap out the cards in the hand by
    %using the swapIndex and deleteing each card in the index, if the user
    %chose 0, nothing in the hand is changed and the hand remains the same
    if swapIndex == 0
        
    else
    hand(swapIndex) = [];
    
    end
     
     %after those swap cards have been deleted from the hand, this loop
     %iterates to the end of the hand and deals however many cards
     %have been deleted
     
     for index2 = 1:length(swapIndex)
     [hand(6 - index2), restOfDeck] = dealcard(shuffeledDeck);
     shuffeledDeck = restOfDeck;
     end
     
     

     
%the following for loop will print the users new hand after the swapping
%process

for index3 = 1:5
    fprintf('%d: ',index3); printcard(hand(index3))
end

%% Next the users new hand will be put through calc hand to see if the user
%has anyhting. If the user does have something, my function rankInWords
%sets the multiplyer and uses the multiplyer to calculate the users new
%cash. If the user has nothing, their bet is subtracted from their cash

     handRank = calchand(hand);
     if handRank == 0
         fprintf('You have nothing! you lose \n')
         userCash = userCash - bet;
     else 
        [rankWords, multiplyer] = rankInWords(handRank);
        fprintf('%s \n',rankWords)
        winnings = bet*multiplyer;
        userCash = userCash - bet + winnings;
     
     end
     
     %% this final section ask the user if they want to play again. first it
     %makes sure the user has enough money. if they have the money and say
     %'y', than the while loop that was started at the beginning of the
     %script will kick in and run through most of the script again. if the
     %user says 'n' the script will exit the while loop and the game will
     %be over
     
playAgain = input('Play Again? (Y/N): ','s');

%the users input will be validated with a while loop that will execute when
%the users input is niether 'y' or 'n'

while ~(strcmpi(playAgain,'y')) && ~(strcmpi(playAgain,'n'))
    fprintf('Invalid input! please input y or n')
    playAgain = input('Play Again? (Y/N): ','s');
end


%finally the user's cash is printed and if the user is out of cash we must
%end the game

fprintf('You have $%d \n',userCash)
if userCash == 0
    playAgain = 'n';
    fprintf('You are out of money!\n')
end
end

%below is the local function that turns the users hand rank into words and
%sets the multiplyer of the winnings based on the hand rank

function [rankWords, multiplyer] = rankInWords(handRank)
switch handRank
    case 0
        rankWords = 'Nothing! Jacks or higher to win!';
        multiplyer = 0;
    case 1 
        rankWords = 'Pair! You win 1x your bet!';
        multiplyer = 1;
    case 2
        rankWords = 'Two Pairs! You win 2x your bet!';
        multiplyer = 2;
    case 3 
        rankWords = 'Three of a Kind! You win 3x your bet!';
        multiplyer = 3;
    case 4 
        rankWords = 'Straight! You win 5x your bet!';
        multiplyer = 5;
    case 5
        rankWords = 'Flush! You Win 7x your bet';
        multiplyer = 7;
    case 6 
        rankWords = 'Full House! you win 8x your bet!';
        multiplyer = 8;
    case 7
        rankWords = 'Four of a Kind! You win 10x your bet!';
        multiplyer = 10;
    case 8
        rankWords = 'Straight Flush! You win 15x your bet!';
        multiplyer = 15;
    case 9 
        rankWords = 'Royal Flush! You win 20x your bet!';
        multiplyer = 20;
    case 10
        rankWords = 'Five of a Kind! You win 35x your bet';
        multiplyer = 35;
end
end



