//
//  AboutBuyersPick.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 27/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutBuyersPick : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *pView;
@property (strong, nonatomic) IBOutlet UIView *lView;
- (IBAction)back:(id)sender;
@end
