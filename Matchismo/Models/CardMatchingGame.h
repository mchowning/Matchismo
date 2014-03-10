//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Detroit Labs on 3/7/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSString *)getDescriptionOfLastMove;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger numberOfCardsToChoose;

@end
