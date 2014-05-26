//
//  Game.m
//  Hangman
//
//  Created by Michael Woo on 4/12/14.
//  Copyright (c) 2014 Michael Woo. All rights reserved.
//

#import "Game.h"

@interface Game()

@property (assign,nonatomic, readwrite) int lives;
@property (assign,nonatomic) int winCount;



@end

@implementation Game

-(void)startGame{
    
    _lives = [[NSUserDefaults standardUserDefaults] integerForKey:@"lives"];
    _winCount = 0;

}

-(NSString*)gamePlayLetter: (NSString*)letter withWordToGuess:(NSString*)wordToGuess andWordWithBlank:(NSString*)wordWithBlank{
    

    BOOL didLoseLife = TRUE;
    NSString *newWord = [[NSMutableString alloc]init];
    for (unsigned int i = 0; i < [wordToGuess length]; i ++) {
        char letterChar = [[letter uppercaseString] characterAtIndex:0];
        char currentLetterChar = [[wordToGuess uppercaseString] characterAtIndex:i];

        if (letterChar == currentLetterChar) {
            // i*2 to account for the blank space
            NSRange range = NSMakeRange(i*2, 2);
            NSString *changeLetter = [[letter uppercaseString] stringByAppendingString:@" "];
            newWord = [wordWithBlank stringByReplacingCharactersInRange:range withString:changeLetter];
            didLoseLife = FALSE;
            _winCount++;
            wordWithBlank = newWord;

            
        }

        
        
    }
    if (didLoseLife) {
        _lives--;
        return wordWithBlank;
    }
    return newWord;
}

-(BOOL) isGameOver{
    if (_lives == 0) {
        return TRUE;
    }
    else{
        return FALSE;
    }
    
    
}
-(BOOL) didWinGame:(NSString*) word{
    if( _winCount == [word length] ){
        return TRUE;
    }
    else {
        return FALSE;
    }

}

@end
