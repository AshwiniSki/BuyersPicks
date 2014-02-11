//
//  GeoTagging.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 15/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeoTagging : UIViewController
@property (strong, nonatomic) IBOutlet UIView *MainBgView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
- (IBAction)closeButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *switchBgImage;
@property (strong, nonatomic) IBOutlet UISwitch *geoTagSwitch;
- (IBAction) geoTagSwitchTouched: (UISwitch *) sender;
@end
