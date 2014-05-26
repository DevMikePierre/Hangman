//
//  FlipsideViewController.m
//  Hangman
//
//  Created by Michael Woo on 4/12/14.
//  Copyright (c) 2014 Michael Woo. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@property (weak, nonatomic) IBOutlet UILabel *wordLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *livesLabel;

@end

@implementation FlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    int word = [[NSUserDefaults standardUserDefaults] integerForKey:@"wordlength"];
    self.wordLengthLabel.text = [NSString stringWithFormat:@"%d", word];
    self.wordLengthSlider.value = word;
    int lives = [[NSUserDefaults standardUserDefaults] integerForKey:@"lives"];
    self.livesLabel.text = [NSString stringWithFormat:@"%d", lives];
    self.livesSlider.value = lives;


    NSLog(@"lives: %d, wordLength: %d",word, lives);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

    // Synch data word length
- (IBAction)wordLengthChange:(id)sender {
    int word =(int)self.wordLengthSlider.value;
    [[NSUserDefaults standardUserDefaults] setInteger:word forKey:@"wordlength"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.wordLengthLabel.text = [NSString stringWithFormat:@"%d", word];
    
}
    // Synch lives
- (IBAction)livesChange:(id)sender {
    int lives = (int)self.livesSlider.value;
    [[NSUserDefaults standardUserDefaults] setInteger:lives forKey:@"lives"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.livesLabel.text = [NSString stringWithFormat:@"%d", lives];
    
}

@end
