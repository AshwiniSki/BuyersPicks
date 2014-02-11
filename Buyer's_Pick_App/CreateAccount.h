//
//  CreateAccount.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 03/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"
#import "GlobalClass.h"
@interface CreateAccount : DatabaseClass<UIAlertViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    bool			stricterFilter;
    NSString        *v_key;
    

}
@property (strong, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backButton:(id)sender;
@property(nonatomic,strong) UISwipeGestureRecognizer *swipeRight;
@property(nonatomic,strong) UISwipeGestureRecognizer *swipeLeft;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *emailId;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property (strong, nonatomic) IBOutlet UIButton *sendActivationBtn;
@property (strong, nonatomic) IBOutlet UIView *signUpbgView;
- (IBAction)sendActivationBtn:(id)sender;
@end
