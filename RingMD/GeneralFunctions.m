//
//  GeneralFunctions.m
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "GeneralFunctions.h"
#import "Define.h"
#import <MBProgressHUD.h>
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#import "AFNetworkReachabilityManager.h"
#import <sys/utsname.h>

#pragma mark -
#pragma mark Extenstion For UIAlertView
#pragma mark -
#define kBlockCallBack                "blockAlerViewCallback"
#define kBlockDissmiss                "blockAlerViewSetDismissBlock"

#define kValidationSpecialCharacter   @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz._"
#define kValidationSpecialNumber      @"0123456789"

@implementation UIAlertView (BlockExtensions)

- (id)initWithTitle:(NSString *)title message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...  {
    
    if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil]) {
        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            self.cancelButtonIndex = [self numberOfButtons] - 1;
        }
        
        
        if (otherButtonTitles) {
            va_list argumentList;
            va_start(argumentList, otherButtonTitles);
            do{
                [self addButtonWithTitle:otherButtonTitles];
            }
            while ((otherButtonTitles = va_arg(argumentList, id)));
            va_end(argumentList);
        }
    }
    return self;
    
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
    completionBlock:(void (^)(UIAlertView *alertView, NSUInteger buttonIndex))block
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...  {
    
    objc_setAssociatedObject(self, kBlockCallBack, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil]) {
        
        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            self.cancelButtonIndex = [self numberOfButtons] - 1;
        }
        
        
        if (otherButtonTitles) {
            va_list argumentList;
            va_start(argumentList, otherButtonTitles);
            do{
                [self addButtonWithTitle:otherButtonTitles];
            }
            while ((otherButtonTitles = va_arg(argumentList, id)));
            va_end(argumentList);
        }
    }
    return self;
}
-(void)setDismissBlock:(void(^)( UIAlertView *alertView, NSUInteger buttonIndex))blockDismiss{
    objc_setAssociatedObject(self, kBlockDissmiss, blockDismiss, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    void (^block)(UIAlertView *alertView, NSUInteger buttonIndex) = objc_getAssociatedObject(self,kBlockCallBack);
    void (^blockDismiss)(UIAlertView *alertView, NSUInteger buttonIndex) = objc_getAssociatedObject(self, kBlockDissmiss);
    if (blockDismiss) {
        blockDismiss(self,buttonIndex);
        objc_removeAssociatedObjects(blockDismiss);
        objc_setAssociatedObject(self, kBlockDissmiss, nil, OBJC_ASSOCIATION_ASSIGN);
    }
    else if (block){
        block(self,buttonIndex);
        objc_removeAssociatedObjects(block);
        objc_setAssociatedObject(self, kBlockCallBack, nil, OBJC_ASSOCIATION_ASSIGN);
    }
}

@end

#pragma mark - Func Check
bool isConnectNetwork()
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}
bool isPhone5()
{
    return (fabs((double)(isIOS8()? WIDTH_MSCREEN : HEIGHT_MSCREEN) - (double)568) < DBL_EPSILON);
}
bool isIpad()
{
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"])
        return YES;
    else
        return NO;
}
bool isRetina()
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))
        return YES;
    
    return NO;
}
bool isEmpty(NSString *inputString)
{
    if (!inputString || [inputString length] == 0 || [[inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

bool isPasswordAvailable(NSString* password){
    if (!password || [password length] == 0 || [[password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] < 6){
        return NO;
    }
    return YES;
}

bool isEmptyJSON(NSDictionary* dic,NSString *key)
{
    if ([dic objectForKey:key] && ![[dic objectForKey:key] isEqual:[NSNull null]])
        return NO;
    return YES;
}

bool isEmailAvailable(NSString *email_addr)
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email_addr];
}
int versioniOS()
{
    NSArray *versionCompatibility = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    return [[versionCompatibility objectAtIndex:0] intValue];
}
NSString *buildVersion()
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

NSString* appVersion()
{
    NSString* bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    return bundleVersion;
}

NSString *deviceUdid()
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

NSString* platformType()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

bool isIOS8()
{
    return (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1);
}

NSString* platformString()
{
    NSString *platform = platformType();
    
    if ([platform isEqualToString:@"iPhone3,1"] ||
        [platform isEqualToString:@"iPhone3,3"])
        return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])
        return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"] ||
        [platform isEqualToString:@"iPhone5,2"])
        return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"] ||
        [platform isEqualToString:@"iPhone5,4"])
        return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"] ||
        [platform isEqualToString:@"iPhone6,2"])
        return @"iPhone 5S";
    
    if ([platform isEqualToString:@"iPod1,1"])
        return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])
        return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])
        return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])
        return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])
        return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])
        return @"iPad";
    
    if ([platform isEqualToString:@"iPad2,1"] ||
        [platform isEqualToString:@"iPad2,2"] ||
        [platform isEqualToString:@"iPad2,3"] ||
        [platform isEqualToString:@"iPad2,4"])
        return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"] ||
        [platform isEqualToString:@"iPad2,6"] ||
        [platform isEqualToString:@"iPad2,7"])
        return @"iPad Mini";
    if ([platform isEqualToString:@"iPad3,1"] ||
        [platform isEqualToString:@"iPad3,2"] ||
        [platform isEqualToString:@"iPad3,3"])
        return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"] ||
        [platform isEqualToString:@"iPad3,5"] ||
        [platform isEqualToString:@"iPad3,6"])
        return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"] ||
        [platform isEqualToString:@"iPad4,2"])
        return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"] ||
        [platform isEqualToString:@"iPad4,5"])
        return @"iPad Mini 2";
    
    if ([platform isEqualToString:@"i386"] ||
        [platform isEqualToString:@"x86_64"])
        return @"Simulator";
    
    return platform;
}

void fontsOfiOS()
{
    for (NSString *familyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            DLog(@"%@", fontName);
        }
    }
}

#pragma mark - Date
NSInteger yearFromDate(NSDate *myDate)
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSYearCalendarUnit;
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:myDate];
    NSInteger year = [dateComponents year];
    
    return year;
    
}
NSInteger monthFromDate(NSDate *myDate)
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSMonthCalendarUnit;
    
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:myDate];
    NSInteger month = [dateComponents month];
    
    return month;
}
NSString *monthStringFromDate(NSDate *myDate)
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSMonthCalendarUnit;
    
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:myDate];
    NSInteger month = [dateComponents month];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *months = [dateFormatter monthSymbols];
    return [months objectAtIndex:month-1];
}
NSInteger dayFromDate(NSDate *myDate)
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:myDate];
    NSInteger day = [dateComponents day];
    return day;
}

NSInteger hourFromDate(NSDate *myDate)
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSHourCalendarUnit;
    
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:myDate];
    NSInteger hour = [dateComponents hour];
    return hour;
}
NSInteger minuteFromDate(NSDate *myDate)
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSMinuteCalendarUnit;
    
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:myDate];
    NSInteger minute = [dateComponents minute];
    
    return minute;
}
NSInteger secondFromDate(NSDate *myDate)
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSSecondCalendarUnit;
    
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:myDate];
    NSInteger second = [dateComponents second];
    
    return second;
    
}
NSArray  *getMonths()
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    return [dateFormatter monthSymbols];
}
#pragma mark + Convert Date

NSDate *convertStringToDate(NSString *myString,NSString *myFormatter)
{
    if (myString) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:myFormatter];
        [formatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 0]];
        NSDate *date = [formatter dateFromString:myString];
        return date;
    }
    return nil;
}
NSString *convertDateToString(NSDate *myDate,NSString *myFormatter)
{
    NSString *returnStr = @"";
    if (myDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:myFormatter];
        [formatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 0]];
        returnStr = [formatter stringFromDate:myDate];
        return returnStr;
    }
    return returnStr;
}

NSString *convertDateToStringLocal(NSDate *myDate,NSString *myFormatter)
{
    NSString *returnStr = @"";
    if (myDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:myFormatter];
        //        [formatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 0]];
        returnStr = [formatter stringFromDate:myDate];
        return returnStr;
    }
    return returnStr;
}

NSString *convertMonthFromNumberToString(int monthInt)
{
    if (monthInt <= 0)
        return @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *months = [dateFormatter monthSymbols];
    return [months objectAtIndex:monthInt-1];
}
int convertMonthFromStringToNumber(NSString *monthText)
{
    if (isEmpty(monthText)) {
        return 0;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *months = [dateFormatter monthSymbols];
    for (int i = 0; i < 12; i++){
        NSString *_month = [months objectAtIndex:i];
        if ([_month isEqualToString:monthText]) {
            return i+1;
        }
    }
    return 0;
}
#pragma mark + Process UTC Date
NSString* getDateString()
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormat setTimeZone:timeZone];
    [dateFormat setDateFormat:kFormatDateTimeUTC];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}
NSString* getDateStringWithDate(NSDate *date)
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormat setTimeZone:timeZone];
    [dateFormat setDateFormat:kFormatDateTimeUTC];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}
NSDate* convertDateFromUTCToTimezone(NSString * UTCString)
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ssZ"];
    [dateFormatter setDateFormat: kFormatDateTimeUTC];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *localDate = [dateFormatter dateFromString:UTCString];
    return localDate;
}

NSDate* getDateUTC()
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormat setTimeZone:timeZone];
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = getDateString();
    NSDate *currentDate = [dateFormat dateFromString:dateString];
    return currentDate;
}
#pragma mark - Path Method
BOOL isExistFile(NSString* path)
{
    return  [[NSFileManager defaultManager] fileExistsAtPath:path];
}

void removePath(NSString* path)
{
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

void createDirectory(NSString* path)
{
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
}

BOOL isExistDirectory(NSString* path)
{
    BOOL is = NO;
    if([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&is])
        return YES;
    return NO;
}
#pragma mark - Sort Method
NSMutableArray *sortByAttributeInDictionaries(NSMutableArray *arraySort, NSString *keySort, BOOL ascending)
{
    NSArray *array;
    NSSortDescriptor *descriptor =
    [[NSSortDescriptor alloc] initWithKey:keySort
                                ascending:ascending
                                 selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
    array = [arraySort sortedArrayUsingDescriptors:descriptors];
    NSMutableArray *sortedArray= [NSMutableArray arrayWithArray:array];
    return sortedArray;
}

#pragma mark - Other Methods
void exclusiveTouchForArrayView(NSArray *arrayView)
{
    for (UIView *_view in arrayView) {
        if (_view.subviews.count <= 1)
            [_view setExclusiveTouch:YES];
        else
            exclusiveTouchForArrayView(_view.subviews);
    }
}
void showIndicator()
{
    [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
}

void hideIndicator()
{
    [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
}

void showIndicatorInView(UIView *aView)
{
    [MBProgressHUD showHUDAddedTo:aView animated:YES];
}

void hideIndicatorInView(UIView *aView)
{
    [MBProgressHUD hideHUDForView:aView animated:YES];
}

BOOL validationSpecialChracter(NSString* string){
    NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:kValidationSpecialCharacter] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
BOOL validationSpecialChracterWithoutspacebar(NSString* string)
{
    NSString *avilableCharacter = @"[A-Z0-9a-z._ ]";
    NSPredicate *filtered = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", avilableCharacter];
    return [filtered evaluateWithObject:string];
}
BOOL validationSpecialNumber(NSString* string){
    NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:kValidationSpecialNumber] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

NSString *formatIdentificationNumber(NSString *strNumber){
    NSMutableString *result = [NSMutableString stringWithCapacity:strNumber.length];
    NSScanner *scanner = [NSScanner scannerWithString:strNumber];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:kValidationSpecialNumber];
    while ([scanner isAtEnd] == NO)
    {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
            [result appendString:buffer];
        else
            [scanner setScanLocation:([scanner scanLocation] + 1)];
    }
    return result;
}


