//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Detroit Labs on 3/4/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property(nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) NSInteger numberOfCardsToChoose;
@property (nonatomic, retain) IBOutlet UISwitch * button;
@property (weak, nonatomic) IBOutlet UILabel *textField;
@end

@implementation CardGameViewController

static const int DEFAULT_NUMBER_OF_CARDS_TO_CHOOSE = 2;

- (int)numberOfCardsToChoose {
    if (!_numberOfCardsToChoose) {
        _numberOfCardsToChoose = DEFAULT_NUMBER_OF_CARDS_TO_CHOOSE;
    }
    return _numberOfCardsToChoose;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    _game.numberOfCardsToChoose = self.numberOfCardsToChoose;
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchNumCardSwitcher:(UISwitch *)sender {
    int numCards = ([sender isOn]) ? 3 : 2;
    self.numberOfCardsToChoose = numCards;
    [self resetBoard];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.button.enabled = NO;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.textField.text = [self.game getDescriptionOfLastMove];
    [self updateUI];
}


- (IBAction)touchRedealButton {
    [self resetBoard];
}

- (void)resetBoard {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
    self.button.enabled = YES;
    self.textField.text = [NSString stringWithFormat:@"New %d-card matching game started!", self.numberOfCardsToChoose];
}

- (void)updateUI {
    for (UIButton *button in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:cardIndex];
        [button setTitle:[self getCardStringFrom:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self getCardImageFor:card] forState:UIControlStateNormal];
        button.enabled = !card.matched;
        [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.game.score]];
    }
}

- (NSString *)getCardStringFrom:(Card *) card {
    NSString *result;
    if (card.isChosen || card.isMatch) result = card.contents;
    return result;
}

- (UIImage *)getCardImageFor:(Card *)card {
    UIImage *result;
    if (card.isChosen || card.isMatch) {
        result = [UIImage imageNamed:@"cardfront"];
    } else {
        result = [UIImage imageNamed:@"cardback"];
    }
    return result;
}

@end
