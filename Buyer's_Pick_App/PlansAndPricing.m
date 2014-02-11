//
//  PlansAndPricing.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 31/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "PlansAndPricing.h"
#import "SearchByTag.h"
#import "GlobalClass.h"

@interface PlansAndPricing ()

@end

@implementation PlansAndPricing
@synthesize lView,pView,cartLogo,headerTitle,closeButton,failedOrSuccessImage,sorryOrSuccessLabel,transInfo,retryBtn,viewForPlusPlan,viewForPremiunPlan,viewForStdPlan,individualPlanBtn,individualPlanView,corporatePlanBtn,corporatePlanView,adsLand,ads,viewForEnterprisePlan,viewForProCorporate;
@synthesize cartLogoLand,headerTitleLand,closeButtonLand,failedOrSuccessImageLand,sorryOrSuccessLabelLand,transInfoLand,retryBtnLand,viewForEnterprisePlanLand,viewForPlusPlanLand,viewForPremiunPlanLand,viewForProCorporateLand,viewForStdPlanLand,individualPlanBtnLand,individualPlanViewLand,corporatePlanBtnLand,corporatePlanViewLand,mainView,mainViewLand,backgroundImage,backgroundImageLand,landscapeScroller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *cameraImage = [UIImage imageNamed:@"camera_icon.png"];
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton setImage:cameraImage forState:UIControlStateNormal];
    cameraButton.frame = CGRectMake(0, 5, cameraImage.size.width, cameraImage.size.height);
    cameraButton.tag = 0;
    [cameraButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemCamera = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    
    UIImage *audioImage = [UIImage imageNamed:@"recording_icon.png"];
    UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [audioButton setImage:audioImage forState:UIControlStateNormal];
    audioButton.frame = CGRectMake(0, 5, audioImage.size.width, audioImage.size.height);
    audioButton.tag = 1;
    [audioButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemAudio = [[UIBarButtonItem alloc] initWithCustomView:audioButton];
    
    UIImage *noteImage = [UIImage imageNamed:@"note_icon.png"];
    UIButton *noteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noteButton setImage:noteImage forState:UIControlStateNormal];
    noteButton.frame = CGRectMake(0, 5, noteImage.size.width, noteImage.size.height);
    noteButton.tag = 2;
    [noteButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemNote = [[UIBarButtonItem alloc] initWithCustomView:noteButton];
    
    UIImage *searchBarImage = [UIImage imageNamed:@"searchbox.png"];
    searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 150, 30)];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    searchTextField.font = [UIFont systemFontOfSize:12];
    [searchTextField setBackground:searchBarImage];
    searchTextField.textColor = [UIColor whiteColor];
    searchTextField.backgroundColor = [UIColor clearColor];
    searchTextField.placeholder = @"SEARCH BY TAG";
    [searchTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    searchTextField.keyboardType = UIKeyboardTypeDefault;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    searchTextField.delegate = self;
    
    UIBarButtonItem *customBarItemSearch = [[UIBarButtonItem alloc] initWithCustomView:searchTextField];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemNote,customBarItemAudio,customBarItemCamera,customBarItemSearch,nil]];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"PLANS AND PRICING";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIImage *doneImage = [UIImage imageNamed:@"backHeader.png"];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setImage:doneImage forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(0, 3, 64, 37);
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemDone = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.leftBarButtonItem = customBarItemDone;
    
    UIImage *buyersImage = [UIImage imageNamed:@"buyerlogo.png"];
    UIImageView *navBarBuyersImage = [[UIImageView alloc]initWithImage:buyersImage];
    navBarBuyersImage.frame = CGRectMake(0, 2, buyersImage.size.width, buyersImage.size.height);
    UIBarButtonItem *customBarItemBuyersImage= [[UIBarButtonItem alloc] initWithCustomView:navBarBuyersImage];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:customBarItemDone, customBarItemBuyersImage,nil]];
    
    [viewForStdPlan.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [viewForStdPlan.layer setBorderWidth:3];
    [viewForPremiunPlan.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [viewForPremiunPlan.layer setBorderWidth:3];
    [viewForPlusPlan.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [viewForPlusPlan.layer setBorderWidth:3];
    [viewForProCorporate.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [viewForProCorporate.layer setBorderWidth:3];
    [viewForEnterprisePlan.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [viewForEnterprisePlan.layer setBorderWidth:3];

    [individualPlanBtn setBackgroundImage:[UIImage imageNamed:@"individual1.jpg"] forState:UIControlStateNormal];
    [corporatePlanBtn setBackgroundImage:[UIImage imageNamed:@"corporate.jpg"] forState:UIControlStateNormal];
    individualPlanView.alpha = 1.0;
    corporatePlanView.alpha = 0.0;
    
    
    [viewForStdPlanLand.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [viewForStdPlanLand.layer setBorderWidth:3];
    [viewForPremiunPlanLand.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [viewForPremiunPlanLand.layer setBorderWidth:3];
    [viewForPlusPlanLand.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [viewForPlusPlanLand.layer setBorderWidth:3];
    [viewForProCorporateLand.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [viewForProCorporateLand.layer setBorderWidth:3];
    [viewForEnterprisePlanLand.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [viewForEnterprisePlanLand.layer setBorderWidth:3];
    
    [individualPlanBtnLand setBackgroundImage:[UIImage imageNamed:@"individual1.jpg"] forState:UIControlStateNormal];
    [corporatePlanBtnLand setBackgroundImage:[UIImage imageNamed:@"corporate.jpg"] forState:UIControlStateNormal];
    individualPlanViewLand.alpha = 1.0;
    corporatePlanViewLand.alpha = 0.0;
    
    mainView.layer.cornerRadius = 10.0;
    mainView.clipsToBounds = YES;
    mainViewLand.layer.cornerRadius = 10.0;
    mainViewLand.clipsToBounds = YES;
    
    landscapeScroller.contentSize = CGSizeMake(landscapeScroller.frame.size.width, 1000);
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    adsLand.scrollView.bounces=NO;
    adsLand.opaque=NO;
    [adsLand loadHTMLString: [NSString stringWithFormat:@"<script type=\"text/javascript\" src=\"http://ad.leadboltads.net/show_app_ad.js?section_id=897295593\"></script>"] baseURL:nil];        //Load the request in the UIWebView.
    //[fbview loadRequest:requestObj];
    ads.scrollView.bounces=NO;
    ads.opaque=NO;
    [ads loadHTMLString: [NSString stringWithFormat:@"<script type=\"text/javascript\" src=\"http://ad.leadboltads.net/show_app_ad.js?section_id=897295593\"></script>"] baseURL:nil];        //Load the request in the UIWebView.
    //[fbview loadRequest:requestObj];
    
    
    GlobalClass     *obj = [GlobalClass getInstance];
    if([obj.IAPStatus isEqualToString:@"1"])
    {
        ads.alpha = 0.0;
        adsLand.alpha = 0.0;
    }

    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view = self.lView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view = self.pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
    }
    
}

-(void)done
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cameraClicked:(UIButton *)sender
{
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate  // iOS 6 autorotation fix
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6 autorotation fix
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation // iOS 6 autorotation fix
{
    return UIInterfaceOrientationPortrait;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        self.view = self.lView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view = self.pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(void)searchForTag:(UIButton *)sender
{
    SearchByTag *search =  [[SearchByTag alloc]initWithNibName:@"SearchByTag" bundle:nil];
    search.tagSearch = searchTextField.text;
    [self.navigationController pushViewController:search animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performSelector:@selector(searchForTag:) withObject:nil afterDelay:0.0];
    [textField resignFirstResponder];
    return YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButton:(id)sender
{
    mainViewLand.alpha = 0.0;
    mainView.alpha = 0.0;
    backgroundImageLand.alpha = 0.0;
    backgroundImage.alpha = 0.0;
    
}
- (IBAction)retryBtn:(id)sender
{
    
}
- (UIColor *) colorWithHexString: (NSString *) hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
	
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
    if ([cString length] != 6) return  [UIColor grayColor];
	
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
	
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
	
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
	
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
	
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
- (IBAction)individualPlanBtn:(id)sender
{
    [individualPlanBtn setBackgroundImage:[UIImage imageNamed:@"individual1.jpg"] forState:UIControlStateNormal];
    [corporatePlanBtn setBackgroundImage:[UIImage imageNamed:@"corporate.jpg"] forState:UIControlStateNormal];
    individualPlanView.alpha = 1.0;
    corporatePlanView.alpha = 0.0;
    
    [individualPlanBtnLand setBackgroundImage:[UIImage imageNamed:@"individual1.jpg"] forState:UIControlStateNormal];
    [corporatePlanBtnLand setBackgroundImage:[UIImage imageNamed:@"corporate.jpg"] forState:UIControlStateNormal];
    individualPlanViewLand.alpha = 1.0;
    corporatePlanViewLand.alpha = 0.0;
}
- (IBAction)corporatePlanBtn:(id)sender
{
    [individualPlanBtn setBackgroundImage:[UIImage imageNamed:@"individual.jpg"] forState:UIControlStateNormal];
    [corporatePlanBtn setBackgroundImage:[UIImage imageNamed:@"corporate1.jpg"] forState:UIControlStateNormal];
    individualPlanView.alpha = 0.0;
    corporatePlanView.alpha = 1.0;
    
    [individualPlanBtnLand setBackgroundImage:[UIImage imageNamed:@"individual.jpg"] forState:UIControlStateNormal];
    [corporatePlanBtnLand setBackgroundImage:[UIImage imageNamed:@"corporate1.jpg"] forState:UIControlStateNormal];
    individualPlanViewLand.alpha = 0.0;
    corporatePlanViewLand.alpha = 1.0;
}
@end
