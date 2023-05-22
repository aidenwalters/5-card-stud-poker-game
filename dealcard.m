function [topCard, restDeck] = dealcard(decks)
%this function will take in a card structure of deck(s) and it will give
%you two outputs: the top card (a single structure), and the rest of the deck 
%(a structure array with one less structure than the input). 
%
%The input must be
%a structure array with at least 10 cards, and the structure array must
%have the fields suit, value, and score. 


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

%the following code makes the first output the top card of the deck
%and makes the second output the rest of the deck

topCard = decks(1);
restDeck = decks(2:end);
end
