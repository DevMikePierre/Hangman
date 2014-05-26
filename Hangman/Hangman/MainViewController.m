//
//  MainViewController.m
//  Hangman
//
//  Created by Michael Woo on 4/12/14.
//  Copyright (c) 2014 Michael Woo. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (assign, nonatomic) int totalLives;
@property (assign, nonatomic) int livesRemaining;
@property (assign, nonatomic) int wordLength;
@property (strong, nonatomic) NSString *wordToGuess;
@property (weak, nonatomic) IBOutlet UILabel *alphaLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *livesRemainLabel;
@property (weak, nonatomic) IBOutlet UITextField *letterTextField;
@property (strong, nonatomic) Game *hangman;

//@property(strong, nonatomic) NSMutableArray *totalWords;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _hangman = [[Game alloc]init];

    [self setup];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (BOOL) prefersStatusBarHidden {
    
    return YES;
}


#pragma mark - Setup
    // Setup the UI game play
- (void) setup{
    
    // Init value from setting
    [_hangman startGame];
    self.wordLength = [[NSUserDefaults standardUserDefaults] integerForKey:@"wordlength"];
    self.totalLives = [[NSUserDefaults standardUserDefaults] integerForKey:@"lives"];
    
    // Loads the plist
    NSMutableArray *list = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    
    // Holds the words with the correct length
    NSMutableArray *listCorrectLength = [[NSMutableArray alloc] init];
    
    // Loop and store the word of the correct size in an array
    for (NSString *word in list){
        int wordSize =(int) [word length];
        if (wordSize == self.wordLength) {
            [listCorrectLength addObject:word];
        }
    }
    // Pick random word
    NSUInteger random = arc4random() % [listCorrectLength count];
    self.wordToGuess = [listCorrectLength objectAtIndex:random];

    NSLog(@"%@", self.wordToGuess);
    
    self.alphaLabel.text = @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z";
    
    NSMutableString *empty = [[NSMutableString alloc] init];
    for (unsigned int i = 0 ; i < self.wordLength; i++) {
        [empty appendString:@"_ "];
    }
    self.guessWordLabel.text = empty;
    self.livesRemainLabel.text = [NSString stringWithFormat:@"%d",[_hangman lives]];
}

#pragma mark - Gameplay

- (void) play{

    NSString *letter = self.letterTextField.text;
    
    NSCharacterSet *validInput = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    if([letter rangeOfCharacterFromSet:validInput].location == NSNotFound || [letter length] != 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Enter one letter or no numeric"
                                                       delegate:self
                                              cancelButtonTitle:@"Try again"
                                              otherButtonTitles:nil];
        [alert setTag:0];
        [alert show];
        return;
    }
    
    // Start hangman
    self.guessWordLabel.text = [_hangman gamePlayLetter:letter withWordToGuess:self.wordToGuess andWordWithBlank:self.guessWordLabel.text];
    NSLog(@"LIVES: %d",[_hangman lives]);
    
    // Updates the list of letter left
    NSString *updatedLetterList = [self.alphaLabel.text stringByReplacingOccurrencesOfString:[self.letterTextField.text uppercaseString] withString:@" "];
    self.alphaLabel.text = updatedLetterList;
    self.livesRemainLabel.text = [NSString stringWithFormat:@"%d", [_hangman lives]];
    
    [self.letterTextField resignFirstResponder];
    self.letterTextField.text =@"";
    
    
    // Check if game is over
    if ([_hangman isGameOver]) {
        NSString *message = @"The word was: ";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message:[message stringByAppendingString:self.wordToGuess ]
                                                       delegate:self
                                              cancelButtonTitle:@"Restart"
                                              otherButtonTitles:nil];
        [alert setTag:1];
        [alert show];
        return;

    }
    if ([_hangman didWinGame:self.wordToGuess]) {
        NSString *message = @"The word was: ";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Won"
                                                        message:[message stringByAppendingString:self.wordToGuess]
                                                       delegate:self
                                              cancelButtonTitle:@"Restart"
                                              otherButtonTitles:nil];
        [alert setTag:1];
        [alert show];
        return;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Restart game
    if (alertView.tag == 1) {
        [self setup];
    }
    
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.letterTextField){
        [self play];
    }
    return YES;
}
- (IBAction)restart:(id)sender {
    [self setup];
}


@end



























