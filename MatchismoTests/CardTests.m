//
//  CardTests.m
//  Matchismo
//
//  Created by Detroit Labs on 3/5/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Card.h"

@interface CardTests : XCTestCase

@end

@implementation CardTests

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

- (void)isMatchEmptyTest
{
    Card *aCard = [[Card alloc] init];
    NSArray *otherCards = nil;
    XCTAssertEqual(0, [aCard match:otherCards]);
}

- (void)testIsMatchSame {
    Card *aCard1 = [[Card alloc] init];
    NSString *contentsName = @"Card Name";
    aCard1.contents = contentsName;
    Card *aCard2 = [[Card alloc] init];
    aCard2.contents = contentsName;
    NSArray *cardArray = @[aCard2];
    XCTAssertEqual(1, [aCard1 match:cardArray]);
}

- (void)testIsNotSame {
    Card *aCard1 = [[Card alloc] init];
    aCard1.contents = [NSString stringWithFormat:@"Card Name"];
    Card *aCard2 = [[Card alloc] init];
    aCard2.contents = @"Other Card Name"; //contentsName;
    NSArray *cardArray = @[aCard2];
    XCTAssertEqual(0, [aCard1 match:cardArray]);
}

- (void)testMultipleMatches {
    NSString *baseContents = [NSString stringWithFormat:@"Base Card"];
    NSString *differentContents = [NSString stringWithFormat:@"NOT Base Card"];
    Card *baseCard = [[Card alloc] init];
    baseCard.contents = baseContents;
    Card *sameCard1 = [[Card alloc] init];
    sameCard1.contents = baseContents;
    Card *sameCard2 = [[Card alloc] init];
    sameCard2.contents = baseContents;
    Card *sameCard3 = [[Card alloc] init];
    sameCard3.contents = baseContents;
    Card *differentCard1 = [[Card alloc] init];
    differentCard1.contents = differentContents;
    Card *differentCard2 = [[Card alloc] init];
    NSArray *cards = @[sameCard1, sameCard2, sameCard3, differentCard1, differentCard2];
//    NSArray *cards = [NSArray arrayWithObjects:sameCard1, sameCard2, sameCard3, differentCard1, differentCard2, nil];
    XCTAssertEqual(3, [baseCard match:cards]);
}

@end