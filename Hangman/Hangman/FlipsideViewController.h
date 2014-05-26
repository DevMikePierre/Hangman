//
//  FlipsideViewController.h
//  Hangman
//
//  Created by Michael Woo on 4/12/14.
//  Copyright (c) 2014 Michael Woo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UISlider *livesSlider;

- (IBAction)done:(id)sender;

@end
