//
//  LockVendor.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 27/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"
#import "AppDelegate.h"
#import "OpenVendor.h"

@interface LockVendor : DatabaseClass
{
    AppDelegate *appD;
}

@property (nonatomic, strong) NSString *pinCheck;
@property(nonatomic,strong)NSString *enterPinStr;
@property (strong, nonatomic) NSString *pinLabel1Str;
@property (strong, nonatomic) NSString *pinLabel2Str;
@property (strong, nonatomic) NSString *pinLabel3Str;
@property (strong, nonatomic) NSString *pinLabel4Str;
@property (nonatomic) int pinLableCounter;

@property (strong, nonatomic) IBOutlet UIView *MainBgView;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UIImageView *lockImage;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
- (IBAction)closeButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (strong, nonatomic) IBOutlet UIView *enterSecurePINView;
@property (strong, nonatomic) IBOutlet UILabel *pinTitle;
@property (strong, nonatomic) IBOutlet UILabel *pinLabel1;
@property (strong, nonatomic) IBOutlet UILabel *pinLabel2;
@property (strong, nonatomic) IBOutlet UILabel *pinLabel3;
@property (strong, nonatomic) IBOutlet UILabel *pinLabel4;
- (IBAction)keyboardBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *keyBoardView;

@end
