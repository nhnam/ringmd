//
//  LoginNaviController.m
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "LoginNaviController.h"

#define bar_color [UIColor colorWithRed:78.0/255 green:188.0/255 blue:228.0/255 alpha:255.0/255]

@implementation LoginNaviController

@synthesize transitioning = _transitioning;
@synthesize stack = _stack;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    self.stack = [[NSMutableArray alloc] init];
    self.navigationBar.backIndicatorImage = [[UIImage alloc] init];
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    CGRect bkRect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
    [self.navigationBar setBackgroundImage:[self imageWithColor:bar_color rect:bkRect] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.hidden = YES;
    self.navigationBar.backgroundColor = bar_color;
    self.navigationBar.clipsToBounds = NO;
}

-(UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)frame
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

































- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    @synchronized(self.stack) {
        if (self.transitioning) {
            void (^codeBlock)(void) = [^{
                [super popViewControllerAnimated:animated];
            } copy];
            [self.stack addObject:codeBlock];
            
            // We cannot show what viewcontroller is currently animated now
            return nil;
        } else {
            return [super popViewControllerAnimated:animated];
        }
    }
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    @synchronized(self.stack) {
        if (self.transitioning) {
            void (^codeBlock)(void) = [^{
                [super popToRootViewControllerAnimated:animated];
            } copy];
            [self.stack addObject:codeBlock];
            
            // We cannot show what viewcontroller is currently animated now
            return nil;
        } else {
            return [super popToRootViewControllerAnimated:animated];
        }
    }
}

- (NSArray*) popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    @synchronized(self.stack) {
        if (self.transitioning) {
            void (^codeBlock)(void) = [^{
                [super popToViewController:viewController animated:animated];
            } copy];
            [self.stack addObject:codeBlock];
            
            // We cannot show what viewcontroller is currently animated now
            return nil;
        } else {
            return [super popToViewController:viewController animated:animated];
        }
    }
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
    @synchronized(self.stack) {
        if (self.transitioning) {
            // Copy block so its no longer on the (real software) stack
            void (^codeBlock)(void) = [^{
                [super setViewControllers:viewControllers animated:animated];
            } copy];
            
            // Add to the stack list and then release
            [self.stack addObject:codeBlock];
        } else {
            [super setViewControllers:viewControllers animated:animated];
        }
    }
}

- (void) pushCodeBlock:(void (^)())codeBlock{
    @synchronized(self.stack) {
        [self.stack addObject:[codeBlock copy]];
        
        if (!self.transitioning)
            [self runNextBlock];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    @synchronized(self.stack) {
        if (self.transitioning) {
            void (^codeBlock)(void) = [^{
                [super pushViewController:viewController animated:animated];
            } copy];
            [self.stack addObject:codeBlock];
        } else {
            [super pushViewController:viewController animated:animated];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    @synchronized (self.stack) {
        self.transitioning = true;
        id <UIViewControllerTransitionCoordinator> transitionCoordinator = navigationController.topViewController.transitionCoordinator;
        [transitionCoordinator notifyWhenInteractionEndsUsingBlock:^(id <UIViewControllerTransitionCoordinatorContext> context) {
            if ([context isCancelled]) {
                @synchronized (self.stack) {
                    self.transitioning = false;
                }
            }
        }];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    @synchronized(self.stack) {
        self.transitioning = false;
        
        [self runNextBlock];
    }
}

- (void) runNextBlock {
    if (self.stack.count == 0)
        return;
    
    void (^codeBlock)(void) = [self.stack objectAtIndex:0];
    
    // Execute block, then remove it from the stack (which will dealloc)
    codeBlock();
    
    [self.stack removeObjectAtIndex:0];
}

@end
