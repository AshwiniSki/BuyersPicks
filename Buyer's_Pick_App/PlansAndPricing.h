//
//  PlansAndPricing.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 31/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"

@interface PlansAndPricing : DatabaseClass<UITextFieldDelegate>
{
    UITextField *searchTextField;
}
@property (strong, nonatomic) IBOutlet UIView *pView;
@property (strong, nonatomic) IBOutlet UIView *lView;
@property (strong, nonatomic) IBOutlet UIImageView *cartLogo;
@property (strong, nonatomic) IBOutlet UILabel *headerTitle;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
- (IBAction)closeButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *failedOrSuccessImage;
@property (strong, nonatomic) IBOutlet UILabel *sorryOrSuccessLabel;
@property (strong, nonatomic) IBOutlet UILabel *transInfo;
@property (strong, nonatomic) IBOutlet UIButton *retryBtn;
- (IBAction)retryBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewForStdPlan;
@property (strong, nonatomic) IBOutlet UIView *viewForPremiunPlan;
@property (strong, nonatomic) IBOutlet UIView *viewForPlusPlan;
@property (strong, nonatomic) IBOutlet UIView *individualPlanView;
@property (strong, nonatomic) IBOutlet UIView *corporatePlanView;
@property (strong, nonatomic) IBOutlet UIView *viewForProCorporate;

@property (strong, nonatomic) IBOutlet UIView *viewForEnterprisePlan;

@property (strong, nonatomic) IBOutlet UIButton *individualPlanBtn;
- (IBAction)individualPlanBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *corporatePlanBtn;
- (IBAction)corporatePlanBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *adsLand;
@property (strong, nonatomic) IBOutlet UIWebView *ads;

@property (strong, nonatomic) IBOutlet UIImageView *cartLogoLand;
@property (strong, nonatomic) IBOutlet UILabel *headerTitleLand;
@property (strong, nonatomic) IBOutlet UIButton *closeButtonLand;

@property (strong, nonatomic) IBOutlet UIImageView *failedOrSuccessImageLand;
@property (strong, nonatomic) IBOutlet UILabel *sorryOrSuccessLabelLand;
@property (strong, nonatomic) IBOutlet UILabel *transInfoLand;
@property (strong, nonatomic) IBOutlet UIButton *retryBtnLand;
@property (strong, nonatomic) IBOutlet UIScrollView *landscapeScroller;

@property (strong, nonatomic) IBOutlet UIView *viewForStdPlanLand;
@property (strong, nonatomic) IBOutlet UIView *viewForPremiunPlanLand;
@property (strong, nonatomic) IBOutlet UIView *viewForPlusPlanLand;
@property (strong, nonatomic) IBOutlet UIView *individualPlanViewLand;
@property (strong, nonatomic) IBOutlet UIView *corporatePlanViewLand;
@property (strong, nonatomic) IBOutlet UIView *viewForProCorporateLand;

@property (strong, nonatomic) IBOutlet UIView *viewForEnterprisePlanLand;

@property (strong, nonatomic) IBOutlet UIButton *individualPlanBtnLand;

@property (strong, nonatomic) IBOutlet UIButton *corporatePlanBtnLand;

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UIView *mainViewLand;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageLand;
@end
