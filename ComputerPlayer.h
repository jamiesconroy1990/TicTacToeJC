//
//  ComputerPlayer.h
//  TicTacToeJC
//
//  Created by Jamie Conroy on 27/02/2014.
//  Copyright (c) 2014 Jamie Conroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"
#import "Player.h"

typedef enum{
	kEasy,
	kNormal,
	kHard
} DifficultyLevel;

@interface ComputerPlayer : Player {
	DifficultyLevel difficultyLevel;
}

- (id)initWithPiece:(NSString *)piece;

- (int) getComputerMove:(Board *)board;


@end



