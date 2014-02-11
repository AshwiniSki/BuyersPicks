//
//  AddContactDetails.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 03/02/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "AddContactDetails.h"
#import "BackgroundLayer.h"

@interface AddContactDetails ()

@end

@implementation AddContactDetails
@synthesize numOfEmailFlds,numOfWebsiteFlds,addAddress,addCity,addContactNo_Home,addContactNo_Mob,addContactNo_Work,addCountry,addEmail1Image,addEmail2Image,addEmailId0TxtView,addEmailId1TxtView,addEmailId2TxtView,addEmailIdBtn,addEmailImage,addFieldsImageView,addFieldsView,addState,addStreet1,addStreet2,addWebsite1Image,addWebsite1TxtView,addWebsite2Image,addWebsite2TxtView,addWebsiteBtn,addWebsiteImage,addWebsiteTxtView,websiteBgView,websiteLabel_popup;

@synthesize emailIdArray,contactNoArray,websiteArray;

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
    addFieldsView.layer.cornerRadius = 10.0;
    addFieldsView.clipsToBounds = YES;
    
       
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = addFieldsView.bounds;
    [addFieldsView.layer insertSublayer:bgLayer atIndex:0];
    
    
    addEmail1Image.alpha = 0.0;
    addEmail2Image.alpha = 0.0;
    addEmailId1TxtView.alpha = 0.0;
    addEmailId2TxtView.alpha = 0.0;
    addWebsite1Image.alpha = 0.0;
    addWebsite2Image.alpha = 0.0;
    addWebsite1TxtView.alpha = 0.0;
    addWebsite2TxtView.alpha = 0.0;
    
    numOfEmailFlds=0;
    numOfWebsiteFlds=0;
    
    
    UITapGestureRecognizer *webViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openCountries:)];
    webViewTapped.numberOfTapsRequired = 1;
    webViewTapped.delegate = self;
    [addCountry addGestureRecognizer:webViewTapped];
    
    [self LoadDataForVendorAddress];
}

-(void)LoadDataForVendorAddress
{
    GlobalClass     *obj = [GlobalClass getInstance];
    if ([appD.calledForUpdateAppD isEqualToString:@"calledForUpdate"]) {
        NSString   *fetchdata = [NSString stringWithFormat:@"select  *  from ba_tbl_vendor WHERE vendor_id=%@",obj.VenID];
        
        [self getDataFrom_ba_tbl_vendor:fetchdata];
        
      websiteArray=[ data3[0] componentsSeparatedByString:@","];
       emailIdArray=[ data4[0] componentsSeparatedByString:@","];
        contactNoArray=[ data6[0] componentsSeparatedByString:@","];
        
        NSLog(@"websiteArray =%d , %@",websiteArray.count,websiteArray);
        NSLog(@"emailIdArray =%d , %@",emailIdArray.count,emailIdArray);
        NSLog(@"contactNoArray =%d , %@",contactNoArray.count,contactNoArray);

        [self displayDataForUpdate];

    }
    else
    {
        NSLog(@"Create new address called");
    }
}

-(void)displayDataForUpdate
{
    addWebsiteTxtView.text=[websiteArray objectAtIndex:0];
    addWebsite1TxtView.text=[websiteArray objectAtIndex:1];
    addWebsite2TxtView.text=[websiteArray objectAtIndex:2];
    
    addEmailId0TxtView.text=[emailIdArray objectAtIndex:0];
    addEmailId1TxtView.text=[emailIdArray objectAtIndex:1];
    addEmailId2TxtView.text=[emailIdArray objectAtIndex:2];
    
    
    addContactNo_Mob.text=[contactNoArray objectAtIndex:0];
    addContactNo_Work.text=[contactNoArray objectAtIndex:1];
    addContactNo_Home.text=[contactNoArray objectAtIndex:2];
    
    addAddress.text =data5[0];
    addStreet1.text =data8[0];
    addStreet2.text =data9[0];
    addCity.text =data10[0];
    addState.text =data11[0];
    addCountry.text =data12[0];
}

-(void)editVendorDetails
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    

    [self performSelector:@selector(changeView) withObject:nil afterDelay:0.0];
    
    
}
-(void)viewWillLayoutSubviews
{
    [self performSelector:@selector(changeView) withObject:nil afterDelay:0.0];
    
}
-(void)changeView
{
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        addFieldsImageView.frame = CGRectMake(0, 0, 1024, 768);
        addFieldsView.frame = CGRectMake(208, 107, 608, 489);
    }
    else if(ori == UIInterfaceOrientationPortrait || ori == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        addFieldsImageView.frame = CGRectMake(0, 0, 768, 1024);
        addFieldsView.frame = CGRectMake(80, 235, 608, 489);
        
    }
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        
        addFieldsImageView.frame = CGRectMake(0, 0, 1024, 768);
        addFieldsView.frame = CGRectMake(208, 127, 608, 489);
        
        
        
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        addFieldsImageView.frame = CGRectMake(0, 0, 768, 1024);
        addFieldsView.frame = CGRectMake(80, 255, 608, 489);
    }

}
- (IBAction)addEmailIdBtn:(id)sender {
    numOfEmailFlds= numOfEmailFlds+1;
    if(numOfEmailFlds==1)
    {
        addEmail1Image.alpha = 1.0;
        addEmailId1TxtView.alpha = 1.0;
        websiteBgView.frame = CGRectMake(301, 217, 307, 111);
        
    }
    if(numOfEmailFlds==2)
    {
        addEmail2Image.alpha = 1.0;
        addEmailId2TxtView.alpha = 1.0;
        
        websiteBgView.frame = CGRectMake(301, 256, 307, 111);
        
    }
}

- (IBAction)addWebsiteBtn:(id)sender
{
    numOfWebsiteFlds= numOfWebsiteFlds+1;
    
    if(numOfWebsiteFlds==1)
    {
        addWebsite1Image.alpha = 1.0;
        addWebsite1TxtView.alpha = 1.0;
    }
    if(numOfWebsiteFlds==2)
    {
        addWebsite2Image.alpha = 1.0;
        addWebsite2TxtView.alpha = 1.0;
    }
    if (addEmail1Image.alpha==0.0) {
        websiteBgView.frame = CGRectMake(301, 178, 307, 111);
        
    }
    if (addEmail1Image.alpha==1.0)
    {
        if (addEmail2Image.alpha==0.0)
        {
            websiteBgView.frame = CGRectMake(301, 217, 307, 111);
        }
        else if(addEmail2Image.alpha==1.0)
        {
            websiteBgView.frame = CGRectMake(301, 256, 307, 111);
            
        }
        
    }
    
}

- (IBAction)saveBtn:(id)sender
{
    GlobalClass     *obj = [GlobalClass getInstance];
    

    
    NSString *webSiteStr=[NSString stringWithFormat:@"%@\n%@\n%@",addWebsiteTxtView.text,addWebsite1TxtView.text,addWebsite2TxtView.text];
    NSString *emailIDStr=[NSString stringWithFormat:@"%@\n%@\n%@",addEmailId0TxtView.text,addEmailId1TxtView.text,addEmailId2TxtView.text];
    NSString *contactNoStr=[NSString stringWithFormat:@"%@\n%@\n%@",addContactNo_Mob.text,addContactNo_Work.text,addContactNo_Home.text];
  
    //******************************************** For Updating DB ********************************************
    appD=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([appD.calledForUpdateAppD isEqualToString:@"calledForUpdate"]) {
//    NSString   *insertquery1 = [NSString stringWithFormat:@"SELECT * from  ba_tbl_vendor_master"];
//    [self displayAll:insertquery1];
        if (webSiteStr.length>0 || emailIDStr.length>0 || contactNoStr.length>0 || addAddress.text.length>0 || addStreet1.text.length>0 || addStreet2.text.length>0 || addCity.text.length>0 || addCountry.text.length>0 ) {
    
    NSString   *updateQuery = [NSString stringWithFormat:@"update  ba_tbl_vendor SET website=\"%@\" , email_id=\"%@\",  address=\"%@\",  contact_no=\"%@\" ,sync_status=\"%@\", street1 =\"%@\",  street2 =\"%@\", city =\"%@\", state =\"%@\", country =\"%@\" where vendor_id =\"%@\"" ,webSiteStr ,emailIDStr,addAddress.text,contactNoStr,@"0",addStreet1.text,addStreet2.text,addCity.text,addState.text,addCountry.text,obj.VenID ];
    [self saveData:updateQuery];
        }


    }
    //******************************************** For inserting into DB ********************************************
    
    else{
        int timestamp = [[NSDate date] timeIntervalSince1970];
 if (webSiteStr.length>0 || emailIDStr.length>0 || contactNoStr.length>0 || addAddress.text.length>0 || addStreet1.text.length>0 || addStreet2.text.length>0 || addCity.text.length>0 || addCountry.text.length>0 ) {
    NSString   *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_vendor (id, vendor_id ,  website ,  email_id , address , contact_no ,sync_status ,street1 , street2 ,city , state , country ) VALUES ( \"%d\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",timestamp,obj.VenID,webSiteStr ,emailIDStr,addAddress.text,contactNoStr,@"0",addStreet1.text,addStreet2.text,addCity.text,addState.text,addCountry.text ];
    
    NSLog(@"insertquery = %@ ",insertquery);
    [self saveData:insertquery];
 }

    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noteUpdateNotifier" object:nil];

        [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelBtn:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
