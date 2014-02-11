//
//  SyncViewController.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 15/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyncViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *MainBgView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
- (IBAction)closeButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *wifiSwitchBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *mobileDataSwitchBgImage;
@property (strong, nonatomic) IBOutlet UISwitch *wifiSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *mobileDataSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *dropboxSwitch;
- (IBAction) SwitchTouched: (UISwitch *) sender;
@end
