//
//  Deck.m
//  Matchismo
//
//  Created by Detroit Labs on 3/5/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
        
    }
}

- (void)addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {
    int numberOfCards = [self.cards count];
    if (numberOfCards == 0) return nil;
    unsigned index = arc4random_uniform(numberOfCards);
    Card *randomCard = self.cards[index];
    [self.cards removeObjectAtIndex:index];
    return randomCard;
}

@end
