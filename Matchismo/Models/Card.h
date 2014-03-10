//
//  Card.h/Users/DetroitLabsUser/developer/Matchismo/Matchismo/Models/Card.m
//  Matchismo
//
//  Created by Detroit Labs on 3/5/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatch) BOOL matched;

- (int) match:(NSArray *)otherCards;
- (NSString *)contents;

@end
