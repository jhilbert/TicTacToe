//
//  ViewController.m
//  TicTacToe
//
//  Created by gule on 1/10/2014.
//  Copyright (c) 2014 gule. All rights reserved.
//

#import "ViewController.h"
#import "TicTacToeBoard.h"

@interface ViewController ()
{
    __weak IBOutlet UILabel *countDownLabel;
    __weak IBOutlet UILabel *myLabelOne;
    __weak IBOutlet UILabel *myLabelTwo;
    __weak IBOutlet UILabel *myLabelThree;
    __weak IBOutlet UILabel *myLabelFour;
    __weak IBOutlet UILabel *myLabelFive;
    __weak IBOutlet UILabel *myLabelSix;
    __weak IBOutlet UILabel *myLabelSeven;
    __weak IBOutlet UILabel *myLabelEight;
    __weak IBOutlet UILabel *myLabelNine;
    __weak IBOutlet UILabel *nextPlayerLabel;
    
    
    __weak IBOutlet UIButton *gameOverButton;
    
    
    NSMutableArray *fields;
    
    CGAffineTransform defaultTransform;
    
    
    NSTimer *myTimer;
    int countdown;
    BOOL timerActive;
    
    TicTacToeBoard *ttt;
    NSInteger foundAt;
    UILabel *myHelperLabel;
}

@end

@implementation ViewController

- (void)resetTimer
{
    [myTimer invalidate];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(oneSec:) userInfo:nil repeats:YES];
    timerActive = YES;
    countdown = 10;
    countDownLabel.text = [NSString stringWithFormat:@"%i", countdown];
    countDownLabel.hidden = NO;
}

-(void)oneSec:(NSTimer *)timer {
    
    if (timerActive == YES){
        countdown--;
        if (countdown == 0)
        {
            [ttt flipPlayer];
            [self updateButtonForNextPlayer];
            [self computerMakeMove];
            
            [self resetTimer];
        }
        else{
            countDownLabel.text = [NSString stringWithFormat:@"%i", countdown];
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ttt = [[TicTacToeBoard alloc]init];
    
    gameOverButton.alpha = 0;
    gameOverButton.hidden = YES;
    
    defaultTransform = nextPlayerLabel.transform;
    
    fields = [[NSMutableArray alloc] initWithCapacity:9];
    
    for (UILabel *label in self.view.subviews)
    {
        if ([label isKindOfClass:[UILabel class]] && [label.text isEqualToString:@"F"])
        {
            [fields addObject:label];
        }
        
    }
    
    // get all UILabels which make the fields into fields-array
    for (UILabel *label in fields)
    {
        [label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TTTField.png"]]];
        label.text = @" ";
    }
    
    [nextPlayerLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TTTXBlue2.png"]]];
    nextPlayerLabel.text = @"";
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Help?" style:UIBarButtonItemStylePlain target:self action:@selector(onHelpPressed:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    [self resetTimer];
    
}

-(void)viewDidAppear:(BOOL)animated {
    timerActive = YES;
}

- (void)updateButtonForNextPlayer
{
    if ([ttt.nextPlayer isEqualToString:@"X"])
    {
        [nextPlayerLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TTTXBlue2.png"]]];
    }
    else
    {
        [nextPlayerLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TTTORed.png"]]];
    }
    
}

- (void)computerMakeMove
{
    if (_numberOfPlayers == 1 && ttt.numberOfMove < 8)
    {
        
        UILabel *hit;
        
        foundAt = [ttt computerMoves];
        [ttt setField:foundAt marker:@"O"];
        
        hit = [fields objectAtIndex:foundAt-1];
        hit.backgroundColor = nextPlayerLabel.backgroundColor;
        
        [self makeMove:hit];
    }
}

- (void)makeMove:(UILabel*)hit
{
    hit.backgroundColor = nextPlayerLabel.backgroundColor;
    
    [self updateButtonForNextPlayer];
    [self resetTimer];
    
    if (ttt.gameOver)
    {
        [myTimer invalidate];
        timerActive = NO;
        countDownLabel.hidden = YES;
        
        gameOverButton.alpha = 1;
        gameOverButton.hidden = NO;
        
        
        if([[ttt whoOne] isEqualToString:@"X"])
        {
            [gameOverButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TTTGameOverPlayerX.png"]]];
        }
        else
        {
            if([[ttt whoOne] isEqualToString:@"O"])
            {
                [gameOverButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TTTGameOverPlayerO.png"]]];
            }
            else
            {
                [gameOverButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TTTGameOverDraw.png"]]];
            }
        }
        
    }
}

- (IBAction)onDrag:(UIPanGestureRecognizer*)panGestureRegocnizer
{
    
    if (ttt.gameOver == NO){
        
        
        CGPoint myPoint = [panGestureRegocnizer locationInView:self.view];
        
        if (panGestureRegocnizer.state == UIGestureRecognizerStateEnded)
        {
            UILabel *hit = nil;
            hit = [self findLabelUsingPoint:myPoint];
            
            if ([ttt setField:foundAt marker:ttt.nextPlayer] == YES)
            {
                [self makeMove:hit];
                [self computerMakeMove];
                
            }
            
            
            [UIView animateWithDuration:0.5f animations:^{
                nextPlayerLabel.transform = defaultTransform;}];
            
        }
        else
        {
            
            CGPoint myPointForTransform = [panGestureRegocnizer translationInView:self.view];
            
            nextPlayerLabel.transform = CGAffineTransformMakeTranslation(myPointForTransform.x, myPointForTransform.y);
            
        }
        
    }
    
}

- (UILabel *)findLabelUsingPoint:(CGPoint)myPoint
{
    
    UILabel *foundLabel = nil;
    foundAt = 0;
    
    for (UILabel *label in fields)
    {
        foundAt++;
        if (CGRectContainsPoint(label.frame, myPoint))
        {
            foundLabel = label;
            break;
        }
    }
    
    return foundLabel;
    
}

- (IBAction)onHelpPressed:(id)sender {
    timerActive = NO;
    [self performSegueWithIdentifier:@"Help" sender:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
