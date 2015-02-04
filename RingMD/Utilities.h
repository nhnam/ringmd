//
//  Utilities.h
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GeneralFunctions.h"

@interface Utilities : NSObject

+ (id)dataForKey: (NSString *)key;
+ (id)dataArchiverForKey: (NSString *)key;
+ (void)saveData: (id)value forKey: (NSString *)key;
+ (void)saveDataArchiver: (id)value forKey: (NSString *)key;
+ (void)removeDataForKey: (NSString *)key;
+ (void)removeAllData;
+ (UIImage *)imageFromCacheURL: (NSString *)url;
+ (CGSize)getSizeWithLineBreakMode:(NSLineBreakMode)lineBreakMode
                              text:(NSString *)text
                              font:(NSString *)fontName
                          fontSize:(CGFloat)fontSize;
/*!
 @abstract Connect network error
 */
+ (void)displayAlertNetworkError:(void (^)( UIAlertView *alertView, NSUInteger buttonIndex))block;
+ (void)showAlertValidation: (NSString *)message textfield: (UITextField *)tf;
+ (void)showAlertConfirm: (NSString *)message completionBlock:(void (^)(UIAlertView *alertView, NSUInteger buttonIndex))block;
+ (void)showAlertWithTitle: (NSString *)title message: (NSString *)message;
+ (void)showAlert: (NSString *)message;

@end
