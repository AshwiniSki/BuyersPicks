//
//  MyProfile.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 09/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"

@interface MyProfile : DatabaseClass<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate>
{
    UITextField *searchTextField;
}
@property (strong, nonatomic) IBOutlet UIImageView *grayLine;
@property (nonatomic,retain)UILabel *placeHolderTitle;
@property (strong, nonatomic) IBOutlet UIButton *syncButton;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UIButton *editProfileButton;
@property (strong, nonatomic) IBOutlet UIView *editProfileBgView;
@property (strong, nonatomic) IBOutlet UIImageView *firstnameBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *lastNameBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *dobBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *mobileNumBgImage;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *dobTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *mobNumTxtFld;
@property (strong, nonatomic) IBOutlet UIButton *updateProfileButton;
@property (strong, nonatomic) IBOutlet UILabel *useNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailIdLabel;
@property (strong, nonatomic) IBOutlet UIButton *changePasswordButton;
@property (strong, nonatomic) IBOutlet UIButton *memberAccessButton;
@property (strong, nonatomic) IBOutlet UIView *displayProfileBgView;
@property (strong, nonatomic) IBOutlet UIButton *genderButtonMale;
@property (strong, nonatomic) IBOutlet UIButton *genderButtonFemale;
@property (strong, nonatomic) IBOutlet UIButton *clickUserPicButton;
@property (nonatomic,strong)NSString* TAG;
@property (nonatomic)int INDEX;
@property (nonatomic) int cameraTag;
@property (nonatomic,retain) UIPopoverController *popover;
@property (strong, nonatomic) IBOutlet UIButton *editphotoBtn;
- (IBAction)editphotoBtn:(id)sender;

- (IBAction)clickUserPicButton:(id)sender;

- (IBAction)genderButtonMale:(UIButton *)sender;
- (IBAction)genderButtonFemale:(UIButton *)sender;
- (IBAction)editProfileButton:(UIButton *)sender;
- (IBAction)syncButton:(UIButton *)sender;
- (IBAction)updateProfileButton:(UIButton *)sender;
- (IBAction)changePasswordButton:(UIButton *)sender;
- (IBAction)memberAccessButton:(UIButton *)sender;
@end
