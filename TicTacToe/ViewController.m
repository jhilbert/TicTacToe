//
//  ViewController.m
//  TicTacToe
//
//  Created by gule on 1/10/2014.
//  Copyright (c) 2014 gule. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    __weak IBOutlet UILabel *myLabelOne;
    __weak IBOutlet UILabel *myLabelTwo;
    __weak IBOutlet UILabel *myLabelThree;
    __weak IBOutlet UILabel *myLabelFour;
    __weak IBOutlet UILabel *myLabelFive;
    __weak IBOutlet UILabel *myLabelSix;
    __weak IBOutlet UILabel *myLabelSeven;
    __weak IBOutlet UILabel *myLabelEight;
    __weak IBOutlet UILabel *myLabelNine;
    __weak IBOutlet UILabel *whichPlayerLabel;
    NSString *labelX;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    labelX = @"X";
    
}


- (IBAction)onLabelTapped:(UITapGestureRecognizer*)tapGestureRecognizer
//{//findLabelUsingPoint to find the UILabel based on the point associated with the tapGestureRecognizer.
//*hint: call findLabelUserPoint from onLabelTapped
{
    
    CGPoint myPoint = [tapGestureRecognizer locationInView:self.view];
    
    UILabel *myLabel = [self findLabelUsingPoint:myPoint];
    
    
    if (myLabel != nil)
    {
        
        
        UIColor *nextColor;
        
        if ([labelX isEqualToString:@"X"])
        {
            nextColor = [UIColor blueColor];
        }
        else
        {
            nextColor = [UIColor redColor];
        }
        
        if ([myLabel.text isEqualToString:@""])
        {
            myLabel.text = labelX;
            myLabel.textColor = nextColor;
        }
        
        if ([labelX isEqualToString:@"X"])
        {
            labelX = @"O";
        }
        else
        {
            labelX = @"X";
        }
    }
    NSString *winner = [self whoOne];
    
}

- (UILabel *)findLabelUsingPoint:(CGPoint)myPoint
{
    
    UILabel *foundLabel = nil;
    if (CGRectContainsPoint(myLabelOne.frame, myPoint))
        foundLabel = myLabelOne;
    if (CGRectContainsPoint(myLabelTwo.frame, myPoint))
        foundLabel = myLabelTwo;
    if (CGRectContainsPoint(myLabelThree.frame, myPoint))
        foundLabel = myLabelThree;
    if (CGRectContainsPoint(myLabelFour.frame, myPoint))
        foundLabel = myLabelFour;
    if (CGRectContainsPoint(myLabelFive.frame, myPoint))
        foundLabel = myLabelFive;
    if (CGRectContainsPoint(myLabelSix.frame, myPoint))
        foundLabel = myLabelSix;
    if (CGRectContainsPoint(myLabelSeven.frame, myPoint))
        foundLabel = myLabelSeven;
    if (CGRectContainsPoint(myLabelEight.frame, myPoint))
        foundLabel = myLabelEight;
    if (CGRectContainsPoint(myLabelNine .frame, myPoint))
        foundLabel = myLabelNine;   ;
    
    return foundLabel;
    
}

- (NSString *)whoOne
{
    NSString *winner = nil;
    
    if ([myLabelOne.text isEqualToString:myLabelTwo.text] && [myLabelOne.text isEqualToString:myLabelThree.text] && ![myLabelOne.text isEqualToString:@""])
        winner = myLabelOne.text;
    
    if ([myLabelOne.text isEqualToString:myLabelFour.text] && [myLabelOne.text isEqualToString:myLabelSeven.text] && ![myLabelOne.text isEqualToString:@""])
        winner = myLabelOne.text;

    if ([myLabelOne.text isEqualToString:myLabelFive.text] && [myLabelOne.text isEqualToString:myLabelNine.text] && ![myLabelOne.text isEqualToString:@""])
        winner = myLabelOne.text;
    
    
    if ([myLabelFour.text isEqualToString:myLabelFive.text] && [myLabelFour.text isEqualToString:myLabelSix.text] && ![myLabelFour.text isEqualToString:@""])
        winner = myLabelFour.text;
    
    
    if ([myLabelSeven.text isEqualToString:myLabelEight.text] && [myLabelSeven.text isEqualToString:myLabelNine.text] && ![myLabelSeven.text isEqualToString:@""])
        winner = myLabelSeven.text;
    
    
    if ([myLabelTwo.text isEqualToString:myLabelFive.text] && [myLabelTwo.text isEqualToString:myLabelEight.text] && ![myLabelTwo.text isEqualToString:@""])
        winner = myLabelTwo.text;
    
    
    if ([myLabelThree.text isEqualToString:myLabelSix.text] && [myLabelThree.text isEqualToString:myLabelNine.text] && ![myLabelThree.text isEqualToString:@""])
        winner = myLabelThree.text;
    
    
    if ([myLabelThree.text isEqualToString:myLabelFive.text] && [myLabelThree.text isEqualToString:myLabelSeven.text] && ![myLabelThree.text isEqualToString:@""])
        winner = myLabelThree.text;
    
    
    whichPlayerLabel.text = winner;
    
    return winner;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
