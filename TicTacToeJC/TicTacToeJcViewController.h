//
//  TicTacToeJcViewController.h
//  TicTacToeJC
//
//  Created by Jamie Conroy on 27/02/2014.
//  Copyright (c) 2014 Jamie Conroy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "ComputerPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface TicTacToeJcViewController : UIViewController {


//IBOutlet NSMatrix *gameBoard;


IBOutlet UIButton *gameBoardButton1;
IBOutlet UIButton *gameBoardButton2;
IBOutlet UIButton *gameBoardButton3;
IBOutlet UIButton *gameBoardButton4;
IBOutlet UIButton *gameBoardButton5;
IBOutlet UIButton *gameBoardButton6;
IBOutlet UIButton *gameBoardButton7;
IBOutlet UIButton *gameBoardButton8;
IBOutlet UIButton *gameBoardButton9;

IBOutlet UITextField *playerMessage;
IBOutlet UITextField *playerMessageWinner;
IBOutlet UIButton *playAGame;
IBOutlet UISwitch *computerPlayerToggle;
IBOutlet UIActivityIndicatorView *computerThinking;

BOOL computerPlayer;
Board *board;
Player *p1;
Player *p2;
Player *currentPlayer;

    
    AVAudioPlayer *_backgroundMusicPlayer;
    
int move;
BOOL winner;
}

- (IBAction)buttonTapped:(UIButton *)sender;
- (IBAction) piecePlayed:(id)sender;
- (IBAction) drawBoard: (id)sender;
- (IBAction) setUpGame:(id)sender;
- (void) gameResetOptions;
- (void) playComputerMove;
- (void) displayMessage:(NSString*)message;

@property (assign) IBOutlet UIWindow *window;

@end
