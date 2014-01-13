//
//  TicTacToeBoard.h
//  TicTacToe
//
//  Created by Josef Hilbert on 11.01.14.
//  Copyright (c) 2014 gule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicTacToeBoard : NSObject

{
    
    
}
@property (nonatomic) NSMutableArray *fields;
@property (nonatomic) NSInteger numberOfPlayers;
@property (nonatomic) NSInteger numberOfMove;
@property (nonatomic) NSString *nextPlayer;

- (BOOL)setField:(NSInteger)fieldNumber marker:(NSString*)marker;
- (NSString *)getField:(NSInteger)fieldNumber;
- (NSInteger)computerMoves;
- (NSString *)whoOne;
- (BOOL)gameOver;
- (void)flipPlayer;

@end


