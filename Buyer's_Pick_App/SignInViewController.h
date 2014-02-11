//
//  SignInViewController.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 03/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"

@interface SignInViewController : DatabaseClass<UIAlertViewDelegate,UITextFieldDelegate>
{
    bool			stricterFilter;
       NSString        *v_key;
  
}
@property (strong, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *emailIdTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *signInButton;
@property (strong, nonatomic) IBOutlet UITextField *Forgetpwd ;
@property (strong, nonatomic) IBOutlet UIButton *closePopUpButton;
- (IBAction)closePopUpButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *forgetPswdBgView;
@property (strong, nonatomic) IBOutlet UIImageView *forgetPswdBgImage;
@property (strong, nonatomic) IBOutlet UIView *signUpbgView;
@property (strong, nonatomic) IBOutlet UIView *popUpview;
@property (strong, nonatomic) IBOutlet UILabel *resendOrForgotLabel;
@property (strong, nonatomic) IBOutlet UIImageView *keyImage;
@property (strong, nonatomic) IBOutlet UILabel *noteLabel;
@property (strong, nonatomic) IBOutlet UIImageView *textFldBgImage;
@property(nonatomic,strong) UISwipeGestureRecognizer *swipeRight;
@property(nonatomic,strong) UISwipeGestureRecognizer *swipeLeft;

- (IBAction)signInButton:(id)sender;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)resendActivationEmail:(id)sender;
@end
