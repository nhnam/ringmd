//
//  Utilities.m
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "Utilities.h"
#import "Define.h"

@implementation Utilities

+ (id)dataForKey: (NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey: key];
}

+ (id)dataArchiverForKey: (NSString *)key {
    
    NSData *data = [self dataForKey: key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)saveData: (id)value forKey: (NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setObject: value forKey: key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveDataArchiver: (id)value forKey: (NSString *)key {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: value];
    [self saveData: data forKey: key];
}

+ (void)removeDataForKey: (NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeAllData {
    
//    [FacebookInstance logOut];
//    [TwitterKit logOut];
    
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict)
    {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    
    //    NSString *domainName = [[NSBundle mainBundle] bundleIdentifier];
    //    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName: domainName];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - displayAlertNetworkError

+ (void)displayAlertNetworkError:(void (^)( UIAlertView *alertView, NSUInteger buttonIndex))block{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: Alert_Title
                                                        message: Alert_NoInternet
                                                completionBlock: block
                                              cancelButtonTitle: Button_OK
                                              otherButtonTitles: nil];
    [alertView show];
}

+ (void)showAlertValidation: (NSString *)message textfield: (UITextField *)tf {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: Alert_Title
                                                    message: message
                                            completionBlock:^(UIAlertView *alertView, NSUInteger buttonIndex) {
                                                [[UIApplication sharedApplication].keyWindow setUserInteractionEnabled:YES];
                                                
                                                if (tf)
                                                    [tf becomeFirstResponder];
                                                
                                            }cancelButtonTitle: Button_OK otherButtonTitles: nil];
    [alert show];
}

+ (void)showAlertConfirm: (NSString *)message completionBlock:(void (^)(UIAlertView *alertView, NSUInteger buttonIndex))block {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: Alert_Title
                                                    message: message
                                            completionBlock: block
                                          cancelButtonTitle: Button_OK otherButtonTitles: nil];
    [alert show];
}


+ (void)showAlertWithTitle: (NSString *)title message: (NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:Button_OK
                                              otherButtonTitles:nil];
    [alertView show];
}


+ (void)showAlert: (NSString *)message {
    [Utilities showAlertWithTitle: Alert_Title message: message];
}

+ (UIImage *)imageFromCacheURL: (NSString *)url {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    NSCachedURLResponse *response = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    
    if (response && response.data)
        return [UIImage imageWithData: response.data];
    
    return nil;
}
#pragma mark - setHeight label
+ (CGSize)getSizeWithLineBreakMode:(NSLineBreakMode)lineBreakMode
                              text:(NSString *)text
                              font:(NSString *)fontName
                          fontSize:(CGFloat)fontSize
{
    CGSize maximumSize;
    if (isPhone5()) {
        maximumSize = CGSizeMake(300, 9999);
    }
    else
    {
        maximumSize = CGSizeMake(250, 9999);
    }
    //NSString *myString = @"This is a long string which wraps";
    UIFont *myFont = [UIFont fontWithName:fontName size:fontSize];
    CGSize myStringSize;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        myStringSize = [text sizeWithFont:myFont
                        constrainedToSize:maximumSize
                            lineBreakMode:lineBreakMode];
        
    } else {
        // Load resources for iOS 7 or later
        NSDictionary *attributesDictionary = [[NSDictionary alloc]
                                              initWithObjectsAndKeys:myFont, NSFontAttributeName, nil];
        CGRect rect = [text boundingRectWithSize:maximumSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributesDictionary
                                         context:nil];
        myStringSize = rect.size;
    }
    return myStringSize;
    
}

@end
