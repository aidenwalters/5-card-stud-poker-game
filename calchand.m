function handRank = calchand(hand)
%this function runs through a series of if statements in order to determine
%the rank of the hand. there are 11 hand ranks:
%
%10: 5 of a kind, which means all 5 cards have the same value. 
%9: roayl flush, whch means a flush
%where all the cards have the same suit, and a straight that starts at 10
%and ends with ace. a straight  means the value of the 5 cards are all
%sequential. 
%8: straight flush, which means a straight and flush at the same time, like
%a royal flush, but the straight can start at any card
%7: four of a kind, which means four of the cards have the same value
%6: full house, which means three of the cards have the same value, and two
%of the cards have the same value
%5: flush, which means the 5 cards all have the same suit
%4: straight, which means the 5 cards all have sequential values, no
%repeats
%3: three of a kind, which means 3 of the cards share the same value
%2: two pairs, which means 2 cards share the same value, and 2 different
%cards share a different value
%1: pair, which means two of the cards share the same value
%0: nothing, which means none of the above
%
%the input to this function msut be a 5 card structure array with the
%fields, suit, value and score. and the output of this function is a single
%numeric value relating to the hand ranks described above

%the first if statment makes sure theres only one input using nargin
if nargin ~= 1      
    error('incorrect number of inputs')
end

%this next if statement checks to make sure the card structure that is
%being put in has all the proper fields by using any() to see if any of the
%fields are missing

if any(isfield(hand, {'suit', 'value', 'score'}) == 0)
    error('must be a card structure with the fields suit, score and value')
end

if numel(hand) ~= 5     %this if statement checks to make sure exactly 5 cards were inputed
    error('card structure must be a 5 card hand')
end
%in order to calculate the score of most hands(excluding flushes), I just need the value from
%each card in the hand. therefore, I will take the hand and turn it into a
%sorted matrix of just the value of each card

scoreHandStruct = rmfield(hand, 'suit');
scoreHandStruct2 = rmfield(scoreHandStruct, 'value');
scoreHandArr = cell2mat(struct2cell(scoreHandStruct2));

sortedHand = sort(scoreHandArr);

%this first if statement checks for a 5 of a kind and returns a hand rank of 10

if sortedHand(:,:,1) == sortedHand(:,:,5)
    handRank = 10;

%the following elseif statement checks for a royal flush by using my local 
%functions flushcalc and strightcalc and by checking if the first card of the straight is a 10


elseif (flushcalc(hand) && straightcalc(sortedHand) == 1) && (sortedHand(:,:,1) == 10)
    handRank = 9;

% the following elseif statement checks for a straight flush by using my 
%local function flushcalc and strightcalc


elseif flushcalc(hand) && straightcalc(sortedHand) == 1
    handRank = 8;

% the following elseif checks for a four of a kind by compairing the first
% and fourth card, or comparing the second and fifth card of sorted hand
    
elseif sortedHand(:,:,1) == sortedHand(:,:,4) || sortedHand(:,:,2) == sortedHand(:,:,5)
    handRank = 7;
    
%the following elseif checks for a full house by comparing the first and
%third, and the fourth and fifth card of sorted hand, or by comparing the first and second
%and the third and the fifth card of sorted hand
    
elseif sortedHand(:,:,1) == sortedHand(:,:,3) && sortedHand(:,:,4) == sortedHand(:,:,5)...
        || sortedHand(:,:,1) == sortedHand(:,:,2) && sortedHand(:,:,3) == sortedHand(:,:,5)
    handRank = 6;
    
% this elseif statement checks for a flush using flushcalc function

elseif flushcalc(hand) == 1
    handRank = 5;

% this elseif statement checks for a straight using straightcalc function

elseif straightcalc(sortedHand) == 1
    handRank = 4;
    
%the following elseif checks for a three of a kind by comparing the first
%and third, second and fourth, and third and fifth card of sorted hand
    
elseif sortedHand(:,:,1) == sortedHand(:,:,3) || sortedHand(:,:,2) == sortedHand(:,:,4)...
        || sortedHand(:,:,3) == sortedHand(:,:,5)
    handRank = 3;
    
%the next elseif checks for a two pair by checking for multiple pairs in
%sorted hand

elseif (sortedHand(:,:,1) == sortedHand(:,:,2) && sortedHand(:,:,3) == sortedHand(:,:,4))...
        || (sortedHand(:,:,2) == sortedHand(:,:,3) && sortedHand(:,:,4) == sortedHand(:,:,5))...
        || (sortedHand(:,:,1) == sortedHand(:,:,2) && sortedHand(:,:,4) == sortedHand(:,:,5))
    handRank = 2;
    
%the following elseif checks for a single pair thats jacks or higher

elseif (sortedHand(:,:,1) == sortedHand(:,:,2) && sortedHand(1) >= 1)...
        || (sortedHand(:,:,2) == sortedHand(:,:,3) && sortedHand(2) >= 1)...
        || (sortedHand(:,:,3) == sortedHand(:,:,4) && sortedHand(3) >= 1)...
        || (sortedHand(:,:,4) == sortedHand(:,:,5) && sortedHand(4) >= 1)
    handRank = 1;
    
else
    handRank = 0;
end
    
%the following is my local function that checks for a flush by comparing the suit of all 5 cards
    
function flush = flushcalc(hand)
flush = (hand(1).suit == hand(2).suit) && (hand(2).suit == hand(3).suit) &&...
    (hand(3).suit == hand(4).suit) && (hand(4).suit == hand(5).suit);
end

%The following is my local function that checks for a straight by taking the sorted hand and checking if the values are sequential

function straight = straightcalc(sortedHand)

straight = (sortedHand(:,:,1) + 4) == (sortedHand(:,:,2) + 3) && (sortedHand(:,:,2) + 3) == (sortedHand(:,:,3) + 2)...
        && (sortedHand(:,:,3) + 2) == (sortedHand(:,:,4) + 1) && (sortedHand(:,:,4) + 1) == sortedHand(:,:,5);
end
end

        