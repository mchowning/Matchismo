//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Detroit Labs on 3/7/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic) NSMutableArray *cards;  // of Card
@property (nonatomic) Card *lastChosenCard;
@property (nonatomic) NSInteger lastScore;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *randomCard = [deck drawRandomCard];
            if (randomCard) {
                [self.cards addObject:randomCard];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    int numCards = [self.cards count];
    if (index < numCards) {
        return self.cards[index];
    } else {
        return nil;
    }
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 6;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *thisCard = self.cards[index];
    self.lastChosenCard = thisCard;
    thisCard.chosen = YES;
    NSArray *chosenCards = [self chosenCards];
    
    // If completed picking set of cards, check set for matches
    if ([chosenCards count] == self.numberOfCardsToChoose) {
        NSInteger roundScore = 0;
        NSArray *matches = [self getMatches];
        if ([matches count] == 0) {
            roundScore = -(MISMATCH_PENALTY);
        } else {
            roundScore = [self getScoreForMatches:matches];
            for (Card *aChosenCard in chosenCards) {
                aChosenCard.matched = YES;
            }
        }
        self.lastScore = roundScore;
        self.score += roundScore;
    } else if ([chosenCards count] > self.numberOfCardsToChoose) {
        for (Card *aCard in chosenCards) {
            if (aCard != thisCard) aCard.chosen = NO;
        }
    }
}

- (NSInteger)getScoreForMatches:(NSArray *)matches {
    int score = 0;
    for (NSArray *aMatch in matches) {
        Card *firstCard = [aMatch firstObject];
        Card *secondCard = [aMatch lastObject];
        score += [firstCard match:@[secondCard]] * MATCH_BONUS;
    }
    return score;
}

- (NSArray *)chosenCards {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Card *aCard in self.cards) {
        if (aCard.isChosen) [result addObject:aCard];
    }
    return result;
}

/* TODO I don't want a mismatch penalty for every mismatch, i.e., when
 there are more than 2 cards */
- (NSInteger)scoreForMatchOfFirstCard:(Card *)firstCard
                        secondCard:(Card *)secondCard {
    int cardScore = [firstCard match:@[secondCard]];
    if (cardScore) {
        self.score += cardScore * MATCH_BONUS;
    } else {
        self.score -= MISMATCH_PENALTY;
    }
    return cardScore;
}

- (NSString *)getDescriptionOfLastMove {
    NSMutableString *result = [NSMutableString stringWithFormat:@"You picked %@. ", self.lastChosenCard.contents];
    NSArray *chosenCards = [self chosenCards];
    if ([chosenCards count] == self.numberOfCardsToChoose) {
        NSArray *matches = [self getMatches];
        if ([matches count] == 0) {
            [result appendFormat:@"There were no matches. You lose %d points", -(self.lastScore)];
        } else {
            for (NSArray *aMatch in matches) {
                Card *firstCard = [aMatch firstObject];
                Card *secondCard = [aMatch lastObject];
                [result appendFormat:@"You matched %@ and %@! You get %d points!", firstCard.contents, secondCard.contents, self.lastScore];
            }
        }
    }
    return result;
}

- (NSArray *)getMatches {
    NSMutableArray *matches = [[NSMutableArray alloc] init];
    NSArray *chosenCards = [self chosenCards];
    for (int i = 0; i < [chosenCards count] - 1; i++) {
        Card *thisCard = chosenCards[i];
        for (int j = i + 1; j < [chosenCards count]; j++) {
            Card *otherCard = chosenCards[j];
            if ([thisCard match:@[otherCard]]) {
                NSArray *newMatch = @[thisCard, otherCard];
                [matches addObject:newMatch];
            }
        }
    }
    return matches;
}

@end
