//
//  ViewController.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 12/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *signUpbgView;
@property (strong, nonatomic) IBOutlet UIButton *signInButton;
@property (strong, nonatomic) IBOutlet UIButton *createAccnt;
- (IBAction)signInButton:(id)sender;
- (IBAction)createAccnt:(id)sender;
@end
