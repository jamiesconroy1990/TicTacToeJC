//
//  TicTacToeJcViewController.m
//  TicTacToeJC
//
//  Created by Jamie Conroy on 27/02/2014.
//  Copyright (c) 2014 Jamie Conroy. All rights reserved.
//

#import "TicTacToeJcViewController.h"

@implementation TicTacToeJcViewController





/*
 Initialises the various objects we will use
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	NSLog(@"Init method");
	computerPlayer = NO;
	
	p1 = [[Player alloc] initWithName:@"Player 1"
								piece:@"X"];
	p2 = [[Player alloc] initWithName:@"Player 2"
								piece:@"O"];
	
	move = 0;
    
    // Create audio player with background music
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"mk" ofType:@"caf"];
	NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
	NSError *error;
    
	_backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    [_backgroundMusicPlayer prepareToPlay];
    [_backgroundMusicPlayer play];
    [_backgroundMusicPlayer setNumberOfLoops:-1];	// Negative number means loop forever
	
} // init

- (IBAction)buttonTapped:(UIButton *)sender
{
    NSLog(@"Button Tapped!");
}

/*
 This method will run when the application starts up without problems
 */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self gameResetOptions];
} // applicationDidFinishLaunching

/*
 This method will run when the program ends
 */
- (void) dealloc
{
	[p1 release];
	[p2 release];
	[board release];
	[super dealloc];
} // dealloc

/*
 Enables playAGame and computerPlayer checkbox. Disables the gameBoard
 */
- (void) gameResetOptions
{
	NSLog(@"Allowing user to reset game ... enabling options again.");
	
    [gameBoardButton1 setEnabled:NO];
	[gameBoardButton2 setEnabled:NO];
	[gameBoardButton3 setEnabled:NO];
	[gameBoardButton4 setEnabled:NO];
	[gameBoardButton5 setEnabled:NO];
	[gameBoardButton6 setEnabled:NO];
	[gameBoardButton7 setEnabled:NO];
	[gameBoardButton8 setEnabled:NO];
	[gameBoardButton9 setEnabled:NO];
    
    [playAGame setEnabled:YES];
	[computerPlayerToggle setEnabled:YES];
	
	NSString *s = [NSString stringWithFormat:@"Would you like to play a game?"];
	[self displayMessage:s];
} // gameResetOptions

/*
 Sets up a new game, based on options (Computer PLayer or Human Player)
 */
- (IBAction) setUpGame:(id)sender
{
	NSLog(@"Setting up new game");
	move = 0;
	currentPlayer = p1;
	winner = NO;
	
	board = [[Board alloc] init];
	computerPlayer = computerPlayerToggle.on;
	
	if(computerPlayer == YES){
		[p2 release];
		p2 = [[ComputerPlayer alloc] init];
	}
	else{
		[p2 release];
		p2 = [[Player alloc] initWithName:@"Player 2"
									piece:@"O"];
	}
	
	[playerMessageWinner setHidden:YES];
    
    [gameBoardButton1 setEnabled:YES];
	[gameBoardButton2 setEnabled:YES];
	[gameBoardButton3 setEnabled:YES];
	[gameBoardButton4 setEnabled:YES];
	[gameBoardButton5 setEnabled:YES];
	[gameBoardButton6 setEnabled:YES];
	[gameBoardButton7 setEnabled:YES];
	[gameBoardButton8 setEnabled:YES];
	[gameBoardButton9 setEnabled:YES];
    
	NSString *s = [NSString stringWithFormat:@"Make your move %@ ...", [currentPlayer name]];
	
	[self displayMessage:s];
    
	[self drawBoard:self];
	[playAGame setEnabled:NO];
	[computerPlayerToggle setEnabled:NO];
} // setUpGame

/*
 Displays the appropriate message for a winning game
 */
- (void) displayWinner
{
	NSString *s;
    [gameBoardButton1 setEnabled:NO];
	[gameBoardButton2 setEnabled:NO];
	[gameBoardButton3 setEnabled:NO];
	[gameBoardButton4 setEnabled:NO];
	[gameBoardButton5 setEnabled:NO];
	[gameBoardButton6 setEnabled:NO];
	[gameBoardButton7 setEnabled:NO];
	[gameBoardButton8 setEnabled:NO];
	[gameBoardButton9 setEnabled:NO];
	
	if((computerPlayer) && (currentPlayer == p2))
    {
		s = [NSString stringWithFormat:@"The Computer beat you"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Lost, back to the drawing board id."
                message:s delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        
                          }
        else
        s = [NSString stringWithFormat:@"Congratulations! %@ is the winner!", [currentPlayer name]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Won"
                        message:s delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];

    
            
            [playerMessageWinner setText:s];
	[playerMessageWinner setHidden:NO];
} //displayWinner

/*
 Displays appropriate messages for a draw game
 */
- (void) displayDraw
{
    [gameBoardButton1 setEnabled:NO];
	[gameBoardButton2 setEnabled:NO];
	[gameBoardButton3 setEnabled:NO];
	[gameBoardButton4 setEnabled:NO];
	[gameBoardButton5 setEnabled:NO];
	[gameBoardButton6 setEnabled:NO];
	[gameBoardButton7 setEnabled:NO];
	[gameBoardButton8 setEnabled:NO];
	[gameBoardButton9 setEnabled:NO];
	
	NSString *s = [NSString stringWithFormat:@"Seriously a Draw thats weak"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Man up and try again"
                    message:s delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
	[playerMessageWinner setText:s];
	[playerMessageWinner setHidden:NO];
} // displayDraw


/*
 Processes the next move. In a two human player game, this checks for a winner and (assuming there's no winner)
 alternates the currentPlayer to the next player. If playing against the computer, it gets the computer's move.
 */
- (void) nextMove
{
	if(move < 9 && !winner){
		if([board winner]){
			winner = YES;
		}
		
		else{
			[self drawBoard:self];
			
			if(currentPlayer == p1)
				currentPlayer = p2;
			else
				currentPlayer = p1;
			
			NSString *s = [NSString stringWithFormat:@"Make your move %@ ...", [currentPlayer name]];
			[self displayMessage:s];
			move++;
		}
	}
	
	// Get Computer Move
	if((computerPlayer) && (currentPlayer == p2) && (move < 9)){
		NSString *s = [NSString stringWithFormat:@"%@ is thinking ...", [currentPlayer name]];
		[self displayMessage:s];
		
		[self playComputerMove];
		
		if([board winner]){
			winner = YES;
		}
		else{
			currentPlayer = p1;
			
			s = [NSString stringWithFormat:@"Make your move %@ ...", [currentPlayer name]];
			[self displayMessage:s];
		}
        
		move++;
	}
	
	if(winner){
		[self displayWinner];
		[self gameResetOptions];
	}
	else if(move == 9 && !winner){
		[self displayDraw];
		[self gameResetOptions];
	}
} // nextMove

/*
 This method does its work with the various IB components (progressIndicator) and gets the computer's move
 */
- (void) playComputerMove
{
	NSLog(@"Processing computer move ....");
	
	[computerThinking setHidden:NO];
	[computerThinking startAnimation:self];
	
	int position = [currentPlayer getComputerMove: board];
    
	NSLog(@"%@ is placing %@ in position %d.", [currentPlayer name], [currentPlayer piece], position);
	
    [board updateBoard:[currentPlayer piece] place: position];
	
	[self drawBoard:self];
	
	[computerThinking stopAnimation:self];
	[computerThinking setHidden:YES];
	
} // playComputerMove


- (IBAction) piecePlayed:(id)sender
{
	NSLog(@"Piece played ....");
    
	//NSButtonCell *bc = (NSButtonCell *)[[sender selectedCell] retain];
    //int position = [[bc title] intValue];
	
    UIButton *b = (UIButton *) sender;
    
    int position = [b tag];
    
	[board updateBoard:[currentPlayer piece] place: position];
    
	[b setTitle: [board objectInBoardAtPosition:position]forState:UIControlStateNormal];
	[b setEnabled: NO];
	
	[self drawBoard:self];
	[self nextMove];
    
} // piecePlayed


- (void) displayMessage:(NSString*)message
{
	if(message != nil){
		[playerMessage setText:message];
		[playerMessage display];
	}
    
} //displayMessage


- (IBAction) drawBoard: (id)sender
{
	NSLog(@"Drawing the board ....");
    
    
    [gameBoardButton1 setTitle:[board objectInBoardAtPosition:1]forState:UIControlStateNormal];
    if(([[gameBoardButton1 currentTitle]isEqualToString:@"X"]) || ([[gameBoardButton1 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton1 setEnabled:NO];
    }
    
    [gameBoardButton2 setTitle:[board objectInBoardAtPosition:2]forState:UIControlStateNormal];
    if(([[gameBoardButton2 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton2 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton2 setEnabled:NO];
    }
    
    [gameBoardButton3 setTitle:[board objectInBoardAtPosition:3]forState:UIControlStateNormal];
    if(([[gameBoardButton3 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton3 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton3 setEnabled:NO];
    }
    
    [gameBoardButton4 setTitle:[board objectInBoardAtPosition:4]forState:UIControlStateNormal];
    if(([[gameBoardButton4 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton4 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton4 setEnabled:NO];
    }
    
    [gameBoardButton5 setTitle:[board objectInBoardAtPosition:5]forState:UIControlStateNormal];
    if(([[gameBoardButton5 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton5 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton5 setEnabled:NO];
    }
    
    [gameBoardButton6 setTitle:[board objectInBoardAtPosition:6]forState:UIControlStateNormal];
    if(([[gameBoardButton6 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton6 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton6 setEnabled:NO];
    }
    
    [gameBoardButton7 setTitle:[board objectInBoardAtPosition:7]forState:UIControlStateNormal];
    if(([[gameBoardButton7 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton7 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton7 setEnabled:NO];
    }
    
    [gameBoardButton8 setTitle:[board objectInBoardAtPosition:8]forState:UIControlStateNormal];
    if(([[gameBoardButton8 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton8 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton8 setEnabled:NO];
    }
    
    [gameBoardButton9 setTitle:[board objectInBoardAtPosition:9]forState:UIControlStateNormal];
    if(([[gameBoardButton9 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton9 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton9 setEnabled:NO];
    }
    
    
}

@end


