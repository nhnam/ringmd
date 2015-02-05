//
//  LaunchScreenView.m
//  RingMD
//
//  Created by namnguyen on 2/5/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "LaunchScreenView.h"

@implementation LaunchScreenView
{
    IBOutlet UIView *bgView;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [bgView sizeToFit];
    bgView.frame = CGRectMake(0, screenBounds.size.height - bgView.frame.size.height, screenBounds.size.width, screenBounds.size.height/2);
}

@end
