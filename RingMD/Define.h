//
//  Define.h
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#ifndef RingMD_Define_h
#define RingMD_Define_h

#define StartToPatientSignUp @"StartToPatientSignUp"

#define APP_NAME                @"RingMD"

#define WIDTH_MSCREEN       [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_MSCREEN      [[UIScreen mainScreen] bounds].size.height

#define kAccount                   @"Account"

#ifdef DEBUG
#define API_SERVER_ROOT_URL    @"https://staging.ring.md"
#else
#define API_SERVER_ROOT_URL    @"https://staging.ring.md"
#endif


//---------------------------------------------------------------------


#define kFormatDateTimeUTC          @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
#define kFormatDateServer           @"yyyy-MM-dd HH:mm:ss"
#define kFormatDateUI               @"dd-MM-yyyy HH:mm:ss"
#define kFormatDateNottimeServer    @"dd-MM-yyyy"


//-------------------------------------------------------

//-------------------------------------------------------
#define kFontHelveticaRegular       @"Helvetica"

//-----------------------------------------------


// Invite Twitter
#define kconsumerKey                @""
#define kconsumerSecrect            @""
#define kOauthTokent_Twitter        @"Twitter_accessTokent"
#define kAllowAccess                @"Allow_Access"


//--------------------------------------------------------
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define CLog(fmt, ...) printf("%s\n", [fmtStr(fmt, ##__VA_ARGS__) cStringUsingEncoding:NSASCIIStringEncoding])
#else
#define DLog(...)
#define CLog(...)
#endif

//--------------------------------------------------------


//Font--------------------------------------------------------
#define kFontTitleSize                          [UIFont fontWithName: @"Helvetica" size:17]


//Alert--------------------------------------------------------

//Title
#define Alert_Title                             @"RingMD"

//Request API
#define Alert_DataError                         @"Data error!"
#define Alert_ServerError                       @"Server error!"
#define Alert_CannotConnectServer               @"Can't connect to server"
#define Alert_NoInternet                        @"Unable to connect with the server. Check your internet connection and try again."

//Sign In, Sign Up
#define Alert_Fullname_Empty                    @"Fullname cannot be blank"
#define Alert_FullnameLimit                     @"Fullname must be at least 6 characters."
#define Alert_Username_Empty                    @"Username cannot be blank"
#define Alert_UsernameValidate                  @"Username already exists. Please try again."
#define Alert_PasswordValidate                  @"Passwords do not match. Please try again."
#define Alert_FieldsAreMissing                  @"Information was missing."
#define Alert_Password_Empty                    @"Password cannot be blank"
#define Alert_PasswordLimit                     @"Password must be at least 6 characters."
#define Alert_UsernameLimit                     @"Username must be at least 6 characters."
#define Alert_FieldsSpaceBar                    @"cannot contain white space."
#define Alert_PasswordIncorrect                 @"Your password is incorrect. Please try again."
#define Alert_PasswordNotMatch                  @"Passwords do not match. Please try again."
#define Alert_Email_Empty                       @"Email address cannot be blank"
#define Alert_EmailInvalid                      @"Your email address is not valid. Please try again."
#define Alert_ForgotPasswordSuccessful          @"A new password has been sent to your e-mail address."
#define Alert_UsernameOrEmail_Empty             @"Username or email cannot be blank"

//Profile
#define Alert_FieldsLimit                       @"must be at least 6 characters."
#define Alert_SaveProfileSuccess                @"Save profile successfully"
#define Alert_ChangePasswordSuccess             @"Change password successfully"
#define Alert_ProfileNoChange                   @"Profile information aren't change"

//Button
#define Button_OK                               @"OK"
#define Button_Cancel                           @"Cancel"
#define Button_Back                             @"Back"
#define Button_Retry                            @"Retry"
#endif
