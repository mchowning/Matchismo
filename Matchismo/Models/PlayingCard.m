//
//  PlayingCard.m
//  Matchismo
//
//  Created by Detroit Labs on 3/5/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♣︎", @"♠︎", @"♦︎", @"♥︎"];
}

+ (NSArray *)rankStrings {
     return @[ @"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K" ];
}

+ (NSUInteger)maxRank {
    return [[PlayingCard rankStrings] count] - 1;
    // -1 because 0 is a '?'
}
- (NSString *) contents {
    NSString *rankString = [PlayingCard rankStrings][self.rank];
    NSString *result = [NSString stringWithFormat:@"%@%@", rankString, self.suit];
    return result;
}

- (void)setSuit:(NSString *)suit {
    if ([ [PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

-(int)match:(NSArray *)otherCards {
    int score = 0;
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = otherCards[0];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if (otherCard.suit == self.suit) {
            score = 1;
        }
    }
    return score;
}

@end
