//
//  MyAccount.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 06/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "MyAccount.h"
#import "CameraAudioVideoNote.h"
#import "MyProfile.h"
#import "TermsAndConditions.h"
#import "SecurePin.h"
#import "GeoTagging.h"
#import "SyncViewController.h"
#import "ContactUs.h"
#import "FAQViewController.h"
#import "AboutBuyersPick.h"
#import "SearchByTag.h"
#import "GlobalClass.h"

@interface MyAccount ()

@end

@implementation MyAccount
@synthesize placeHolderTitle,lView,pView,TAG,ads,adsLand;

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
    j=0;
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
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemNote, customBarItemAudio,customBarItemCamera,customBarItemSearch,nil]];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"MY ACCOUNT";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    
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
-(void)cameraClicked:(UIButton *)sender
{
    if(sender.tag == 2)
    {
        
    }
    else
    {
        CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
        openCamera.navTagFromHome = sender.tag;
        [self.navigationController pushViewController:openCamera animated:YES];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myProfile:(id)sender
{
    
    MyProfile *myProfile = [[MyProfile alloc]initWithNibName:@"MyProfile" bundle:nil];
    [self.navigationController pushViewController:myProfile animated:YES];
}

- (IBAction)myBilling:(id)sender {
}

- (IBAction)planAndPricing:(id)sender
{
    PlansAndPricing *plansAndPricing = [[PlansAndPricing alloc]initWithNibName:@"PlansAndPricing" bundle:nil];
    [self.navigationController pushViewController:plansAndPricing animated:YES];
}

- (IBAction)sync:(id)sender
{
    [self serversync];
    //    [self  performSelector:@selector(vendorcontactsync) withObject:nil afterDelay:0.0];
    
    SyncViewController *sync = [[SyncViewController alloc]initWithNibName:@"SyncViewController" bundle:nil];
    sync.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:sync animated:YES completion:nil];
    
    
}

- (IBAction)securePin:(id)sender
{
    SecurePin *securePin = [[SecurePin alloc]initWithNibName:@"SecurePin" bundle:nil];
    securePin.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:securePin animated:YES completion:nil];
}

- (IBAction)geoTagging:(id)sender
{
    GeoTagging *geoTagging = [[GeoTagging alloc]initWithNibName:@"GeoTagging" bundle:nil];
    geoTagging.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:geoTagging animated:YES completion:nil];
}

- (IBAction)Faq:(id)sender
{
    FAQViewController *faqView = [[FAQViewController alloc]initWithNibName:@"FAQViewController" bundle:nil];
    [self.navigationController pushViewController:faqView animated:YES];
}

- (IBAction)termsAndConditions:(id)sender
{
    TermsAndConditions *terms= [[TermsAndConditions alloc]initWithNibName:@"TermsAndConditions" bundle:nil];
    [self.navigationController pushViewController:terms animated:YES];
}

- (IBAction)reportProb:(id)sender
{
    ContactUs *contactUs = [[ContactUs alloc]initWithNibName:@"ContactUs" bundle:nil];
    contactUs.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:contactUs animated:YES completion:nil];
}

- (IBAction)shared:(id)sender {
}

- (IBAction)myTag:(id)sender {
}

- (IBAction)myIndustries:(id)sender {
}

- (IBAction)aboutApp:(id)sender
{
    AboutBuyersPick *about = [[AboutBuyersPick alloc]initWithNibName:@"AboutBuyersPick" bundle:nil];
    [self.navigationController pushViewController:about animated:YES];
}

-(void)synccontent
{
    //    checktag=3;
    NSString *insertSQL1 = [NSString stringWithFormat:@"select count(id) from ba_tbl_content"];
    
    
    
    [self displayAll:insertSQL1];
    
    
    
    if ([MobileNo isEqualToString:@"0"]) {
        
    }
    
    
    
    else
    {
        
        
        NSString *insertSQL1 = [NSString stringWithFormat:@"select * from ba_tbl_content"];
        
        
        
        [self getDataFrom_ba_tbl_content:insertSQL1];
        
        NSLog(@"TotalData for syn content  =%d",TotalData);
        for (int i =0; i<TotalData; i++) {
            
            
            if ([data16[i] isEqualToString:@"0"]) {
                
                
                NSString *post = [NSString stringWithFormat:@"email=dasfas"];
                
                
                
                NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                
                [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/fileupload"]]];
                [request setHTTPMethod:@"POST"];
                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
                [request setHTTPBody:postData];
                
                NSURLResponse *response;
                NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
                NSString *stringResponse = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
                NSLog(@"response1=%@",stringResponse);
                
                
                NSError* error;
                NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:urlData //1
                                                                             options:kNilOptions
                                                                               error:&error];
                NSString   *str;
                for (NSDictionary *actoAgent in responseDict)
                {
                    str= [actoAgent objectForKey:@"response"];
                    NSLog(@"res=%@",str);
                    
                }
                
                NSURL *audiourl = [NSURL URLWithString:str];
                ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:audiourl];
                NSData *postData1 = [NSData dataWithContentsOfFile:data14[i] options: 0 error:&error];
                
                if ([data15[i] isEqualToString:@"image"]) {
                    
                    NSLog(@"postData=%@",postData1);
                    
                    NSString    *nameofupload= [NSString stringWithFormat:@"image_%@.png",data10[i]];
                    NSLog(@"nameofupload b4 = *********************** %@ \n",nameofupload);
                    [request1 addData:postData1 withFileName:nameofupload andContentType:@"image/png" forKey:@"uploaded_files"];
                    NSLog(@"nameofupload after = *********************** %@ \n",nameofupload);
                }
                
                
                if ([data15[i] isEqualToString:@"video"]) {
                    
                    //                    NSLog(@"postData=%@",postData1);
                    
                    NSString    *nameofupload= [NSString stringWithFormat:@"video_%@.mp4",data10[i]];
                    [request1 addData:postData1 withFileName:nameofupload andContentType:@"video/mp4" forKey:@"uploaded_files"];
                }
                
                
                if ([data15[i] isEqualToString:@"audio"]) {
                    
                    //                    NSLog(@"postData=%@",postData1);
                    
                    NSString    *nameofupload= [NSString stringWithFormat:@"audio_%@.mp3",data10[i]];
                    [request1 addData:postData1 withFileName:nameofupload andContentType:@"audio/mp3" forKey:@"uploaded_files"];
                }
                
                
                //                if ([data15[i] isEqualToString:@"text"]) {
                //
                //                    //                    NSLog(@"postData=%@",postData1);
                //
                //                    NSString    *nameofupload= [NSString stringWithFormat:@"text%@.mp4",data10[i]];
                //                    [request1 addData:postData1 withFileName:nameofupload andContentType:@"audio/mp3" forKey:@"uploaded_files"];
                //                }
                //
                
                
                NSLog(@"sync=%@",data16[i]);
                
                
                
                [request1 addPostValue:data1[i] forKey:@"id"];
                [request1 addPostValue:data2[i] forKey:@"content_name"];
                [request1 addPostValue:data3[i] forKey:@"vendor_id"];
                [request1 addPostValue:data4[i] forKey:@"industry_id"];
                [request1 addPostValue:data5[i] forKey:@"tags"];
                [request1 addPostValue:data6[i] forKey:@"title"];
                [request1 addPostValue:data7[i] forKey:@"content_size"];
                [request1 addPostValue:data8[i] forKey:@"description"];
                [request1 addPostValue:data9[i] forKey:@"website"];
                [request1 addPostValue:data10[i] forKey:@"created_date"];
                [request1 addPostValue:data11[i] forKey:@"update_date"];
                [request1 addPostValue:data12[i] forKey:@"is_deleted"];
                [request1 addPostValue:data13[i] forKey:@"delete_date"];
                [request1 addPostValue:data14[i] forKey:@"path"];
                [request1 addPostValue:data15[i] forKey:@"type"];
                [request1 addPostValue:data16[i] forKey:@"sync_status"];
                [request1 addPostValue:data17[i] forKey:@"cloud_path"];
                
                
                
                
                
                
                
                [request1 setDelegate:self];
                
                [request1 startAsynchronous];
                
                k=k++;
                
                //  [request1 startSynchronous];
                
            }
            
            
            
            else
            {
            }
            
            
        }
        
    }
    
    
    
}

-(void)vendorcontactsync
{
    //    checktag=2;
    NSLog(@"vendorcontactsynccalled");
    
    k=0;
    NSString *insertSQL1 = [NSString stringWithFormat:@"select count(id) from ba_tbl_vendor"];
    
    
    
    [self displayAll:insertSQL1];
    
    
    
    if ([MobileNo isEqualToString:@"0"]) {
        
    }
    
    
    
    else
    {
        
        
        NSString *insertSQL1 = [NSString stringWithFormat:@"select * from ba_tbl_vendor"];
        
        
        
        [self getDataFrom_ba_tbl_vendor:insertSQL1];
        
        for (int i =0; i<TotalData; i++) {
            //            checktag=2;
            
            NSLog(@"VNAME=%@",data2[i]);
            
            NSURL *audiourl = [NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/savevendorcontact"]];
            
            ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:audiourl];
            NSLog(@"sync=%@",data7[i]);
            
            if ([data7[i] isEqualToString:@"0"]) {
                
                
                [request1 addPostValue:data1[i] forKey:@"id"];
                [request1 addPostValue:data2[i] forKey:@"vendor_id"];
                [request1 addPostValue:data3[i] forKey:@"website"];
                [request1 addPostValue:data4[i] forKey:@"email_id"];
                [request1 addPostValue:data5[i] forKey:@"address"];
                [request1 addPostValue:data6[i] forKey:@"contact_no"];
                [request1 addPostValue:data7[i] forKey:@"sync_status"];
                [request1 addPostValue:data8[i] forKey:@"security_pin"];
                [request1 addPostValue:data9[i] forKey:@"street1"];
                [request1 addPostValue:data10[i] forKey:@"street2"];
                [request1 addPostValue:data11[i] forKey:@"city"];
                [request1 addPostValue:data12[i] forKey:@"state"];
                [request1 addPostValue:data13[i] forKey:@"country"];
                
                
                
                
                
                
                [request1 setDelegate:self];
                
                [request1 startAsynchronous];
                //                [request1 startSynchronous];
                
                k=k++;
                
            }
            
            
            
            else
            {
            }
            
            
        }
        
    }
    
    
}
-(void)serversync
{
    checktag=1;
    k=0;
    NSString *insertSQL1 = [NSString stringWithFormat:@"select count(id) from ba_tbl_vendor_master"];
    
    
    
    [self displayAll:insertSQL1];
    
    
    
    if ([MobileNo isEqualToString:@"0"]) {
        
    }
    
    
    
    else
    {
        
        
        NSString *insertSQL1 = [NSString stringWithFormat:@"select * from ba_tbl_vendor_master"];
        
        
        
        [self getDataFrom_ba_tbl_vendor_master:insertSQL1];
        
        for (int i =0; i<TotalData; i++) {
            checktag=1;
            
            NSLog(@"VNAME=%@",data2[i]);
            
            NSURL *audiourl = [NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/savevendor"]];
            
            ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:audiourl];
            NSLog(@"sync=%@",data19[i]);
            
            if ([data19[i] isEqualToString:@"0"]) {
                
                
                [request1 addPostValue:data1[i] forKey:@"id"];
                [request1 addPostValue:data2[i] forKey:@"vendor_name"];
                [request1 addPostValue:data3[i] forKey:@"user_id"];
                [request1 addPostValue:data4[i] forKey:@"vendor_title"];
                [request1 addPostValue:data5[i] forKey:@"tags"];
                [request1 addPostValue:data6[i] forKey:@"created_date"];
                [request1 addPostValue:data7[i] forKey:@"description"];
                [request1 addPostValue:data8[i] forKey:@"security_pin"];
                [request1 addPostValue:data9[i] forKey:@"old_security_pin"];
                [request1 addPostValue:data10[i] forKey:@"last_modified_security_pin"];
                [request1 addPostValue:data11[i] forKey:@"geo_latitude"];
                [request1 addPostValue:data12[i] forKey:@"geo_longitude"];
                [request1 addPostValue:data13[i] forKey:@"last_modified_date"];
                [request1 addPostValue:data14[i] forKey:@"is_deleted"];
                [request1 addPostValue:data15[i] forKey:@"delete_date"];
                [request1 addPostValue:data16[i] forKey:@"industry_id"];
                [request1 addPostValue:data17[i] forKey:@"current_location"];
                [request1 addPostValue:data18[i] forKey:@"path"];
                [request1 addPostValue:data19[i] forKey:@"sync_status"];
                
                
                
                
                
                [request1 setDelegate:self];
                
                [request1 startAsynchronous];
                k=k++;
            }
            
            
            
            else
            {
                
                
                //                [self vendorcontactsync];
                //                checktag=2;
            }
            
            
        }
        
    }
    
    
    
    ////////////////////////////content
    
    //    NSString *insertSQL2 = [NSString stringWithFormat:@"select count(id) from ba_tbl_content"];
    //
    //
    //
    //    [self displayAll:insertSQL1];
    //
    //
    //
    //    if ([MobileNo isEqualToString:@"0"]) {
    //
    //    }
    //
    //
    //
    //    else
    //    {
    //
    //
    //        NSString *insertSQL1 = [NSString stringWithFormat:@"select * from ba_tbl_content"];
    //
    //
    //
    //        [self getDataFrom_ba_tbl_content:insertSQL1];
    //
    //        for (int i =0; i<TotalContentData; i++) {
    //
    //        }
    //
    //
    //    }
    
    
}



#pragma mark Async Hit to Server

- (void)requestFinished:(ASIHTTPRequest *)request {
	
	NSString *receivedString = [request responseString];
    NSLog(@"requestFinished=%@",receivedString);
    
    
    NSData *data = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //    NSDictionary *industry = [responseDict objectForKey:@"industry"];
    
    
    if (checktag==1) {
        j=j++;
        NSLog(@"checktag=1111111111111111111111111111");
        
        
        
        for (NSDictionary *actoAgent in responseDict){
            NSString   *insertquery = [NSString stringWithFormat:@"update  ba_tbl_vendor_master SET id =\"%@\" , sync_status = \"%@\" where id =\"%@\"" ,[actoAgent objectForKey:@"id"],[actoAgent objectForKey:@"sync_status"],[actoAgent objectForKey:@"old_id"] ];
            [self saveData:insertquery];
            
            
            
            NSString   *insertquery1 = [NSString stringWithFormat:@"update  ba_tbl_content SET vendor_id =\"%@\"  where vendor_id =\"%@\"" ,[actoAgent objectForKey:@"id"],[actoAgent objectForKey:@"old_id"] ];
            [self saveData:insertquery1];
            
            NSString   *insertquery2 = [NSString stringWithFormat:@"update  ba_tbl_vendor SET vendor_id =\"%@\"  where vendor_id =\"%@\"" ,[actoAgent objectForKey:@"id"],[actoAgent objectForKey:@"old_id"] ];
            [self saveData:insertquery2];
            
            if (j==k) {
                checktag = 2;
                j=0;
                k=0;
                NSLog(@"reachedatend");
                [self vendorcontactsync];
            }
            
            
        }
        
    }
    
    if (checktag==2) {
        
        j=j++;
        
        NSLog(@"checktag=22222222222222222222222");
        for (NSDictionary *actoAgent in responseDict){
            
            
            
            
            NSString   *insertquery1 = [NSString stringWithFormat:@"update  ba_tbl_vendor SET id =\"%@\" , sync_status = \"%@\" where id =\"%@\"" ,[actoAgent objectForKey:@"id"],[actoAgent objectForKey:@"sync_status"],[actoAgent objectForKey:@"old_id"] ];
            [self saveData:insertquery1];
            
            
            if (j==k) {
                checktag = 3;
                j=0;
                k=0;
                [self synccontent];
            }
            
        }
        
    }
    
    
    if (checktag==3) {
        
        j=j++;
        
        NSLog(@"checktag=3333333333333333");
        for (NSDictionary *actoAgent in responseDict){
            
            
            
            
            NSString   *insertquery1 = [NSString stringWithFormat:@"update  ba_tbl_content SET id =\"%@\" , sync_status = \"%@\" where id =\"%@\"" ,[actoAgent objectForKey:@"id"],[actoAgent objectForKey:@"sync_status"],[actoAgent objectForKey:@"old_id"] ];
            [self saveData:insertquery1];
            
            
            if (j==k) {
                checktag = 3;
                j=0;
                k=0;
            }
            
        }
        
    }
    
    
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	
	NSString *receivedString = [request responseString];
    NSLog(@"requestFailed=%@",receivedString);
    
    
}



@end
