//
//  LoginNaviController.h
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UIKit/UINavigationController.h>

@interface LoginNaviController : UINavigationController <UINavigationControllerDelegate>
- (void) pushCodeBlock:(void (^)())codeBlock;
- (void) runNextBlock;

@property (nonatomic, retain) NSMutableArray* stack;
@property (nonatomic, assign) bool transitioning;
@end
