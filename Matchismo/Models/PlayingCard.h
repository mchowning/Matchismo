//
//  PlayingCard.h
//  Matchismo
//
//  Created by Detroit Labs on 3/5/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

- (NSString *)contents;
+ (NSArray *)validSuits;
+ (NSArray *)rankStrings;
+ (NSUInteger)maxRank;

@end
