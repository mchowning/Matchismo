//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Detroit Labs on 3/7/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        for (NSUInteger rank = 1; rank < [PlayingCard maxRank]; rank++) {
            for (NSString *suit in [PlayingCard validSuits]) {
                PlayingCard *card = [[PlayingCard alloc] init];
                [card setRank:rank];
                [card setSuit:suit];
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
