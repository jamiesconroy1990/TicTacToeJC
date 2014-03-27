//
//  Player.h
//  TicTacToeJC
//
//  Created by Jamie Conroy on 27/02/2014.
//  Copyright (c) 2014 Jamie Conroy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject {
	NSString* name;
	NSString* piece;
}

- (id) initWithName:(NSString*)name
			  piece:(NSString*)piece;

- (NSString *)name;
- (void)setName:(NSString *)value;

- (NSString *)piece;
- (void)setPiece:(NSString *)value;

@end
