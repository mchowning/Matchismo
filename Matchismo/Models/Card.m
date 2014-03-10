//
//  Card.m
//  Matchismo
//
//  Created by Detroit Labs on 3/5/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards {
    int score = 0;
    for (Card *aCard in otherCards) {
        if ([aCard.contents isEqualToString:self.contents]) {
            score++;
        }
    }
    return score;
}

- (NSString *)contents {
    return nil;
}

@end
