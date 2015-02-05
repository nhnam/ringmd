//
//  PatientSignUpViewController.m
//  RingMD
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "PatientSignUpViewController.h"
#import "Define.h"
#import "GeneralFunctions.h"
#import "Utilities.h"
#import "AccountObject.h"
#import "DataManager.h"

#import <QuartzCore/QuartzCore.h>


@interface PatientSignUpViewController ()<UIScrollViewDelegate, UITextFieldDelegate>
{
    UIScrollView *mainScrollView;
    UITextField *nameTxF;
    UITextField *emailTxF;
    UITextField *passTxF;
    UITextField *phoneTxF;
    UITextField *activeField;
    
    UIButton *signUpBtn;
    
    UITapGestureRecognizer * tapGesture;
}

@end

@implementation PatientSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Patient Registration";
    
    [self setupContainer];
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

-(void)setupContainer
{
    DLog(@"ViewController size: %f, %f", WIDTH_MSCREEN, HEIGHT_MSCREEN);
    mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.frame = CGRectMake(0, 30, 320, self.view.frame.size.height - 60);
    CGPoint p = mainScrollView.center;
    p.x = self.view.center.x;
    mainScrollView.center = p;
    mainScrollView.clipsToBounds = YES;
    mainScrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:mainScrollView];
    
    nameTxF = [[UITextField alloc] initWithFrame:CGRectMake(40, 20, 240, 48)];
    UIView *nameBg = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 310, 48)];
    nameBg.backgroundColor    = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255.0/255.0];
    nameBg.layer.cornerRadius = 3.0f;
//    nameBg.layer.borderWidth  = 1.0f;
//    nameBg.layer.borderColor  = [UIColor colorWithRed:233.0/255.0 green:224.0/255.0 blue:225.0/255.0 alpha:255.0/255.0].CGColor;
    nameTxF.backgroundColor = [UIColor clearColor];
    nameTxF.textAlignment      = NSTextAlignmentLeft;
    nameTxF.textColor          = [UIColor blackColor];
    nameTxF.delegate = self;
    nameTxF.placeholder        = @"Username";
    [mainScrollView addSubview:nameBg];
    
    passTxF = [[UITextField alloc] initWithFrame:CGRectMake(40, 70, 240, 48)];
    UIView *passBg = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 310, 48)];
    passBg.backgroundColor    = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255.0/255.0];
    passBg.layer.cornerRadius = 3.0f;
//    passBg.layer.borderWidth  = 1.0f;
//    passBg.layer.borderColor  = [UIColor colorWithRed:233.0/255.0 green:224.0/255.0 blue:225.0/255.0 alpha:255.0/255.0].CGColor;
    passTxF.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:passBg];
    
    passTxF.textAlignment      = NSTextAlignmentLeft;
    passTxF.textColor          = [UIColor blackColor];
    passTxF.placeholder        = @"Password";
    passTxF.delegate = self;
    passTxF.secureTextEntry    = YES;
    
    emailTxF = [[UITextField alloc] initWithFrame:CGRectMake(40, 120, 240, 48)];
    UIView *emailBg = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 310, 48)];
    emailBg.backgroundColor    = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255.0/255.0];
    emailBg.layer.cornerRadius = 3.0f;
//    emailBg.layer.borderWidth  = 1.0f;
//    emailBg.layer.borderColor  = [UIColor colorWithRed:233.0/255.0 green:224.0/255.0 blue:225.0/255.0 alpha:255.0/255.0].CGColor;
    emailTxF.backgroundColor = [UIColor clearColor];
    emailTxF.textAlignment      = NSTextAlignmentLeft;
    emailTxF.textColor          = [UIColor blackColor];
    emailTxF.delegate = self;
    emailTxF.placeholder        = @"E-mail";
    [mainScrollView addSubview:emailBg];
//
    phoneTxF = [[UITextField alloc] initWithFrame:CGRectMake(40, 170, 240, 48)];
    UIView *phoneBg = [[UIView alloc] initWithFrame:CGRectMake(0, 170, 310, 48)];
    phoneBg.backgroundColor    = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255.0/255.0];
    phoneBg.layer.cornerRadius = 3.0f;
//    phoneBg.layer.borderWidth  = 1.0f;
//    phoneBg.layer.borderColor  = [UIColor colorWithRed:233.0/255.0 green:224.0/255.0 blue:225.0/255.0 alpha:255.0/255.0].CGColor;
    phoneTxF.backgroundColor = [UIColor clearColor];
    phoneTxF.textAlignment      = NSTextAlignmentLeft;
    phoneTxF.textColor          = [UIColor blackColor];
    phoneTxF.delegate = self;
    phoneTxF.placeholder        = @"Phone number";
    [mainScrollView addSubview:phoneBg];
    
    signUpBtn                          = [UIButton buttonWithType:UIButtonTypeCustom];
    signUpBtn.frame                    = CGRectMake(0, 240, 310, 50);
    signUpBtn.backgroundColor          = [UIColor colorWithRed:242.0/255.0 green:137.0/255.0 blue:87.0/255.0 alpha:255.0/255.0];
    signUpBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    signUpBtn.titleLabel.text          = @"Sign up";
    signUpBtn.titleLabel.textColor     = [UIColor whiteColor];
    UIImageView *signInIco = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go_icon"]];
    [signInIco sizeToFit];
    signInIco.center = CGPointMake(signUpBtn.center.x + signUpBtn.frame.size.width/2 - signInIco.frame.size.width*2,
                                   signUpBtn.frame.size.height/2);
    [signUpBtn addSubview:signInIco];
    [signUpBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    [signUpBtn addTarget:self action:@selector(didTouchSignUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [mainScrollView addSubview:nameTxF];
    [mainScrollView addSubview:passTxF];
    [mainScrollView addSubview:emailTxF];
    [mainScrollView addSubview:phoneTxF];
    [mainScrollView addSubview:signUpBtn];
    
    UIImageView *userIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username_icon"]];
    [userIconView sizeToFit];
    userIconView.center = CGPointMake(nameTxF.center.x - nameTxF.frame.size.width/2 - nameTxF.frame.size.height/2 , nameTxF.center.y);
    [mainScrollView addSubview:userIconView];
    
    UIImageView *passIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_icon"]];
    [passIconView sizeToFit];
    passIconView.center = CGPointMake(passTxF.center.x - passTxF.frame.size.width/2 - passTxF.frame.size.height/2 , passTxF.center.y);
    [mainScrollView addSubview:passIconView];
    
    UIImageView *emailIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emain_icon"]];
    [emailIconView sizeToFit];
    emailIconView.center = CGPointMake(emailTxF.center.x - emailTxF.frame.size.width/2 - emailTxF.frame.size.height/2 , emailTxF.center.y);
    [mainScrollView addSubview:emailIconView];
    
    UIImageView *phoneIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_icon"]];
    [phoneIconView sizeToFit];
    phoneIconView.center = CGPointMake(phoneTxF.center.x - phoneTxF.frame.size.width/2 - phoneTxF.frame.size.height/2 , phoneTxF.center.y);
    [mainScrollView addSubview:phoneIconView];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapHideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
}

-(void)didTapHideKeyBoard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [mainScrollView scrollRectToVisible:CGRectZero animated:YES];
    activeField = nil;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    [mainScrollView scrollRectToVisible:textField.frame animated:YES];
}


-(void)didTouchSignUp:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    NSString *email    = emailTxF.text;
    NSString *password = passTxF.text;
    NSString *username = nameTxF.text;
    NSString *phone    = phoneTxF.text;
    
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
    
    // do sign up
    [[DataManager shareInstance] registerWithUsername:username password:password phonenumber:phone phoneArea:@"+84" email:email completed:^(id object, NSString *message)
    {
        hideIndicator();
        if (object)
        {
            [Utilities showAlert:@"Sign up successful"];
            passTxF.text = @"";
            AccountObject *account = (AccountObject *)object;
            [Utilities saveDataArchiver: [account toDictionary] forKey: kAccount];
            [self dismissViewControllerAnimated:YES completion:nil];
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
