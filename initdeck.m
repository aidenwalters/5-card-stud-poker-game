function cardStructFinal = initdeck(numberOfDecks)
%this function initializes a structure of deck(s) of cards
%by assigning suits, values, and scores to a field to each card of a 52 card
%deck. Then based on the number of decks asked for in the input, the deck
%will be replicated that many times. 
%
%This funtion requires a positive
%scalar whole number input such as 1, 2, or 3, and will reject any other
%inputs like -9, 0, or a vector [1:5]. This function will output a
%structure array 1x(52*numberOfDecks) and each structure in the array have
%3 fields


if numberOfDecks <= 0       %this first if statment makes sure the input is positive checking if input is >=0
    error('Invalid input, input must be positive, scalar whole number')
end

if isscalar(numberOfDecks) == 0     %the second if statement checks if input is scalar using isscalar()
    error('Invalid input, input must be positive, scalar whole number')
end

if mod(numberOfDecks,1) ~= 0        %this if statement uses the mod function to check if input is a whole number
    error('Invalid input, input must be positive, scalar whole number')
end

if nargin ~= 1      %this if statement makes sure theres only one argument going into the function
    error('Invalid input, must be one input')
end

%this next for loop iterates 52 times to create a 52 card structure array
%with the proper fields

for index1 = 1:52
    cardStruct(index1) = struct('suit',[],'value',[],'score',[]);
end

%the next for loop iterates throught the first 13 cards in the structure
%which will be hearts, and then assigns a value and score based on the for
%loop's index. however, the value is only temporary and will be changed
%later

for index2 = 1:13
    cardStruct(index2).suit = "Hearts";
    cardStruct(index2).value = string(index2 + 1);
    cardStruct(index2).score = index2 + 1;
end

%this for loop does the same as the last, but instead for clubs

for index3 = 14:26
    cardStruct(index3).suit = "Clubs";
    cardStruct(index3).value = string(index3 - 12);
    cardStruct(index3).score = index3 - 12;
end

%this for loop also does the same for diamonds

for index4 = 27:39
    cardStruct(index4).suit = "Diamonds";
    cardStruct(index4).value = string(index4 - 25);
    cardStruct(index4).score = index4 - 25;
end

%this is the final for loop for spades

for index5 = 40:52
    cardStruct(index5).suit = "Spades";
    cardStruct(index5).value = string(index5 - 38);
    cardStruct(index5).score = index5 - 38;
end
 
%this next for loop fixes the temporary value that was assigned above by
%using a switch statement to fix all the temporary values to their correct
%values

 for index6 = 1:52
     switch cardStruct(index6).value
         case "11"
             cardStruct(index6).value = "Jack";
         case "12"
             cardStruct(index6).value = "Queen";
         case "13"
             cardStruct(index6).value = "King";
         case "14"
             cardStruct(index6).value = "Ace";
     end
 end
 
 %this last function replicates the card structure for as many times as the
 %user asks
 
 cardStructFinal = repmat(cardStruct, [1,numberOfDecks]);
 
end

 