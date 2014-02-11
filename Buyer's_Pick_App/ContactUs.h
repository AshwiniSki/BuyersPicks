//
//  ContactUs.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 17/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUs : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
- (IBAction)closeBtn:(id)sender;
- (IBAction)emailUsBtn:(id)sender;
- (IBAction)writeReviewBtn:(id)sender;
- (IBAction)spreadWordBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@end
