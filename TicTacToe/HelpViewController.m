//
//  HelpViewController.m
//  TicTacToe
//
//  Created by Josef Hilbert on 11.01.14.
//  Copyright (c) 2014 gule. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
{
    
    __weak IBOutlet UIWebView *webView;
}
@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    NSURL *ticTacToeHelp = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/Tic-tac-toe"];
    NSURLRequest *rq = [NSURLRequest requestWithURL:ticTacToeHelp];
    [webView loadRequest:rq];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
