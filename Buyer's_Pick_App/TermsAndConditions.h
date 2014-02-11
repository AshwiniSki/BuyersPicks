//
//  TermsAndConditions.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 10/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.


#import <UIKit/UIKit.h>

@interface TermsAndConditions : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    NSString  *description;
   
    UITextField *searchTextField;
}
@property (strong, nonatomic) IBOutlet UITextView *termsLabel;
@property (strong, nonatomic) IBOutlet UITextView *termsLabelLand;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView		*activityIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView		*activityIndicatorLand;
@property (strong, nonatomic) IBOutlet UIView *pView;
@property (strong, nonatomic) IBOutlet UIView *lView;

@property (nonatomic,retain)UILabel *placeHolderTitle;
@property (nonatomic,strong)NSString* TAG;
- (IBAction)backButton:(id)sender;
@end
