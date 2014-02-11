//
//  SecurePin.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 15/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"
#import "AppDelegate.h"

@interface SecurePin : DatabaseClass
{
    AppDelegate *appD;
    
}
@property (strong, nonatomic) NSString *pinLabel1Str;
@property (strong, nonatomic) NSString *pinLabel2Str;
@property (strong, nonatomic) NSString *pinLabel3Str;
@property (strong, nonatomic) NSString *pinLabel4Str;

@property (nonatomic) int pinSavingCounter;
@property (nonatomic) int pinTitleCounter;
@property (nonatomic) int pinLableCounter;
@property (nonatomic) int pinViewCounter;
@property (nonatomic, strong) NSString *pinCheck;
@property(nonatomic,strong)NSString *enterPinStr;
@property(nonatomic,strong)NSString *confirmPinStr;
@property(nonatomic,strong)NSString *enterOldPinStr;

@property (strong, nonatomic) IBOutlet UIView *MainBgView;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UIImageView *lockImage;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
- (IBAction)closeButton:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (strong, nonatomic) IBOutlet UIView *createSecurePINView;

@property (strong, nonatomic) IBOutlet UIView *changeAndRemoveBgView;

@property (strong, nonatomic) IBOutlet UIButton *changePinBtn;
- (IBAction)changePinBtn:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *removePinBtn;
- (IBAction)removePinBtn:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *pinTitle;
@property (strong, nonatomic) IBOutlet UILabel *pinLabel1;
@property (strong, nonatomic) IBOutlet UILabel *pinLabel2;
@property (strong, nonatomic) IBOutlet UILabel *pinLabel3;
@property (strong, nonatomic) IBOutlet UILabel *pinLabel4;
- (IBAction)keyboardBtnPressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *keyBoardView;


@end
