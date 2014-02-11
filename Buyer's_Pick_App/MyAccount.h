//
//  MyAccount.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 06/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"
#import "PlansAndPricing.h"
@interface MyAccount : DatabaseClass<UITextFieldDelegate,UIWebViewDelegate>
{
    UITextField *searchTextField;
    int checktag;
    int j;
    int k;
}
@property (nonatomic,retain)UILabel *placeHolderTitle;
@property (strong, nonatomic) IBOutlet UIView *pView;
@property (strong, nonatomic) IBOutlet UIView *lView;
@property (strong, nonatomic) IBOutlet UIButton *myProfile;
@property (nonatomic)int cameraTag;
@property (nonatomic,strong)NSString* TAG;
- (IBAction)myProfile:(id)sender;
- (IBAction)myBilling:(id)sender;
- (IBAction)planAndPricing:(id)sender;
- (IBAction)sync:(id)sender;
- (IBAction)securePin:(id)sender;
- (IBAction)geoTagging:(id)sender;
- (IBAction)Faq:(id)sender;
- (IBAction)termsAndConditions:(id)sender;
- (IBAction)reportProb:(id)sender;
- (IBAction)shared:(id)sender;
- (IBAction)myTag:(id)sender;
- (IBAction)myIndustries:(id)sender;
- (IBAction)aboutApp:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *adsLand;
@property (strong, nonatomic) IBOutlet UIWebView *ads;

@end
