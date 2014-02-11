//
//  AddContactDetails.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 03/02/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"
#import "DataFwdClass.h"
#import "GlobalClass.h"
#import "AppDelegate.h"

@interface AddContactDetails : DatabaseClass<UIGestureRecognizerDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    AppDelegate *appD;
}

@property (nonatomic, retain) NSArray * emailIdArray;
@property (nonatomic, retain) NSArray * contactNoArray;
@property (nonatomic, retain) NSArray * websiteArray;

@property (nonatomic)int numOfEmailFlds;
@property (nonatomic)int numOfWebsiteFlds;
@property (strong, nonatomic) IBOutlet UIImageView *addFieldsImageView;
@property (strong, nonatomic) IBOutlet UIView *addFieldsView;
@property (strong, nonatomic) IBOutlet UITextView *addAddress;
@property (strong, nonatomic) IBOutlet UITextView *addStreet1;
@property (strong, nonatomic) IBOutlet UITextView *addStreet2;
@property (strong, nonatomic) IBOutlet UITextView *addCity;
@property (strong, nonatomic) IBOutlet UITextView *addState;
@property (strong, nonatomic) IBOutlet UILabel *addCountry;
@property (strong, nonatomic) IBOutlet UITextView *addContactNo_Mob;
@property (strong, nonatomic) IBOutlet UITextView *addContactNo_Work;
@property (strong, nonatomic) IBOutlet UITextView *addContactNo_Home;
@property (strong, nonatomic) IBOutlet UIButton *addEmailIdBtn;
@property (strong, nonatomic) IBOutlet UIImageView *addEmailImage;
@property (strong, nonatomic) IBOutlet UITextView *addEmailId0TxtView;
@property (strong, nonatomic) IBOutlet UIImageView *addEmail1Image;
@property (strong, nonatomic) IBOutlet UITextView *addEmailId1TxtView;
@property (strong, nonatomic) IBOutlet UIImageView *addEmail2Image;
@property (strong, nonatomic) IBOutlet UITextView *addEmailId2TxtView;
@property (strong, nonatomic) IBOutlet UIImageView *addWebsiteImage;
@property (strong, nonatomic) IBOutlet UITextView *addWebsiteTxtView;
@property (strong, nonatomic) IBOutlet UITextView *addWebsite1TxtView;
@property (strong, nonatomic) IBOutlet UITextView *addWebsite2TxtView;
@property (strong, nonatomic) IBOutlet UIImageView *addWebsite1Image;
@property (strong, nonatomic) IBOutlet UIImageView *addWebsite2Image;
@property (strong, nonatomic) IBOutlet UILabel *websiteLabel_popup;
@property (strong, nonatomic) IBOutlet UIButton *addWebsiteBtn;
@property (strong, nonatomic) IBOutlet UIView *websiteBgView;
- (IBAction)addEmailIdBtn:(id)sender;
- (IBAction)addWebsiteBtn:(id)sender;

- (IBAction)saveBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;

@end
