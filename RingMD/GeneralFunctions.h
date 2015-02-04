//
//  GeneralFunctions.h
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - ALERT VIEW
@interface UIAlertView (BlockExtensions) <UIAlertViewDelegate>

#if NS_BLOCKS_AVAILABLE
- (id)initWithTitle:(NSString *)title message:(NSString *)message completionBlock:(void (^)( UIAlertView *alertView, NSUInteger buttonIndex))block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_AVAILABLE(10_6, 4_0);

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_AVAILABLE(10_6, 4_0);

- (void)setDismissBlock:(void (^)(UIAlertView *alertView, NSUInteger buttonIndex))blockDismiss NS_AVAILABLE(10_6, 4_0) ;
#endif

@end

//************************ Check Functions*******************
//-----------------------------------------------------
/*!
 @abstract check wifi network。Whether or not the network is currently reachable
 @result YES : have wifi。
 */
bool isConnectNetwork();

/*!
 @abstract check device。
 @result YES : if it's iPhone 5。
 */
bool isPhone5();

/*!
 @abstract check device retina。
 @result YES : if it's device retina。
 */
bool isRetina();
// check Device
bool isIpad();

bool isIOS8();

/*!
 @abstract check text empty。
 */
bool isEmpty(NSString *inputString);
bool isEmptyJSON(NSDictionary* dic,NSString *key);

/*!
 @abstract Validate email。
 */
bool isEmailAvailable(NSString* email_addr);

/*!
 @abstract Validate password 6 characters。
 */
bool isPasswordAvailable(NSString* password);

/*!
 
 @abstract get version iOS。
 */
int versioniOS();
NSString * buildVersion();

NSString* appVersion();

NSString *deviceUdid();

NSString* platformType();

NSString* platformString();

void fontsOfiOS();

#pragma mark - DATE
//************************ Get Date *******************
//-----------------------------------------------------
NSInteger yearFromDate(NSDate *myDate);
NSInteger monthFromDate(NSDate *myDate);
NSInteger dayFromDate(NSDate *myDate);
NSInteger hourFromDate(NSDate *myDate);
NSInteger minuteFromDate(NSDate *myDate);
NSInteger secondFromDate(NSDate *myDate);
NSArray  *getMonths();//return 12 moths of year。
NSString *monthStringFromDate(NSDate *myDate);

//************************ Convert Date ********************
//----------------------------------------------------------
NSDate   *convertStringToDate(NSString *myString,NSString *myFormatter);
NSString *convertDateToString(NSDate *myDate,NSString *myFormatter);
NSString *convertDateToStringLocal(NSDate *myDate,NSString *myFormatter);
NSString *convertMonthFromNumberToString(int monthInt);
int convertMonthFromStringToNumber(NSString *monthText);
//----------------------------------------------------------

/*!
 @abstract proccess with UTC。
 */
NSString* getDateString();
NSString* getDateStringWithDate(NSDate *date);
NSDate* convertDateFromUTCToTimezone(NSString * UTCString);
NSDate* getDateUTC();
//-----------------------------------------------------

#pragma mark - Sort Method
/*!
 @abstract sort by attribute in a Array Dictionary 。
 */
NSMutableArray *sortByAttributeInDictionaries(NSMutableArray *arraySort, NSString *keySort, BOOL ascending);

#pragma mark - Path Method
BOOL isExistFile(NSString* path);
BOOL isExistDirectory(NSString* path);
void removePath(NSString* path);
void createDirectory(NSString* path);

#pragma mark - Other Methods

/*!
 @abstract set ExclusiveTouch for children view。
 */
void exclusiveTouchForArrayView(NSArray *arrayView);

void showIndicator();
void hideIndicator();
void showIndicatorInView(UIView *aView);
void hideIndicatorInView(UIView *aView);

/*!
 @abstract Validation Special Character
 */
BOOL validationSpecialChracter(NSString* string);
/*!
 @abstract Validation Special Character without spacebar
 */
BOOL validationSpecialChracterWithoutspacebar(NSString* string);
/*!
 @abstract Format Identification Number
 */
NSString *formatIdentificationNumber(NSString *strNumber);

/*!
 @abstract Validation Special Number
 */
BOOL validationSpecialNumber(NSString* string);

