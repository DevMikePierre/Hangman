//
//  Game.h
//  Hangman
//
//  Created by Michael Woo on 4/12/14.
//  Copyright (c) 2014 Michael Woo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

-(NSString*)gamePlayLetter: (NSString*)letter withWordToGuess:(NSString*)wordToGuess andWordWithBlank:(NSString*)wordWithBlank;
-(void)startGame;
-(BOOL)isGameOver;
-(BOOL) didWinGame:(NSString*) word;

@property (assign,nonatomic, readonly) int lives;

@end
