//
//  TicTacToeBoard.m
//  TicTacToe
//
//  Created by Josef Hilbert on 11.01.14.
//  Copyright (c) 2014 gule. All rights reserved.
//

#import "TicTacToeBoard.h"

@interface TicTacToeBoard ()
{
    NSMutableString *myPattern;
    NSString *myMatchingPattern;
}
@end

@implementation TicTacToeBoard


-(id)init{
    
    _fields = [[NSMutableArray alloc] init];
    
    NSString *defaultMarker = @" ";
    for (int i=0; i<9; i++)
    {
        [_fields addObject:defaultMarker];
    }
    _numberOfMove = 0;
    _nextPlayer = @"X";
    return self;
}

- (BOOL)setField:(NSInteger)fieldNumber marker:(NSString *)marker{
    
    NSString *currentMarker = [[NSString alloc]initWithString:[_fields objectAtIndex:fieldNumber-1]];
    if ([currentMarker isEqualToString:@" "])
    {
        [_fields replaceObjectAtIndex:fieldNumber-1 withObject:marker];
        _numberOfMove++;
        
        [self flipPlayer];
        return YES;
    }
    else
    {
        return NO;
    }
    
}

- (NSString*)getField:(NSInteger)fieldNumber{
    
    NSString * field = [_fields objectAtIndex:fieldNumber-1];
    return field;
    
}

// generic search for Character(s) method!
-(int)numberOfOccurances:(NSString*) searchCharacter inString:(NSString*)string {
    
    int count = 0;
    NSString *extract;
    NSRange rangeToExtract;
    
    for (int i = 0; i< (string.length - searchCharacter.length + 1); i++) {
        rangeToExtract = NSMakeRange(i, searchCharacter.length);
        extract = [string substringWithRange:rangeToExtract];
        if ([extract isEqualToString:searchCharacter])
        {
            count++;
        }
    }
    return count;
}


-(void)prepareForPatternCheck{
    myPattern = [[NSMutableString alloc] init];
    
    // 8 patterns for all 8 combinations on the field that make you win
    // 22 patterns for indirect threats
    // 4 patterns for 1st move check
    myMatchingPattern = @"123.456.789.147.258.369.159.357.236.698.874.412.156.158.354.358.752.756.952.954.178.136.314.398.712.796.932.974.129.327.151.353.757.959";
    
    for (int i=0; i<myMatchingPattern.length; i++)
    {
        NSRange rangeToExtract = NSMakeRange(i, 1);
        NSString *extract = [myMatchingPattern substringWithRange:rangeToExtract];
        if ([extract isEqualToString:@"."])
        {
            [myPattern appendString:@"."];
        }
        else
            
        {
            [myPattern appendString:[_fields objectAtIndex:[[myMatchingPattern substringWithRange:rangeToExtract] intValue]-1]];
        }
        
    }
    
}

- (NSInteger)computerMoves
{
    int nextMoveTo = 0;
    
    [self prepareForPatternCheck];
    
    //search for winning opportunity
    NSRange rangeToCheckForWinningPattern = NSMakeRange(0, 8*4);
    NSRange rangeToCheckForThreat = NSMakeRange(0, 30*4);
    NSRange rangeToCheckForStartPattern = NSMakeRange(30*4, 4*4-1);
    
    NSRange rangeToCheckForFreeCenter = NSMakeRange(5, 1);
    NSRange rangeToCheckForFreeEdge1 = NSMakeRange(0, 1);
    NSRange rangeToCheckForFreeEdge2 = NSMakeRange(2, 1);
    NSRange rangeToCheckForFreeEdge3 = NSMakeRange(8, 1);
    NSRange rangeToCheckForFreeEdge4 = NSMakeRange(10, 1);
    
    NSString *searchFor;
    NSRange range;
    int offset;
    
    if (_numberOfMove <=2)
    {
        searchFor = @"X X";
        offset = 1;
        range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForStartPattern];
    }
    if (range.location == NSNotFound ||_numberOfMove >2)
    {
        
        searchFor = @"OO ";
        offset = 2;
        range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForWinningPattern];
        
        if (range.location == NSNotFound)
        {
            searchFor = @" OO";
            offset = 0;
            range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForWinningPattern];
            
            if (range.location == NSNotFound)
            {
                searchFor = @"O O";
                offset = 1;
                range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForWinningPattern];
                
                if (range.location == NSNotFound)
                {
                    // no winning option, defend now!
                    searchFor = @"XX ";
                    offset = 2;
                    range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForWinningPattern];
                    if (range.location == NSNotFound)
                    {
                        searchFor = @" XX";
                        offset = 0;
                        range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForWinningPattern];
                        if (range.location == NSNotFound)
                        {
                            searchFor = @"X X";
                            offset = 1;
                            range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForWinningPattern];
                            
                            if (range.location == NSNotFound)
                            {
                                // no winning option, defend indirect thread with "X X" pattern ONLY!
                                {
                                    searchFor = @"X X";
                                    offset = 1;
                                    range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForThreat];
                                    
                                    if (range.location == NSNotFound)
                                    {
                                        // no winning and no defending --- block middle if still free
                                        searchFor = @" ";
                                        offset = 0;
                                        range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForFreeCenter];
                                        if (range.location == NSNotFound)
                                        {
                                            // no winning and no defending --- block on edges
                                            searchFor = @" ";
                                            offset = 0;
                                            range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForFreeEdge1];
                                            if (range.location == NSNotFound)
                                            {
                                                // no winning and no defending --- block on edges
                                                searchFor = @" ";
                                                offset = 0;
                                                range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForFreeEdge2];
                                                if (range.location == NSNotFound)
                                                {
                                                    // no winning and no defending --- block on edges
                                                    searchFor = @" ";
                                                    offset = 0;
                                                    range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForFreeEdge3];
                                                    if (range.location == NSNotFound)
                                                    {
                                                        // no winning and no defending --- block on edges
                                                        searchFor = @" ";
                                                        offset = 0;
                                                        range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForFreeEdge4];
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    if (range.location != NSNotFound)
    {
        NSRange rangeToExtract = NSMakeRange(range.location + offset, 1);
        nextMoveTo = [[myMatchingPattern substringWithRange:rangeToExtract] intValue];
    }
    
    NSLog(@"match: %d", nextMoveTo);
    
    return nextMoveTo;
}

- (NSString *)whoOne
{
    NSString *winner = nil;
    [self prepareForPatternCheck];
    
    NSRange rangeToCheckForWinningPattern = NSMakeRange(0, 8*4);
    
    NSString *searchFor = @"XXX";
    NSRange range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForWinningPattern];
    
    if (range.location == NSNotFound)
    {
        NSString *searchFor = @"OOO";
        range = [myPattern rangeOfString:searchFor options:0 range:rangeToCheckForWinningPattern];
        
        if (range.location != NSNotFound)
            winner = @"O";
        else
            winner = @"=";
    }
    else
        winner = @"X";
    
    return winner;
}

-(void)flipPlayer
{
    if ([_nextPlayer isEqualToString:@"X"])
    {
        _nextPlayer = @"O";
    }
    else
    {
        _nextPlayer = @"X";
    }
    
}

-(BOOL)gameOver
{
    if ((_numberOfMove >= 9) || [[self whoOne] isEqualToString:@"O"] || [[self whoOne] isEqualToString:@"X" ])
        return YES;
    else
        return NO;
}

//// generic search for Character(s) method!
//-(int)test{
//    
//    int countNumberOfTests = 0;
//    
//    for (int i = 0; i< (string.length - searchCharacter.length + 1); i++) {
//        rangeToExtract = NSMakeRange(i, searchCharacter.length);
//        extract = [string substringWithRange:rangeToExtract];
//        if ([extract isEqualToString:searchCharacter])
//        {
//            count++;
//        }
//    }
//    return count;
//}



@end
