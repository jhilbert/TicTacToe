//
//  StartScreenViewController.m
//  TicTacToe
//
//  Created by Josef Hilbert on 11.01.14.
//  Copyright (c) 2014 gule. All rights reserved.
//

#import "StartScreenViewController.h"
#import "ViewController.h"

@interface StartScreenViewController ()
{
     NSInteger numberOfPlayers;
    __weak IBOutlet UIButton *onePlayerButton;
    __weak IBOutlet UIButton *twoPlayerButton;
}

@end

@implementation StartScreenViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TTTiPhone480x320.png"]]];
    [onePlayerButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TTTOnePlayer.png"]]];
    [twoPlayerButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TTTTwoPlayer.png"]]];
}
- (IBAction)onOnePlayerPressed:(id)sender {
    numberOfPlayers = 1;
    [self performSegueWithIdentifier:@"MySegue" sender:sender];
}

- (IBAction)onTwoPlayerPressed:(id)sender {
    numberOfPlayers = 2;
    [self performSegueWithIdentifier:@"MySegue" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MySegue"])
    {
        ViewController *vc = [segue destinationViewController];
        //NSInteger tagIndex = [(UIButton *)sender tag];
        
        [vc setNumberOfPlayers:numberOfPlayers];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
