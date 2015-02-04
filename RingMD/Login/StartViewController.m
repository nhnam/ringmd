//
//  StartViewController.m
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "StartViewController.h"
#import "Define.h"
#import "GeneralFunctions.h"
#import "Utilities.h"
#import "AccountObject.h"
#import "DataManager.h"

#import <QuartzCore/QuartzCore.h>

#define LOGIN_FAIL_MESSAGE @"Email and password combination is invalid"

@interface StartViewController ()
{
    UIImageView *logoView;
    UIView *signInContainerView;
    UIView *signUpContainerView;
    
    UITextField *emailTxF;
    UITextField *passTxF;
    UIButton    *signInBtn;
    UIButton    *gotoSignUpBtn;
    
    UIButton *patientBtn;
    UIButton *doctorBtn;
    UIButton    *gotoSignInBtn;
    
    UISwipeGestureRecognizer *swipeLeftGesture;
    UISwipeGestureRecognizer *swipeRightGesture;
    
    UITapGestureRecognizer *tabGesture;
    
    BOOL state;
}
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Start";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    UIImage *bg          = [UIImage imageNamed:@"ring_bg"];
    UIImageView *bgView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, screenBounds.size.height/2, screenBounds.size.width, screenBounds.size.height/2)];
    bgView.image         = bg;
    bgView.contentMode   = UIViewContentModeScaleAspectFill;
    bgView.clipsToBounds = NO;
    [self.view addSubview:bgView];
    
    logoView             = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 160)];
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    logoView.image       = [UIImage imageNamed:@"ring_logo"];
    logoView.center      = CGPointMake(screenBounds.size.width / 2, 170);
    [self.view addSubview:logoView];
    logoView.alpha = 0;
    
    [self setupSignInLayout];
    
    [self setupSignUpLayout];
    
    tabGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHideKeyBoard)];
    [self.view addGestureRecognizer:tabGesture];
    
    swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:swipeRightGesture];
    
    state = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // show login container
    CGRect endRect = logoView.frame;
    CGRect beginRect = endRect;
    beginRect.origin.y += 44;
    logoView.frame = beginRect;
    [UIView animateWithDuration:0.8
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0
                        options:0
                     animations:^{
        logoView.alpha = 1.0;
        logoView.frame = endRect;
    } completion:^(BOOL finished)
    {
        CGRect endRect = signInContainerView.frame;
        CGRect beginRect = endRect;
        beginRect.origin.y += 40;
        signInContainerView.frame = beginRect;
        [UIView animateWithDuration:0.8
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0
                            options:0
                         animations:^{
                             signInContainerView.alpha = 1.0;
                             signInContainerView.frame = endRect;
                             [emailTxF resignFirstResponder];
                         } completion:^(BOOL finished)
         {
             
         }];
    }];

}

-(void)setupSignInLayout{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    signInContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, screenBounds.size.height)];
    signInContainerView.backgroundColor = [UIColor clearColor];
    
    emailTxF                    = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 50)];
    emailTxF.backgroundColor    = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255.0/255.0];
    emailTxF.layer.cornerRadius = 3.0f;
    emailTxF.layer.borderWidth  = 1.0f;
    emailTxF.layer.borderColor  = [UIColor colorWithRed:233.0/255.0 green:224.0/255.0 blue:225.0/255.0 alpha:255.0/255.0].CGColor;
    emailTxF.textAlignment      = NSTextAlignmentCenter;
    emailTxF.textColor          = [UIColor colorWithRed:139.0/255.0 green:147.0/255.0 blue:153.0/255.0 alpha:255.0/255.0];
    emailTxF.placeholder        = @"E-mail";

    
    passTxF = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 280, 50)];
    passTxF.backgroundColor    = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255.0/255.0];
    passTxF.layer.cornerRadius = 3.0f;
    passTxF.layer.borderWidth  = 1.0f;
    passTxF.layer.borderColor  = [UIColor colorWithRed:233.0/255.0 green:224.0/255.0 blue:225.0/255.0 alpha:255.0/255.0].CGColor;
    passTxF.textAlignment      = NSTextAlignmentCenter;
    passTxF.textColor          = [UIColor colorWithRed:139.0/255.0 green:147.0/255.0 blue:153.0/255.0 alpha:255.0/255.0];
    passTxF.placeholder        = @"Password";
    passTxF.secureTextEntry    = YES;
    
    signInBtn                          = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBtn.frame                    = CGRectMake(20, 115, 280, 50);
    signInBtn.backgroundColor          = [UIColor colorWithRed:242.0/255.0 green:137.0/255.0 blue:87.0/255.0 alpha:255.0/255.0];
    signInBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    signInBtn.titleLabel.text          = @"Sign in";
    signInBtn.titleLabel.textColor     = [UIColor whiteColor];
    UIImageView *signInIco = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"signin_icon"]];
    [signInIco sizeToFit];
    signInIco.center = CGPointMake(signInBtn.center.x + signInBtn.frame.size.width/2 - 2*signInIco.frame.size.width,
                                   signInBtn.frame.size.height/2);
    [signInBtn addSubview:signInIco];
    [signInBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    
    gotoSignUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gotoSignUpBtn.frame = CGRectMake(0, 0, 320, 55);
    gotoSignUpBtn.backgroundColor = [UIColor clearColor];
    [gotoSignUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gotoSignUpBtn setTitle:@"New user? Sign up" forState:UIControlStateNormal];
    gotoSignUpBtn.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    gotoSignUpBtn.titleLabel.layer.shadowRadius = 1.0f;
    gotoSignUpBtn.titleLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    gotoSignUpBtn.center = CGPointMake(signInBtn.center.x, signInBtn.center.y + 150);
    [gotoSignUpBtn addTarget:self action:@selector(didTouchGoToSighUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [signInContainerView addSubview:emailTxF];
    [signInContainerView addSubview:passTxF];
    [signInContainerView addSubview:signInBtn];
    [signInContainerView addSubview:gotoSignUpBtn];
    
    
    signInContainerView.center = CGPointMake(screenBounds.size.width/2,
                                             logoView.center.y + logoView.frame.size.height/2 + signInContainerView.frame.size.height/2);
    signInContainerView.alpha = 0;
    
    [self.view addSubview:signInContainerView];
    
    [signInBtn addTarget:self action:@selector(touchSignIn:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)touchSignIn:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    NSString *email = emailTxF.text;
    NSString *password = passTxF.text;
    
    if (isEmpty(email))
    {
        [Utilities showAlertValidation: Alert_UsernameOrEmail_Empty textfield: emailTxF];
        return;
    }
    
    email = [email stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];

    if (!isEmailAvailable(email))
    {
        [Utilities showAlertValidation: Alert_EmailInvalid textfield: emailTxF];
        return;
    }
    
    if (isEmpty(password))
    {
        [Utilities showAlertValidation: Alert_Password_Empty textfield: passTxF];
        return;
    }
    
    password = [password stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    if (password.length < 6)
    {
        [Utilities showAlertValidation: Alert_PasswordLimit textfield: passTxF];
        return;
    }
    
    if (!isConnectNetwork())
    {
        [Utilities displayAlertNetworkError:^(UIAlertView *alertView, NSUInteger buttonIndex) {
        }];
        return;
    }
    
    showIndicator();
    
    // do login
    [[DataManager shareInstance] loginWithUsername: email
                                          password: password
                                         completed:^(id object, NSString *message) {
                                             hideIndicator();
                                             if (object)
                                             {
                                                 [Utilities showAlert:@"Login successful"];
                                                 passTxF.text = @"";
                                                 AccountObject *account = (AccountObject *)object;
                                                 [Utilities saveDataArchiver: [account toDictionary] forKey: kAccount];
                                             }
                                             else
                                             {
                                                 [Utilities showAlert: Alert_DataError];
                                             }
                                             
                                         } failed:^(NSString *error) {
                                             hideIndicator();
                                             [Utilities showAlert: error];
                                         }];
}

-(void)setupSignUpLayout{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    signUpContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, screenBounds.size.height)];
    signUpContainerView.backgroundColor = [UIColor clearColor];
    
    patientBtn                          = [UIButton buttonWithType:UIButtonTypeCustom];
    patientBtn.frame                    = CGRectMake(20, 10, 280, 50);
    patientBtn.backgroundColor          = [UIColor colorWithRed:242.0/255.0 green:137.0/255.0 blue:87.0/255.0 alpha:255.0/255.0];
    patientBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    patientBtn.titleLabel.textColor     = [UIColor whiteColor];
    [patientBtn setTitle:@"Sign up as a patient" forState:UIControlStateNormal];
    patientBtn.titleLabel.text          = @"Sign up as a patient";
    patientBtn.layer.cornerRadius = 3.0f;
    patientBtn.layer.borderWidth  = 1.0f;
    patientBtn.layer.borderColor  = [UIColor colorWithRed:242.0/255.0 green:137.0/255.0 blue:87.0/255.0 alpha:255.0/255.0].CGColor;

    doctorBtn                           = [UIButton buttonWithType:UIButtonTypeCustom];
    doctorBtn.frame                     = CGRectMake(20, 65, 280, 50);
    doctorBtn.backgroundColor           = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255.0/255.0];
    doctorBtn.titleLabel.textAlignment  = NSTextAlignmentCenter;
    doctorBtn.titleLabel.textColor      = [UIColor blackColor];
    [doctorBtn setTitle:@"Sign up as a doctor" forState:UIControlStateNormal];
    doctorBtn.titleLabel.text           = @"Sign up as a doctor";
    [doctorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    doctorBtn.layer.cornerRadius = 3.0f;
    doctorBtn.layer.borderWidth  = 1.0f;
    doctorBtn.layer.borderColor  = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255.0/255.0].CGColor;
    
    gotoSignInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gotoSignInBtn.frame = CGRectMake(0, 0, 320, 55);
    gotoSignInBtn.backgroundColor = [UIColor clearColor];
    [gotoSignInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gotoSignInBtn setTitle:@"Already an user? Sign in" forState:UIControlStateNormal];
    gotoSignInBtn.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    gotoSignInBtn.titleLabel.layer.shadowRadius = 1.0f;
    gotoSignInBtn.titleLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    gotoSignInBtn.center = gotoSignUpBtn.center;
    [gotoSignInBtn addTarget:self action:@selector(didTouchGoToSighIn:) forControlEvents:UIControlEventTouchUpInside];
    
    [signUpContainerView addSubview:patientBtn];
    [signUpContainerView addSubview:doctorBtn];
    [signUpContainerView addSubview:gotoSignInBtn];
    
    signUpContainerView.center = CGPointMake(signInContainerView.center.x + signInContainerView.frame.size.width/2, signInContainerView.center.y);
    signUpContainerView.alpha = 0;
    
    [self.view addSubview:signUpContainerView];
}


-(void)swipeLeft
{
    if(state == 1) return;
    DLog(@"Did swipe left");
    state = 1;
    CGRect beginRect = signInContainerView.frame;
    CGRect endRect = beginRect;
    endRect.origin.x -= signInContainerView.frame.size.width/2;
    signInContainerView.frame = beginRect;
    [UIView animateWithDuration:0.8
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0
                        options:0
                     animations:^{
                         signInContainerView.alpha = 0.0;
                         signInContainerView.frame = endRect;
                     } completion:^(BOOL finished)
     {
         
     }];
    
    beginRect = signUpContainerView.frame;
    endRect = beginRect;
    endRect.origin.x -= signUpContainerView.frame.size.width/2;
    signUpContainerView.frame = beginRect;
    [UIView animateWithDuration:0.8
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0
                        options:0
                     animations:^{
                         signUpContainerView.alpha = 1.0;
                         signUpContainerView.frame = endRect;
                     } completion:^(BOOL finished)
     {
         
     }];
}

-(void)swipeRight
{
    if(state == 0) return;
    DLog(@"Did swipe right");
    state = 0;
    CGRect beginRect = signInContainerView.frame;
    CGRect endRect = beginRect;
    endRect.origin.x += signInContainerView.frame.size.width/2;
    signInContainerView.frame = beginRect;
    [UIView animateWithDuration:0.8
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0
                        options:0
                     animations:^{
                         signInContainerView.alpha = 1.0;
                         signInContainerView.frame = endRect;
                     } completion:^(BOOL finished)
     {
         
     }];
    
    beginRect = signUpContainerView.frame;
    endRect = beginRect;
    endRect.origin.x += signUpContainerView.frame.size.width/2;
    signUpContainerView.frame = beginRect;
    [UIView animateWithDuration:0.8
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0
                        options:0
                     animations:^{
                         signUpContainerView.alpha = 0.0;
                         signUpContainerView.frame = endRect;
                     } completion:^(BOOL finished)
     {
         
     }];
}

-(void)didTouchGoToSighIn:(id)sender
{
    [self swipeRight];
}

-(void)didTouchGoToSighUp:(id)sender
{
    [self swipeLeft];
}


-(void)tapHideKeyBoard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
#pragma mark KeyboadNotification
-(void)keyboardDidShow:(NSNotification*)noti
{
    
}
-(void)keyboardWillBeHidden:(NSNotification*)noti
{
    
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
