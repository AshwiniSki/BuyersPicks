//
//  HomeViewController.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 12/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import "HomeViewController.h"
#import "CameraAudioVideoNote.h"
#import "AddNote.h"
#import "ListViewCell.h"
#import "GlobalClass.h"
#import "ViewController.h"
#import "OpenVendor.h"
#import "ASIFormDataRequest.h"
#import "SearchByTag.h"
#import "OpenVendor.h"
#import "LockVendor.h"
#import "AppDelegate.h"
#import "Reachability.h"

@interface HomeViewController ()
@end
@implementation HomeViewController
@synthesize navBarButtonsIndex,lView,pView,listView,gridView,sortByDate,shareButton,syncButton,allVendorsButton,vendorScroller,totalVendors,placeHolderTitle,tableViewBgImage,sortingTable,sortedArray,INDEX,deleteVendorButton,shareVendorButton,listViewTable,createNEwVendorButton,createNewVendorLabel,createVendorBgView,listAndGridIndex,deleteItems,ads,adsLand;

@synthesize listViewLand,gridViewLand,sortByDateLand,shareButtonLand,allVendorsButtonLand,syncButtonLand,vendorScrollerLand,tableViewBgImageLand,sortingTableLand,deleteVendorButtonLand,shareVendorButtonLand,createNEwVendorButtonLand,createNewVendorLabelLand,createVendorBgViewLand,offEditModeBtn,offEditModeBtnLand,sortedVendorsByDate,sortedVendorsByTitle,refreshBtn,refreshBtnLand;

@synthesize pinCheck,pinCheckUser;// Anish
@synthesize masterPopoverController = _masterPopoverController;
@synthesize OverlayIndex,OverlaybtnLand,Overlaybtn;

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
    
    OverlayIndex = 0;
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self fetchIndustryData];
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
             GlobalClass     *obj = [GlobalClass getInstance];
            if([obj.CHECK_NETWORK isEqualToString:@"1"])
            {
            UIAlertView* logoutalertbox = [[ UIAlertView alloc]initWithTitle:@"Alert" message:@"Network Not Reachable" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Retry", nil ];
            logoutalertbox.delegate=self;
            [logoutalertbox show];
            }
            obj.CHECK_NETWORK = @"0";
        });
    };
    
    [reach startNotifier];

    
    
    deleteItems = [[NSMutableArray alloc]init];
    
    sortedVendorsByTitle = [[NSMutableArray alloc]init];
    sortedVendorsByDate = [[NSMutableArray alloc]init];

    NSString *uid = [[NSUserDefaults standardUserDefaults] stringForKey:@"userID"];
    NSString *insertSQL11 = [NSString stringWithFormat:@"select active from ba_tbl_user where id = %@ ",uid];
    
    [self displayAll:insertSQL11];
    
    
    if ([MobileNo isEqualToString:@"1"])
    {
        
        
        
    }
    else
    {
        
        
        ViewController *loginViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, Description from ba_tbl_vendor_master"];
    [self displayContentData:fetchdata];

    totalVendors=TotalData;

    listAndGridIndex = 2;
    
    GlobalClass *obj=[GlobalClass getInstance];
    if([obj.CHECK_CATALOG isEqualToString:@"1"])
    {
        if(OverlayIndex == 0)
        {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            
            Overlaybtn = [UIButton buttonWithType:UIButtonTypeCustom];
            OverlaybtnLand = [UIButton buttonWithType:UIButtonTypeCustom];

            NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
            int currSysVerInInt = [currSysVer intValue];
            if(currSysVerInInt >= 7)
            {
                Overlaybtn.frame=CGRectMake(0, 0,  768, 1024);
                OverlaybtnLand.frame=CGRectMake(0, 0,  1024, 768);
            }
            else if(currSysVerInInt < 7)
            {
                Overlaybtn.frame=CGRectMake(0, 0,  768, 1004);
                OverlaybtnLand.frame=CGRectMake(0, 0,  1024, 748);
            }

           
            [Overlaybtn setBackgroundImage:[UIImage imageNamed:@"overlay1.jpg"] forState:UIControlStateNormal];
            [Overlaybtn addTarget:self action:@selector(overlayclicked) forControlEvents:UIControlEventTouchUpInside];
            [self.pView addSubview:Overlaybtn];
            
            
            [OverlaybtnLand setBackgroundImage:[UIImage imageNamed:@"overlay1Land.jpg"] forState:UIControlStateNormal];
            [OverlaybtnLand addTarget:self action:@selector(overlayclicked) forControlEvents:UIControlEventTouchUpInside];
            [self.lView addSubview:OverlaybtnLand];
            OverlayIndex=1;
        }
    }

    
    sortedArray = [[NSArray alloc]initWithObjects:@"Default View",@"Vendor Created",@"Vendor Modified",@"A to Z",@"Z to A", nil];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    INDEX=0;
    NSLog(@"INDEX 1 = %d",INDEX);

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
    titleLabel.text = @"ALL VENDORS";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    tableViewBgImageLand.layer.cornerRadius = 10.0;
    tableViewBgImageLand.clipsToBounds = YES;
    tableViewBgImage.layer.cornerRadius = 10.0;
    tableViewBgImage.clipsToBounds = YES;
    
    [tableViewBgImage.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [tableViewBgImage.layer setBorderWidth:0.5];
    [tableViewBgImageLand.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [tableViewBgImageLand.layer setBorderWidth:0.5];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterIntoOpenVendor) name:@"enterIntoOpenVendor" object:nil]; // Anish

    
    
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
    
    searchTextField.text = @"";
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performSelector:@selector(searchForTag:) withObject:nil afterDelay:0.0];
    [textField resignFirstResponder];
    return YES;
    
}

-(void)openLeftView:(UIButton *)sender
{
  
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    sortingTableLand.frame = CGRectMake(861, 43, 137, 170);
    sortingTable.frame = CGRectMake(616, 43, 137, 170);
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, Description from ba_tbl_vendor_master"];
    [self displayContentData:fetchdata];
     
    totalVendors=TotalData;
   [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];
    
    INDEX = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected option"];
    NSLog(@"INDEX = %d",INDEX);
    
    adsLand.scrollView.bounces=NO;
    adsLand.opaque=NO;
    [adsLand loadHTMLString: [NSString stringWithFormat:@"<script type=\"text/javascript\" src=\"http://ad.leadboltads.net/show_app_ad.js?section_id=897295593\"></script>"] baseURL:nil];
    
    //Load the request in the UIWebView.
    ads.scrollView.bounces=NO;
    ads.opaque=NO;
    [ads loadHTMLString: [NSString stringWithFormat:@"<script type=\"text/javascript\" src=\"http://ad.leadboltads.net/show_app_ad.js?section_id=897295593\"></script>"] baseURL:nil];        //Load the request in the UIWebView.
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
    dispatch_async(dispatch_get_main_queue()	, ^{
        [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];
    });
    
    
    [self tablereloaddata];
    
    
}

-(void)tablereloaddata
{
    
    INDEX = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected option"];
    NSLog(@"INDEX = %d",INDEX);
    [sortingTable reloadData];
    [sortingTableLand reloadData];
}

-(void)DisplayVendors
{
    NSLog(@"listAndGridIndex = %d",listAndGridIndex);
    [sortedVendorsByDate removeAllObjects];
    [sortedVendorsByTitle removeAllObjects];
    
    [[vendorScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[vendorScrollerLand subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, vendor_title, created_date from ba_tbl_vendor_master"];
    [self displayAllVendorsInDB:fetchdata];
    

    
//    for (int j = 0; j<totalVendors; j++)
//    {
//        [sortedVendorsByDate addObject:datadate[j]];
//        [sortedVendorsByTitle addObject:datatitle[j]];
//    }
//    NSLog(@"sortedVendorsByTitle=%@",sortedVendorsByTitle);
//
//    NSLog(@"sortedVendorsByDate=%@",sortedVendorsByDate);
//    todayDate = [NSDate date]; 
//    [sortedVendorsByTitle sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
//    
//    NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
//    NSArray *descriptors=[NSArray arrayWithObject: descriptor];
//    sortedVendorsByDate=[sortedVendorsByDate sortedArrayUsingComparator:descriptors];
// 
//    NSLog(@"sortedVendorsByTitle=%@",sortedVendorsByTitle);
//    
//    
//    NSLog(@"sortedVendorsByDate=%@",sortedVendorsByDate);
    
    int m = 0;
    int nXX = 0;
    int nYY = 0;
    if (listAndGridIndex==1)
    {
        int mX = 7;
        int mY = 0;
        
        int nX = 7;
        int nY = 0;
        
        NSLog(@"totalvendore = %d",totalVendors);
        for (int i =0; i<totalVendors; i++)
        {
            mX=248*(i%3);
            mY=237 * (i/3);
            
            nX=248*(i%4);
            nY=237 * (i/4);
            
             NSLog(@"vendoridDB[i]=%@",vendoridDB[i]);
            NSString   *fetchdata1 = [NSString stringWithFormat:@"select id, path, type from ba_tbl_content where vendor_id=%@",vendoridDB[i]];
            NSLog(@"fetchdata=%@",fetchdata1);
            [self displayImageForVendor:fetchdata1];
            
        
            vendorImage[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImage[i].frame = CGRectMake(mX+7, mY, 238, 227);
            vendorImage[i].userInteractionEnabled = YES;
            [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [vendorImage[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImage[i].tag = i;
            [vendorScroller addSubview:vendorImage[i]];
          // if(imageIdForVendor[i]==)
            imageOnVendorGrid[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 23, 218, 173)];
            if ([imageTypeForVendor[i] isEqualToString:@"image"])
            {
                imageOnVendorGrid[i].image = [UIImage imageWithContentsOfFile:imageForVendor[0]];
            }
            [vendorImage[i] addSubview:imageOnVendorGrid[i]];
            
            vendorDetailsForGrid[i] = [[UILabel alloc]initWithFrame:CGRectMake(10, 196, 218, 20)];
            vendorDetailsForGrid[i].backgroundColor = [UIColor whiteColor];
            vendorDetailsForGrid[i].text =datatype[i];
            vendorDetailsForGrid[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDetailsForGrid[i].font = [UIFont systemFontOfSize:12.0];
            vendorDetailsForGrid[i].textColor = [UIColor grayColor];
            [vendorImage[i] addSubview:vendorDetailsForGrid[i]];

            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPress.delegate = self;
            [vendorImage[i] addGestureRecognizer:longPress];
            
            tickmarkButtonGrid[i] = [[UIButton alloc]initWithFrame:CGRectMake(0,0,238,227)];
            tickmarkButtonGrid[i].userInteractionEnabled = NO;
            tickmarkButtonGrid[i].alpha = 0.0;
            tickmarkButtonGrid[i].tag = i;
            [tickmarkButtonGrid[i] setBackgroundImage:nil forState:UIControlStateNormal];
            [vendorImage[i] addSubview:tickmarkButtonGrid[i]];
            
            
            mX=mX+248;
            mY=mY+237;
            
            
            
            vendorImageLand[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImageLand[i].frame = CGRectMake(nX+7, nY, 238, 227);
            vendorImageLand[i].userInteractionEnabled = YES;
            [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImageLand[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImageLand[i].tag = i;
            [vendorScrollerLand addSubview:vendorImageLand[i]];
            
            imageOnVendorGrid[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 23, 218, 173)];
            if ([datatype[i] isEqualToString:@"image"])
            {
                imageOnVendorGrid[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            }
            [vendorImageLand[i] addSubview:imageOnVendorGrid[i]];
            
            
            vendorDetailsForGridLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(10, 196, 218, 20)];
            vendorDetailsForGridLand[i].backgroundColor = [UIColor whiteColor];
            vendorDetailsForGridLand[i].text =datatype[i];
            vendorDetailsForGridLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDetailsForGridLand[i].font = [UIFont systemFontOfSize:12.0];
            vendorDetailsForGridLand[i].textColor = [UIColor grayColor];
            [vendorImageLand[i] addSubview:vendorDetailsForGridLand[i]];

            
            
            UILongPressGestureRecognizer *longPressLand = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPressLand.delegate = self;
            [vendorImageLand[i] addGestureRecognizer:longPressLand];
            
            tickmarkButtonGridLand[i] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 238, 227)];
            tickmarkButtonGridLand[i].userInteractionEnabled = NO;
            tickmarkButtonGridLand[i].alpha = 0.0;
            tickmarkButtonGridLand[i].tag = i;
            [tickmarkButtonGridLand[i] setBackgroundImage:nil forState:UIControlStateNormal];
            [vendorImageLand[i] addSubview:tickmarkButtonGridLand[i]];
            
            
            nX=nX+248;
            nY=nY+237;
            
            
            
        }
        if(totalVendors%3==0)
        {
            
            vendorScroller.contentSize = CGSizeMake(748,237*(totalVendors/3)+337);
        }
        else
        {
            vendorScroller.contentSize = CGSizeMake(748,237*(totalVendors/3)+337);
            
        }
        
        if(totalVendors%4==0)
        {
            
            vendorScrollerLand.contentSize = CGSizeMake(1006,237*totalVendors/4+150);
        }
        else
        {
            vendorScrollerLand.contentSize = CGSizeMake(1006,(237*totalVendors/4)+150);
            
        }
        
    }
    if (listAndGridIndex==2)
    {
        for (int i =0; i<totalVendors; i++)
        {
            viewForList[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m, 748, 115)];
            viewForList[i].backgroundColor = [UIColor clearColor];
            [vendorScroller addSubview:viewForList[i]];
            
            vendorImage[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImage[i].frame = CGRectMake(10, 2, 100, 100);
            vendorImage[i].userInteractionEnabled = YES;
            [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImage[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImage[i].tag = i;
            [viewForList[i] addSubview:vendorImage[i]];
            
//            imageOnVendorList[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 100, 90)];
//            imageOnVendorList[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
//            [vendorImage[i] addSubview:imageOnVendorList[i]];
            
            vendorTitle[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 35, 200, 20)];
            vendorTitle[i].backgroundColor = [UIColor clearColor];
            vendorTitle[i].text = datatitle[i];
            vendorTitle[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorTitle[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorTitle[i].textColor = [UIColor darkGrayColor];
            [viewForList[i] addSubview:vendorTitle[i]];
            
            vendorName[i] = [[UILabel alloc]initWithFrame:CGRectMake(330, 35, 200, 20)];
            vendorName[i].backgroundColor = [UIColor clearColor];
            vendorName[i].text = datapath[i];
            vendorName[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorName[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorName[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:vendorName[i]];
            
            vendorDate[i] = [[UILabel alloc]initWithFrame:CGRectMake(530, 35, 200, 20)];
            vendorDate[i].backgroundColor = [UIColor clearColor];
            vendorDate[i].text = datadate[i];
            vendorDate[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDate[i].font = [UIFont boldSystemFontOfSize:13.0];
            vendorDate[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:vendorDate[i]];
            
            
            vendorDetails[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 60, 200, 30)];
            vendorDetails[i].backgroundColor = [UIColor clearColor];
            vendorDetails[i].text =datatype[i];
            vendorDetails[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDetails[i].font = [UIFont systemFontOfSize:12.0];
            vendorDetails[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:vendorDetails[i]];
            
            
            
            lineImage[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110, 748, 1)];
            lineImage[i].backgroundColor = [UIColor grayColor];
            [viewForList[i] addSubview:lineImage[i]];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPress.delegate = self;
            [vendorImage[i] addGestureRecognizer:longPress];
            
            tickmarkButtonlist[i] = [[UIButton alloc]initWithFrame:CGRectMake(0,0,100,100)];
            tickmarkButtonlist[i].userInteractionEnabled = NO;
            tickmarkButtonlist[i].alpha = 0.0;
            tickmarkButtonlist[i].tag = i;
            [tickmarkButtonlist[i] setBackgroundImage:nil forState:UIControlStateNormal];
            [viewForList[i] addSubview:tickmarkButtonlist[i]];
            
            m=m+115;
            
            nXX=503*(i%2);
            nYY=115 * (i/2);
            
            
            viewForListLand[i] = [[UIView alloc]initWithFrame:CGRectMake(nXX, nYY, 503, 115)];
            viewForListLand[i].backgroundColor = [UIColor clearColor];
            [vendorScrollerLand addSubview:viewForListLand[i]];
            
            vendorImageLand[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImageLand[i].frame = CGRectMake(10, 2, 100, 100);
            vendorImageLand[i].userInteractionEnabled = YES;
            [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImageLand[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImageLand[i].tag = i;
            [viewForListLand[i] addSubview:vendorImageLand[i]];
            
//            imageOnVendorList[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 100, 90)];
//            imageOnVendorList[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
//            [vendorImageLand[i] addSubview:imageOnVendorList[i]];
            
            vendorTitleLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 35, 200, 20)];
            vendorTitleLand[i].backgroundColor = [UIColor clearColor];
            vendorTitleLand[i].text = datatitle[i];
            vendorTitleLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorTitleLand[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorTitleLand[i].textColor = [UIColor darkGrayColor];
            [viewForListLand[i] addSubview:vendorTitleLand[i]];
            
            vendorNameLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(330, 35, 200, 20)];
            vendorNameLand[i].backgroundColor = [UIColor clearColor];
            vendorNameLand[i].text = datapath[i];
            vendorNameLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorNameLand[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorNameLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:vendorNameLand[i]];
            
            vendorDateLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(330, 60, 200, 20)];
            vendorDateLand[i].backgroundColor = [UIColor clearColor];
            vendorDateLand[i].text = datadate[i];
            vendorDateLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDateLand[i].font = [UIFont boldSystemFontOfSize:13.0];
            vendorDateLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:vendorDateLand[i]];
            
            vendorDetailsLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 60, 200, 30)];
            vendorDetailsLand[i].backgroundColor = [UIColor clearColor];
            vendorDetailsLand[i].text = datatype[i];
            vendorDetailsLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDetailsLand[i].font = [UIFont systemFontOfSize:12.0];
            vendorDetailsLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:vendorDetailsLand[i]];
            
            
            
            lineImageLand[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, nYY+115, 1006, 1)];
            lineImageLand[i].backgroundColor = [UIColor grayColor];
            [vendorScrollerLand addSubview:lineImageLand[i]];
            
            UILongPressGestureRecognizer *longPressLand = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPressLand.delegate = self;
            [vendorImageLand[i] addGestureRecognizer:longPressLand];
            
            tickmarkButtonlistLand[i] = [[UIButton alloc]initWithFrame:CGRectMake(0,0,100,100)];
            tickmarkButtonlistLand[i].userInteractionEnabled = NO;
            tickmarkButtonlistLand[i].alpha = 0.0;
            tickmarkButtonlistLand[i].tag = i;
            [tickmarkButtonlistLand[i] setBackgroundImage:nil forState:UIControlStateNormal];
            [viewForListLand[i] addSubview:tickmarkButtonlistLand[i]];
            
            nXX=nXX+503;
            nYY=nYY+115;
            
        }
        vendorScroller.contentSize = CGSizeMake(748, 115*totalVendors+100);
        
        if(totalVendors%2==0)
        {
            vendorScrollerLand.contentSize = CGSizeMake(1006, 115*(totalVendors/2)+100);
        }
        else
        {
             vendorScrollerLand.contentSize = CGSizeMake(1006, 115*(totalVendors/2)+200);
        }
        
    }
    
   
}

- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    if ( gesture.state == UIGestureRecognizerStateBegan ) {
        NSLog(@"Long Press");
        deleteVendorButton.alpha = 1.0;
        syncButton.alpha = 1.0;
        syncButtonLand.alpha = 1.0;
        shareVendorButton.alpha = 1.0;
        deleteVendorButtonLand.alpha = 1.0;
        shareVendorButtonLand.alpha = 1.0;
         offEditModeBtn.alpha = 1.0;
        offEditModeBtnLand.alpha = 1.0;
        syncButton.alpha = 1.0;
        syncButtonLand.alpha = 1.0;
        sortingTable.hidden = YES;
        sortingTableLand.hidden = YES;
        //TEST
        for (int i =0; i<totalVendors; i++)
        {
            
            tickmarkButtonlist[i].alpha = 1.0;
            tickmarkButtonlist[i].userInteractionEnabled = YES;
            [tickmarkButtonlist[i] addTarget:self action:@selector(tickmarkClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            tickmarkButtonlistLand[i].alpha = 1.0;
            tickmarkButtonlistLand[i].userInteractionEnabled = YES;
            [tickmarkButtonlistLand[i] addTarget:self action:@selector(tickmarkClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            tickmarkButtonGrid[i].alpha = 1.0;
            tickmarkButtonGrid[i].userInteractionEnabled = YES;
            [tickmarkButtonGrid[i] addTarget:self action:@selector(tickmarkClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            tickmarkButtonGridLand[i].alpha = 1.0;
            tickmarkButtonGridLand[i].userInteractionEnabled = YES;
            [tickmarkButtonGridLand[i] addTarget:self action:@selector(tickmarkClicked:) forControlEvents:UIControlEventTouchUpInside];

            

            [tickmarkButtonlist[gesture.view.tag] setBackgroundImage:[UIImage imageNamed:@"100_100.png"] forState:UIControlStateNormal];
            [tickmarkButtonlistLand[gesture.view.tag] setBackgroundImage:[UIImage imageNamed:@"100_100.png"] forState:UIControlStateNormal];
            [tickmarkButtonGrid[gesture.view.tag] setBackgroundImage:[UIImage imageNamed:@"238_227.png"] forState:UIControlStateNormal];
            [tickmarkButtonGridLand[gesture.view.tag] setBackgroundImage:[UIImage imageNamed:@"238_227.png"] forState:UIControlStateNormal];
            
        }

    }
    
    [deleteItems addObject:[NSString stringWithFormat:@"%@",dataid[gesture.view.tag]]];

}
-(void)tickmarkClicked:(UIButton *)sender
{
    NSLog(@"inside tickmarkClicked ");
//    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website  from ba_tbl_vendor_master WHERE id=%d",[sender tag]+1];
//    [self displaySelctedVendor:fetchdata];
    if([tickmarkButtonlist[sender.tag] backgroundImageForState:UIControlStateNormal] == [UIImage imageNamed:@" "]||[tickmarkButtonlistLand[sender.tag] backgroundImageForState:UIControlStateNormal] == [UIImage imageNamed:@" "])
    {
        [deleteItems addObject:[NSString stringWithFormat:@"%@",dataid[sender.tag]]];
        
        [tickmarkButtonlist[sender.tag] setBackgroundImage:[UIImage imageNamed:@"100_100.png"] forState:UIControlStateNormal];
        [tickmarkButtonlistLand[sender.tag] setBackgroundImage:[UIImage imageNamed:@"100_100.png"] forState:UIControlStateNormal];
        [tickmarkButtonGrid[sender.tag] setBackgroundImage:[UIImage imageNamed:@"238_227.png"] forState:UIControlStateNormal];
        [tickmarkButtonGridLand[sender.tag] setBackgroundImage:[UIImage imageNamed:@"238_227.png"] forState:UIControlStateNormal];
    }
    else //if([tickmarkButton[sender.tag] backgroundImageForState:UIControlStateNormal] == [UIImage imageNamed:@"check.png"]||[tickmarkButtonLand[sender.tag] backgroundImageForState:UIControlStateNormal] == [UIImage imageNamed:@"check.png"])
    {
        [deleteItems removeObject:[NSString stringWithFormat:@"%@",dataid[sender.tag]]];
        
        [tickmarkButtonlist[sender.tag] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonlistLand[sender.tag] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonGrid[sender.tag] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonGridLand[sender.tag] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];

    }
    self.view.userInteractionEnabled = YES;
}
- (IBAction)deleteVendorButton:(id)sender {
  [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    NSLog(@"aa=%@",deleteItems);
    for (int i = 0; i<[deleteItems count]; i++) {
        
        NSString *delete = [NSString stringWithFormat:@"delete from ba_tbl_vendor_master where id = %@",[deleteItems objectAtIndex:i]];
        [self saveData:delete];
        
    }
    [deleteItems removeAllObjects];
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, Description from ba_tbl_vendor_master"];
    [self displayContentData:fetchdata];
    
    totalVendors=TotalData;

    [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];

}
-(void)checkSecurePIN:(int)sender // Anish ***********************************************
{
    NSLog(@"sender =%@",vendoridDB[0]);
    // NSString *i = [[NSString stringWithFormat:@"%d",sender]];
    NSString   *fetchdata = [NSString stringWithFormat:@"select security_pin from ba_tbl_vendor_master where id=%@",vendoridDB[0]];  //sender
    NSLog(@"moo=%@",MobileNo);
    
    [self displayAll:fetchdata];
    pinCheck=[NSString stringWithFormat:@"%@",MobileNo];
    NSLog(@"pinCheck1Vendor = %@",pinCheck);
}




-(void)checkSecurePINuser // Anish ***********************************************
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] stringForKey:@"userID"];

    NSString   *fetchdata = [NSString stringWithFormat:@"select security_pin from ba_tbl_user where id=%@",uid];
    [self displayAll:fetchdata];
    pinCheckUser=MobileNo;
    NSLog(@"checkSecurePINuser = %@",pinCheckUser);
    
    
}

-(void)openAddNote:(UIButton *)sender
{
    
    NSString   *fetchdata1 = [NSString stringWithFormat:@"select id , vendor_name, Description, vendor_title, created_date from ba_tbl_vendor_master"];
    [self displayAllVendorsInDB:fetchdata1];

    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, vendor_title, tags, id, id, vendor_title  from ba_tbl_vendor_master WHERE id=%@",dataid[sender.tag]];
    NSLog(@"openAddNote=%@",fetchdata);
    [self displaySelctedVendor:fetchdata];
    
    
    [self checkSecurePIN:sender.tag]; // Anish * ********************************************
    [self checkSecurePINuser];
    
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
       
//    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website  from ba_tbl_vendor_master WHERE id=%@",dataid[sender.tag]];
//    [self displaySelctedVendor:fetchdata];
    
    
    NSLog(@"pinCheck1Vendor in openAddNote =%@",pinCheck);
    NSLog(@"pinCheckUser in openAddNote =%@",pinCheckUser);
    
    if ([pinCheckUser isEqualToString:@"0"]) {
        //******************* 1st
        NSLog(@"pinCheck1Vendor in 1st =%@",pinCheck);
        NSLog(@"pinCheckUser in 1st =%@",pinCheckUser);
        [self enterIntoOpenVendor];
    }
    else
    {
        
        if ([pinCheck isEqualToString:@"0"])     // Anish ***
        {
            
            //******************* 2nd
            NSLog(@"pinCheck1Vendor in 2nd =%@",pinCheck);
            NSLog(@"pinCheckUser in 2nd =%@",pinCheckUser);
            
            senderTag=sender.tag;
            [self enterIntoOpenVendor];
            
        }
        else
        {
            
            //******************* 3rd
            NSLog(@"pinCheck1Vendor in 3rd =%@",pinCheck);
            NSLog(@"pinCheckUser in 3rd =%@",pinCheckUser);
            appD=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            appD.PinCheckvendorid=vendoridDB[0];
            appD.lockVendorTag=@"1";
            LockVendor *lockVendor = [[LockVendor alloc]initWithNibName:@"LockVendor" bundle:nil];
            lockVendor.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
            [self presentViewController:lockVendor animated:YES completion:nil];
        }
    }
    
    NSLog(@"finished presenting lockVendor");

    
}

-(void)enterIntoOpenVendor  // Anish ***********************************************
{
    
    
    
    OpenVendor *openVendor = [[OpenVendor alloc]initWithNibName:@"OpenVendor" bundle:nil];
    openVendor.vendorTitle=vendornameDB[0];
    openVendor.vendorDesciption=vendordescDB[0];
    openVendor.vendorWebsite=vendorContactnoDB[0];
    openVendor.vendorid=vendoridDB[0];
    appD=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appD.lockVendorTag=@"1";
    
    [self.navigationController pushViewController:openVendor animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return sortedArray.count;
  
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 1;
  }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
   
        static NSString *CellIdentifier = @"sorting by date1";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell1 == nil) {
            
            cell1=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }

       cell1.textLabel.textColor = [UIColor grayColor];
    cell1.textLabel.font = [UIFont systemFontOfSize:12];
    cell1.textLabel.text=[sortedArray objectAtIndex:indexPath.row];
    NSLog(@"cellForRowAtIndexPath");

    [cell1 setSelected:YES];

    if ([[sortedArray objectAtIndex:indexPath.row] isEqualToString:[NSString stringWithFormat:@"%@",[sortedArray objectAtIndex:INDEX]]])
    {
        [cell1 setAccessoryType:UITableViewCellAccessoryCheckmark];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        [cell1 setAccessoryType:UITableViewCellAccessoryNone];
         cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
        return cell1;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSUserDefaults *setUserDefaults=[NSUserDefaults standardUserDefaults];
   // [setUserDefaults setObject:[sortedArray objectAtIndex:indexPath.row] forKey:@"selected option"];
    [setUserDefaults setInteger:indexPath.row forKey:@"selected option"];
   
    
   [self tablereloaddata];
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
 
        [cell setAccessoryType:UITableViewCellAccessoryNone];
   

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 34.0;
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
//        adsLand.scrollView.bounces=NO;
//        adsLand.opaque=NO;
//        [adsLand loadHTMLString: [NSString stringWithFormat:@"<script type=\"text/javascript\" src=\"http://ad.leadboltads.net/show_app_ad.js?section_id=897295593\"></script>"] baseURL:nil];        //Load the request in the UIWebView.
       
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view = self.pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
//        ads.scrollView.bounces=NO;
//        ads.opaque=NO;
//        [ads loadHTMLString: [NSString stringWithFormat:@"<script type=\"text/javascript\" src=\"http://ad.leadboltads.net/show_app_ad.js?section_id=897295593\"></script>"] baseURL:nil];        //Load the request in the UIWebView.
       

    }
    sortingTableLand.frame = CGRectMake(861, 43, 137, 170);
    sortingTable.frame = CGRectMake(616, 43, 137, 170);
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
     [[UINavigationBar appearance]setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}


-(void)cameraClicked:(UIButton *)sender
{
    navBarButtonsIndex = sender.tag;
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    if(sender.tag == 2)
    {
        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
        [self.navigationController pushViewController:addNote animated:YES];
    }
    else
    {
        CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
        openCamera.navTagFromHome = navBarButtonsIndex;
        [self.navigationController pushViewController:openCamera animated:YES];
        
        
//        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
//        addNote.SHORTCUTCLICKED=@"1";
//        [self.navigationController pushViewController:addNote animated:YES];

    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createNewVendorButton:(id)sender {
    AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
    [self.navigationController pushViewController:addNote animated:YES];

}

- (IBAction)refreshBtn:(id)sender
{
     [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];
}

- (IBAction)sortByDate:(id)sender
{
   
    
    [self.pView addSubview:tableViewBgImage];
    [self.pView addSubview:sortingTable];
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    
    [self.lView addSubview:tableViewBgImageLand];
    [self.lView addSubview:sortingTableLand];
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    
    if(sortingTable.hidden == YES || sortingTableLand.hidden==YES)
    {
        [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
        sortingTable.hidden = NO;
        tableViewBgImage.alpha = 1.0;
        
        [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
        sortingTableLand.hidden = NO;
        tableViewBgImageLand.alpha = 1.0;
    }
    else if ( sortingTable.hidden == NO || sortingTableLand.hidden == NO)
    {
        [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
        sortingTable.hidden = YES;
        tableViewBgImage.alpha = 0.0;
        
        [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
        sortingTableLand.hidden = YES;
        tableViewBgImageLand.alpha = 0.0;
    }
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    
}

- (IBAction)displayGridView:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
         tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    listAndGridIndex=1;
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb_on.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb_on.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];
}

- (IBAction)displayListView:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    listAndGridIndex=2;
   
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view_on.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view_on.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;

    
    [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];
}
- (IBAction)syncButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, Description from ba_tbl_vendor_master"];
    [self displayContentData:fetchdata];
    
    totalVendors=TotalData;
   [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];

    
}

- (IBAction)allVendorsButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender_on.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender_on.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    
 [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];}

- (IBAction)sharedButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared_on.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared_on.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
}



- (IBAction)shareVendorButton:(id)sender {
}
- (IBAction)offEditModeBtn:(id)sender {
    
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
        
        [tickmarkButtonlist[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonlistLand[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonGrid[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonGridLand[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];

    }

}

-(void)overlayclicked
{
    NSLog(@"OverlayIndex=%d",OverlayIndex);
    
    if(OverlayIndex==1)
    {
        NSLog(@"Hit1");
        [Overlaybtn setBackgroundImage:[UIImage imageNamed:@"overlay2.jpg"] forState:UIControlStateNormal];
        [OverlaybtnLand setBackgroundImage:[UIImage imageNamed:@"overlay2Land.jpg"] forState:UIControlStateNormal];
        OverlayIndex=2;
    }
    else if(OverlayIndex==2)
    {
         NSLog(@"Hit2");
        [Overlaybtn setBackgroundImage:[UIImage imageNamed:@"overlay3.jpg"] forState:UIControlStateNormal];
        [OverlaybtnLand setBackgroundImage:[UIImage imageNamed:@"overlay3Land.jpg"] forState:UIControlStateNormal];
        OverlayIndex = 3;
    }
    else if(OverlayIndex==3)
    {
        
         NSLog(@"Hit3");
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        [Overlaybtn removeFromSuperview];
        Overlaybtn=nil;
      
        [OverlaybtnLand removeFromSuperview];
         OverlaybtnLand=nil;
        OverlayIndex=4;
        GlobalClass *obj=[GlobalClass getInstance];
        obj.CHECK_CATALOG=@"0";
        
    }

    
}

-(void)fetchIndustryData

{
    
    checkTag=1;
    
    
    
    NSString *insertSQL1 = [NSString stringWithFormat:@"select count(id) from ba_tbl_industry_master"];
    
    
    
    [self displayAll:insertSQL1];
    
    
    
    if ([MobileNo isEqualToString:@"0"]) {
        
        NSURL *audiourl = [NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/getindustry"]];
        
        ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:audiourl];
        
        //    NSError*err;
        
        //    NSData *postData1 = [NSData dataWithContentsOfFile:imagepath options: 0 error:&err];
        
        //    NSLog(@"postData=%@",postData1);
        
        //    [request1 addData:postData1 withFileName:@"AkshayBuyersPicksAppPhoto.png" andContentType:@"image/png" forKey:@"uploaded_files"];
        
        //    [request1 addFile:@"0" forKey:@"id"];
        
        [request1 addPostValue:@"0" forKey:@"id"];
        
        [request1 setDelegate:self];
        
        [request1 startAsynchronous];
        
        
        
    }
    
    
    
    else{
        
        
        
        
        
        NSURL *audiourl = [NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/getindustry"]];
        
        ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:audiourl];
        
        //    NSError*err;
        
        //    NSData *postData1 = [NSData dataWithContentsOfFile:imagepath options: 0 error:&err];
        
        //    NSLog(@"postData=%@",postData1);
        
        //    [request1 addData:postData1 withFileName:@"AkshayBuyersPicksAppPhoto.png" andContentType:@"image/png" forKey:@"uploaded_files"];
        
        //    [request1 addFile:@"0" forKey:@"id"];
        
        [request1 addPostValue:MobileNo forKey:@"id"];
        
        [request1 setDelegate:self];
        
        [request1 startAsynchronous];
        
    }
    
    
    
}





-(void)fetchAttributeData

{
    
    checkTag=2;
    
    
    
    
    
    NSString *insertSQL1 = [NSString stringWithFormat:@"select count(id) from ba_tbl_attributes"];
    
    
    
    [self displayAll:insertSQL1];
    
    
    
    if ([MobileNo isEqualToString:@"0"]) {
        
        NSURL *audiourl = [NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/getattribute"]];
        
        ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:audiourl];
        
        //    NSError*err;
        
        //    NSData *postData1 = [NSData dataWithContentsOfFile:imagepath options: 0 error:&err];
        
        //    NSLog(@"postData=%@",postData1);
        
        //    [request1 addData:postData1 withFileName:@"AkshayBuyersPicksAppPhoto.png" andContentType:@"image/png" forKey:@"uploaded_files"];
        
        //    [request1 addFile:@"0" forKey:@"id"];
        
        [request1 addPostValue:@"0" forKey:@"id"];
        
        [request1 setDelegate:self];
        
        [request1 startAsynchronous];
        
        
        
        
        
    }
    
    else
        
    {
        
        
        
        
        
        NSURL *audiourl = [NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/getattribute"]];
        
        ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:audiourl];
        
        //    NSError*err;
        
        //    NSData *postData1 = [NSData dataWithContentsOfFile:imagepath options: 0 error:&err];
        
        //    NSLog(@"postData=%@",postData1);
        
        //    [request1 addData:postData1 withFileName:@"AkshayBuyersPicksAppPhoto.png" andContentType:@"image/png" forKey:@"uploaded_files"];
        
        //    [request1 addFile:@"0" forKey:@"id"];
        
        [request1 addPostValue:MobileNo forKey:@"id"];
        
        [request1 setDelegate:self];
        
        [request1 startAsynchronous];
        
        
        
        
        
        
        
    }
    
    
    
    
    
}







#pragma mark Async Hit to Server



- (void)requestFinished:(ASIHTTPRequest *)request {
    
    
    NSString *receivedString = [request responseString];
    
    NSLog(@"requestFinished=%@",receivedString);
    
    if (checkTag ==1) {
        
        
        
        //        NSDictionary* responseDict = [request responseString];
        
        NSData *data = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary *industry = [responseDict objectForKey:@"industry"];
        
        
        
        
        
        for (NSDictionary *actoAgent in industry){
            
            
            
            
            
            
            
            
            
            
            
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO ba_tbl_industry_master (id, industry, created_date, is_deleted, last_modified) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[actoAgent objectForKey:@"id"],[actoAgent objectForKey:@"industry"],[actoAgent objectForKey:@"created_date"],[actoAgent objectForKey:@"is_deleted"],[actoAgent objectForKey:@"last_modified"]];
            
            [self saveData:insertSQL];
            
            
            
        }
        [self fetchAttributeData];

        
        
    }
    
    
    
    
    
    else
        
    {
        
        
        
        NSData *data = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary *attribute = [responseDict objectForKey:@"attribute"];
        
        
        
        
        
        for (NSDictionary *actoAgent in attribute){
            
            
            
            //            NSLog(@"actoagent=%@",[actoAgent objectForKey:@"id"]);
            
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO ba_tbl_attributes (id, attibute, display_attribute, industry_id, last_modified, is_deleted, master_attibute_id, created_by) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[actoAgent objectForKey:@"id"],[actoAgent objectForKey:@"attribute"],[actoAgent objectForKey:@"display_attribute"],[actoAgent objectForKey:@"industry_id"],[actoAgent objectForKey:@"is_deleted"],[actoAgent objectForKey:@"last_modified"],[actoAgent objectForKey:@"master_attribute_id"],[actoAgent objectForKey:@"created_by"]];
            
            
            
            [self saveData:insertSQL];
            
            
            
        }
        
        
        
        
        
    }
    
    
}



- (void)requestFailed:(ASIHTTPRequest *)request {
    
    
    NSString *receivedString = [request responseString];
    
    NSLog(@"requestFailed=%@",receivedString);
    
    
    
}



-(void)FetchIndustryData1:(NSString *)post

{
    
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"null",@"null"];
    
    
    
    
    
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"1234567890",@"rohan.k@skiusainc.com"];
    
    NSLog(@"POST=%@",post);
    
    
    //	dispatch_async(dispatch_get_main_queue()	, ^{
    
    
    
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/userstatus"]]];
    
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
    
    
    
    
    
    //    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO ba_tbl_user (id , email , password , name , device , last_login , active , created_date , verification_key , active_date , old_password , last_modified , created_by , subscribtion_type , user_type ) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",@"1", emailId.text, password.text, firstName.text, @"device",@"last_login",@"0",@"created_date",@"verification_key",@"active_date", @"old_password", @"last_modified" , @"created_by" , @"subscribtion_type" , @"individual"];
    
    //    NSLog(@"query=%@",insertSQL);
    
    
    
    
    
    for (NSDictionary *actoAgent in responseDict){
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO ba_tbl_attributes (id, attibute, display_attribute, industry_id, last_modified, is_deleted, master_attibute_id, created_by) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")"];
        
    }
    
}


@end
