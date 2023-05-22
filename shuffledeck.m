function shuffeledDecks = shuffledeck(decks)
%this function takes in a card structure array of at least 10 cards, and
%randomly swaps the cards a large amount of times in order to shuffle the
%deck of cards. 
%
%The input must be a structure array with the fields suit,
%value, and score. The output will be a structure array the same size as
%the input, but the output also swaps cards in the structure array a large
%amount of times in order to randomize/shuffle the structure array

%the first if statment makes sure theres only one input using nargin
if nargin ~= 1      
    error('incorrect number of inputs')
end

%this next if statement checks to make sure the card structure that is
%being put in has all the proper fields by using any() to see if any of the
%fields are missing

if any(isfield(decks, {'suit', 'value', 'score'}) == 0)
    error('must be a card structure with the fields suit, score and value')
end

%the final validation is to make sure there are at least 10 cards in the
%card structure

if numel(decks) < 10
    error('must be a card structure with at least 10 cards')
end

%the following for loop swaps cards 10 times as many cards there are in the
%card structure

for i = 1:10*(numel(decks))

%first, two random integers are chosen that correlate to two random cards
%in the deck
    
a = randi([1,numel(decks)],1,1);
b = randi([1,numel(decks)],1,1);

%those two random integers are then used to assign the corresponding cards
%to variables

card1 = decks(a);
card2 = decks(b);

%those cards will then be swapped by swapping thier variables, and then by
%assigning those swapped variables to their orignial indexes

temp = card1;
card1 = card2;
card2 = temp;

decks(a) = card1;
decks(b) = card2;

end

%the output is a shuffeled deck

shuffeledDecks = decks;

end



