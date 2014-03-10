//
//  DeckTests.m
//  Matchismo
//
//  Created by Detroit Labs on 3/5/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Card.h"
#import "Deck.h"

@interface DeckTests : XCTestCase

@end

@implementation DeckTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testAddAndDrawSingleCard {
    Card *card1 = [[Card alloc] init];
    card1.contents = @"Card #1";
    
    Deck *aDeck = [[Deck alloc] init];
    [aDeck addCard:card1];
    
    Card *topCard = [aDeck drawRandomCard];
    XCTAssertEqual(topCard, card1);
}

- (void)testAddAndDrawTwoCards {
    Card *card1 = [[Card alloc] init];
    card1.contents = @"Card #1";
    Card *card2 = [[Card alloc] init];
    card2.contents = @"Card #2";
    
    Deck *aDeck = [[Deck alloc] init];
    [aDeck addCard:card1];
    [aDeck addCard:card2];
    
    Card *firstDrawnCard = [aDeck drawRandomCard];
    if (firstDrawnCard == card1) {
        XCTAssertEqual(card2, [aDeck drawRandomCard]);
    } else {
        XCTAssertEqual(card1, [aDeck drawRandomCard]);
    }
}
@end
