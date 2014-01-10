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
    IBOutlet UIView *myLabelOne;
    IBOutlet UIView *myLabelTwo;
    __weak IBOutlet UILabel *myLableThree;
    __weak IBOutlet UILabel *myLabelFour;
    __weak IBOutlet UILabel *myLabelFive;
    __weak IBOutlet UILabel *myLabelSix;
    __weak IBOutlet UILabel *myLabelSeven;
    __weak IBOutlet UILabel *myLabelEight;
    __weak IBOutlet UILabel *myLabelNine;
    __weak IBOutlet UILabel *whichPlayerLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
