//
//  MainViewController.m
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "MainViewController.h"
#import "AccountObject.h"
#import "Define.h"

@implementation MainViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Ring.md";
    
    [self checkAccountSession];
}

-(void)checkAccountSession
{
    AccountObject *account = [AccountObject accountInfoFromUserDefault];
    if (account)
    {
        DLog(@"Account existed");
    }else{
        DLog(@"Open LoginViewController");
        [self performSegueWithIdentifier: @"MainToStart" sender: nil];
    }
}

@end
