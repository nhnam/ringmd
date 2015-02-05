//
//  DoctorSignUpViewController.m
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "DoctorSignUpViewController.h"

@interface DoctorSignUpViewController ()

@end

@implementation DoctorSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Doctor Registration";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // enable title bar
    self.navigationController.navigationBar.hidden = NO;
    
    // set color to white
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // set title text white color
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    // disable back text string
    self.navigationController.navigationBar.topItem.title = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
