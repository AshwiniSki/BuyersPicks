//
//  OpenVendor.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 11/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "OpenVendor.h"
#import "AddNote.h"
#import "CameraAudioVideoNote.h"
#import "SearchByTag.h"
#import "LockVendor.h"   // Anish ***********************************************
#import "SecurePin.h"

@interface OpenVendor ()

@end

@implementation OpenVendor
@synthesize placeHolderTitle,sortedArray,lView,pView,INDEX,sortingTable,sortByDate,listView,gridView,editButton,syncButton,noteScroller,tableViewBgImage,deleteNoteButton,shareNoteButton,vendorDesciption,vendorid,vendorTitle,vendorWebsite,listAndGridIndex,shareNoteButtonLand,adsLand,ads;
@synthesize listViewLand,gridViewLand,sortByDateLand,sortingTableLand,syncButtonLand,editButtonLand,noteScrollerLand,tableViewBgImageLand,deleteNoteButtonLand,deleteItems,offEditModeBtnLand,offEditModeBtn,vendorname;
@synthesize pinCheck,pinCheckUser;

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
    
    deleteItems = [[NSMutableArray alloc]init];
    GlobalClass *obj= [GlobalClass getInstance];
    obj.VenID=vendorid;
    
    NSLog(@"VENDORID==%@",vendorid);
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    listAndGridIndex = 2;
    
    deleteNoteButton.alpha = 0.0;
    shareNoteButton.alpha = 0.0;
    deleteNoteButtonLand.alpha = 0.0;
    shareNoteButtonLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;

       sortedArray = [[NSArray alloc]initWithObjects:@"Default View",@"Vendor Created",@"Vendor Modified",@"A to Z",@"Z to A", nil];
    
    
    UIImage *lockImage = [UIImage imageNamed:@"lock.png"];
    UIButton *lockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lockButton setImage:lockImage forState:UIControlStateNormal];
    lockButton.frame = CGRectMake(0, 5, lockImage.size.width, lockImage.size.height);
    lockButton.tag = 0;
    [lockButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemLock = [[UIBarButtonItem alloc] initWithCustomView:lockButton];
    
    UIImage *cameraImage = [UIImage imageNamed:@"camera_icon.png"];
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton setImage:cameraImage forState:UIControlStateNormal];
    cameraButton.frame = CGRectMake(0, 5, cameraImage.size.width, cameraImage.size.height);
    cameraButton.tag = 3;
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
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemNote, customBarItemAudio,customBarItemCamera,customBarItemLock,customBarItemSearch,nil]];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"VENDOR NAME";
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
    
    tableViewBgImageLand.layer.cornerRadius = 10.0;
    tableViewBgImageLand.clipsToBounds = YES;
    tableViewBgImage.layer.cornerRadius = 10.0;
    tableViewBgImage.clipsToBounds = YES;
    
    [tableViewBgImage.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [tableViewBgImage.layer setBorderWidth:0.5];
    [tableViewBgImageLand.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [tableViewBgImageLand.layer setBorderWidth:0.5];
    
}

-(void)checkSecurePIN  // Anish ***********************************************
{
    NSString   *fetchdata = [NSString stringWithFormat:@"select security_pin from ba_tbl_vendor where id=%@",vendoridDB[0]];
    [self displayAll:fetchdata];
    NSLog(@"fetchdata checkSecurePIN   =%@",fetchdata);
    NSLog(@"mooU=%@",MobileNo);
    pinCheck=[NSString stringWithFormat:@"%@",MobileNo];
    NSLog(@"pinCheck1 = %@",pinCheck);
}

-(void)checkSecurePINuser  // Anish ***********************************************
{
    NSString   *fetchdata = [NSString stringWithFormat:@"select security_pin from ba_tbl_user where id=1"];
    [self displayAll:fetchdata];
    NSLog(@"fetchdata checkSecurePIN   =%@",fetchdata);
    NSLog(@"mooU=%@",MobileNo);
    pinCheckUser=MobileNo;
    NSLog(@"pinCheckUser = %@",pinCheckUser);
    
    
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
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];

    NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type, created_date from ba_tbl_content where vendor_id=%@",vendorid];
    [self displayContentData:fetchdata];
    
    sortingTableLand.frame = CGRectMake(861, 43, 137, 170);
    sortingTable.frame = CGRectMake(616, 43, 137, 170);
    
    
    adsLand.scrollView.bounces=NO;
    adsLand.opaque=NO;
    [adsLand loadHTMLString: [NSString stringWithFormat:@"<script type=\"text/javascript\" src=\"http://ad.leadboltads.net/show_app_ad.js?section_id=897295593\"></script>"] baseURL:nil];        //Load the request in the UIWebView.
    ads.scrollView.bounces=NO;
    ads.opaque=NO;
    [ads loadHTMLString: [NSString stringWithFormat:@"<script type=\"text/javascript\" src=\"http://ad.leadboltads.net/show_app_ad.js?section_id=897295593\"></script>"] baseURL:nil];        //Load the request in the UIWebView.
    
    GlobalClass     *obj = [GlobalClass getInstance];
    if([obj.IAPStatus isEqualToString:@"1"])
    {
        adsLand.alpha = 0.0;
        ads.alpha = 0.0;
    }
    INDEX = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected option"];
    NSLog(@"INDEX = %d",INDEX);
    
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

-(void)done
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cameraClicked:(UIButton *)sender
{
   [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website, tags, email_id, address, contact_no , vendor_title  from ba_tbl_vendor WHERE id=%@",vendorid];
    
    [self displaySelctedVendor:fetchdata];
    [self checkSecurePIN];
    [self checkSecurePINuser];
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    if(sender.tag == 0)
    {
        if ([pinCheckUser isEqualToString:@"0"])     // Anish ***
        {
            //        CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
            //        openCamera.navTagFromHome = navBarButtonsIndex;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert !" message:@"Please Set Secure PIN first " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            alert.tag=01;
            
            
        }
        else
        {
            
            if ([pinCheck isEqualToString:@"0"]) {
                NSString   *insertquery1 = [NSString stringWithFormat:@"update  ba_tbl_vendor SET security_pin =\"1\" where id =%@" ,vendoridDB[0] ];
                [self saveData:insertquery1];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !" message:@" Vendor Locked " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                alert.tag=02;
                
            }
            else{
                
                appD=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                appD.PinCheckvendorid=vendoridDB[0];
                appD.lockVendorTag=@"2";
                NSLog(@"listAndGridIndex = %@",appD.PinCheckvendorid);
                LockVendor *lockVendor = [[LockVendor alloc]initWithNibName:@"LockVendor" bundle:nil];
                lockVendor.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
                [self presentViewController:lockVendor animated:YES completion:nil];
                
            }
        }
        
    }   // Anish ***********************************************
    

    if(sender.tag == 2)
    {
//        NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website  from ba_tbl_vendor WHERE id=%d",[sender tag]+1];
//        [self displaySelctedVendor:fetchdata];
        
        
        
        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
        addNote.vendorTitle=vendornameDB[0];
        addNote.vendorDesciption=vendordescDB[0];
        
//        addNote.vendorWebsiteString=vendorWebsitesDB[0];
//        addNote.vendorAddressString=vendorAddressDB[0];
        addNote.vendorTagsString=vendorTagsDB[0];
//        addNote.vendorEmailIdString=vendorEmailIdDB[0];
//        addNote.vendorContactsString=vendorContactnoDB[0];
        addNote.vendorid=vendoridDB[0];
        addNote.calledfromopenvendor=@"1";
        
        
        
        
//        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
//        addNote.vendorTitle=vendorTitle;
//        addNote.vendorName = vendorname;
//        addNote.vendorDesciption=vendorDesciption;
//        addNote.vendorWebsite=vendorWebsite;
//        addNote.vendorid=vendorid;

        [self.navigationController pushViewController:addNote animated:YES];
      
    }
    if(sender.tag == 1)
    {
        CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
        openCamera.navTagFromHome = 1;
        
        [self.navigationController pushViewController:openCamera animated:YES];
    }
    
    if(sender.tag == 3)
    {
        CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
        openCamera.navTagFromHome = 0;
        
        [self.navigationController pushViewController:openCamera animated:YES];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  // Anish ***********************************************
{
    if (alertView.tag==01) {
        
        if (buttonIndex==1) {
            SecurePin *securePin = [[SecurePin alloc]initWithNibName:@"SecurePin" bundle:nil];
            securePin.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
            [self presentViewController:securePin animated:YES completion:nil];
        }
    }
}
-(void)DisplayVendors
{
    NSLog(@"listAndGridIndex = %d",listAndGridIndex);
    
    [[noteScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[noteScrollerLand subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type, created_date from ba_tbl_content where vendor_id=%@",vendorid];
    NSLog(@"fetchdata111=%@",fetchdata);
    [self displayContentData:fetchdata];

    int m = 0;
    int nXX = 0;
    int nYY = 0;
    if (listAndGridIndex==1)
    {
        int mX = 7;
        int mY = 0;
        
        int nX = 7;
        int nY = 0;
        
        NSLog(@"totalvendore = %d",TotalData);
        for (int i =0; i<TotalData; i++)
        {
            mX=248*(i%3);
            mY=265 * (i/3);
            
            nX=248*(i%4);
            nY=265 * (i/4);
            
            
            vendorImage[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImage[i].frame = CGRectMake(mX+7, mY, 238, 227);
            vendorImage[i].userInteractionEnabled = YES;
            if ([datatype[i] isEqualToString:@"image"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageWithContentsOfFile:datapath[i]] forState:UIControlStateNormal];
                
                UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 238 ,227)];
                blackPhotoImage.image = [UIImage imageNamed:@"blank.png"];
                [vendorImage[i] addSubview:blackPhotoImage];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"video"]) {
                
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"video_rec.jpg"] forState:UIControlStateNormal];
            }
            
            
            if ([datatype[i] isEqualToString:@"audio"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"voice_rec.jpg"] forState:UIControlStateNormal];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"text"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"tag-img.png"] forState:UIControlStateNormal];
                
                
            }
            //  [ vendorImage[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImage[i].tag = i;
            [noteScroller addSubview:vendorImage[i]];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPress.delegate = self;
            [vendorImage[i] addGestureRecognizer:longPress];
            
            noteTagGrid[i] = [[UILabel alloc]initWithFrame:CGRectMake(mX+7, mY+230, 238, 25)];
            noteTagGrid[i].backgroundColor = [UIColor clearColor];
            // noteTagGrid[i].text =datatype[i];
            noteTagGrid[i].text = @"note Tag";
            noteTagGrid[i].numberOfLines = 1;
            noteTagGrid[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            noteTagGrid[i].font = [UIFont systemFontOfSize:13.0];
            noteTagGrid[i].textColor = [UIColor grayColor];
            [noteScroller addSubview:noteTagGrid[i]];

            
            
            tickmarkButtonGrid[i] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 238, 227)];
            tickmarkButtonGrid[i].userInteractionEnabled = NO;
            tickmarkButtonGrid[i].alpha = 0.0;
            tickmarkButtonGrid[i].tag = i;
            [tickmarkButtonGrid[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
            [vendorImage[i] addSubview:tickmarkButtonGrid[i]];
            
            
            tagTextView[i] = [[UITextView alloc]initWithFrame:CGRectMake(mX+7, mY+227, 238, 20)];
            tagTextView[i].font = [UIFont fontWithName:@"Helvetica" size:12];
            tagTextView[i].font = [UIFont boldSystemFontOfSize:12];
            tagTextView[i].textColor = [UIColor lightGrayColor];
            tagTextView[i].scrollEnabled = YES;
            tagTextView[i].pagingEnabled = YES;
            tagTextView[i].editable = NO;
            tagTextView[i].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"streetbox.jpg"]];
            
            mX=mX+248;
            mY=mY+265;
            
            
            
            vendorImageLand[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImageLand[i].frame = CGRectMake(nX+7, nY, 238, 227);
            vendorImageLand[i].userInteractionEnabled = YES;
            if ([datatype[i] isEqualToString:@"image"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageWithContentsOfFile:datapath[i]] forState:UIControlStateNormal];
                
                UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 238 ,227)];
                blackPhotoImage.image = [UIImage imageNamed:@"blank.png"];
                [vendorImageLand[i] addSubview:blackPhotoImage];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"video"]) {
                
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"video_rec.jpg"] forState:UIControlStateNormal];
            }
            
            
            if ([datatype[i] isEqualToString:@"audio"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"voice_rec.jpg"] forState:UIControlStateNormal];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"text"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"tag-img.png"] forState:UIControlStateNormal];
                
                
            }
            // [ vendorImageLand[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImageLand[i].tag = i;
            [noteScrollerLand addSubview:vendorImageLand[i]];
            
            UILongPressGestureRecognizer *longPressLand = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPressLand.delegate = self;
            [vendorImageLand[i] addGestureRecognizer:longPressLand];
            
            noteTagGridLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(nX+7, nY+230, 238, 25)];
            noteTagGridLand[i].backgroundColor = [UIColor clearColor];
            // noteTagGridLand[i].text =datatype[i];
            noteTagGridLand[i].text = @"note Tag";
            noteTagGridLand[i].numberOfLines = 1;
            noteTagGridLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            noteTagGridLand[i].font = [UIFont systemFontOfSize:13.0];
            noteTagGridLand[i].textColor = [UIColor grayColor];
            [noteScrollerLand addSubview:noteTagGridLand[i]];
            
            tickmarkButtonGridLand[i] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 238, 227)];
            tickmarkButtonGridLand[i].userInteractionEnabled = NO;
            tickmarkButtonGridLand[i].alpha = 0.0;
            tickmarkButtonGridLand[i].tag = i;
            [tickmarkButtonGridLand[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
            [vendorImageLand[i] addSubview:tickmarkButtonGridLand[i]];
            
            
            nX=nX+248;
            nY=nY+265;
            
            
            
        }
        if(TotalData%3==0)
        {
            
            noteScroller.contentSize = CGSizeMake(748,265*TotalData/3+150);
        }
        else
        {
            noteScroller.contentSize = CGSizeMake(748,(265*TotalData/3)+200);
            
        }
        
        if(TotalData%4==0)
        {
            
            noteScrollerLand.contentSize = CGSizeMake(1006,265*TotalData/4+150);
        }
        else
        {
            noteScrollerLand.contentSize = CGSizeMake(1006,(265*TotalData/4)+200);
            
        }
        
    }
    if (listAndGridIndex==2)
    {
        for (int i =0; i<TotalData; i++)
        {
            viewForList[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m, 748, 115)];
            viewForList[i].backgroundColor = [UIColor clearColor];
            [noteScroller addSubview:viewForList[i]];
            
            vendorImage[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImage[i].frame = CGRectMake(10, 2, 100, 100);
            vendorImage[i].userInteractionEnabled = YES;
            if ([datatype[i] isEqualToString:@"image"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageWithContentsOfFile:datapath[i]] forState:UIControlStateNormal];
                
                UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100 ,100)];
                blackPhotoImage.image = [UIImage imageNamed:@"blank.png"];
                [vendorImage[i] addSubview:blackPhotoImage];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"video"]) {
                
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"video_rec.jpg"] forState:UIControlStateNormal];
            }
            
            
            if ([datatype[i] isEqualToString:@"audio"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"voice_rec.jpg"] forState:UIControlStateNormal];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"text"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"tag-img.png"] forState:UIControlStateNormal];
                
                
            }
            //  [ vendorImage[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImage[i].tag = i;
            [viewForList[i] addSubview:vendorImage[i]];
            
            noteDate[i] = [[UILabel alloc]initWithFrame:CGRectMake(530, 35, 200, 20)];
            noteDate[i].backgroundColor = [UIColor clearColor];
            dateArray=[datadateNote[i] componentsSeparatedByString:@"/"];
            NSLog(@"dateArray = %@",dateArray);
            noteDate[i].text = [dateArray objectAtIndex:0];
            noteDate[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            noteDate[i].font = [UIFont boldSystemFontOfSize:13.0];
            noteDate[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:noteDate[i]];
         
            noteTagLabel[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 25, 200, 60)];
            noteTagLabel[i].backgroundColor = [UIColor clearColor];
           // noteTagLabel[i].text =datatype[i];
            noteTagLabel[i].text = @"note Tag";
            noteTagLabel[i].numberOfLines = 2;
            noteTagLabel[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            noteTagLabel[i].font = [UIFont systemFontOfSize:13.0];
            noteTagLabel[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:noteTagLabel[i]];
            
            
            
            lineImage[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110, 748, 1)];
            lineImage[i].backgroundColor = [UIColor grayColor];
            [viewForList[i] addSubview:lineImage[i]];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPress.delegate = self;
            [vendorImage[i] addGestureRecognizer:longPress];
            
            tickmarkButtonlist[i] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
            tickmarkButtonlist[i].userInteractionEnabled = NO;
            tickmarkButtonlist[i].alpha = 0.0;
            tickmarkButtonlist[i].tag = i;
            [tickmarkButtonlist[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
            [viewForList[i] addSubview:tickmarkButtonlist[i]];
            
            m=m+115;
            
            nXX=503*(i%2);
            nYY=115 * (i/2);
            
            
            viewForListLand[i] = [[UIView alloc]initWithFrame:CGRectMake(nXX, nYY, 503, 115)];
            viewForListLand[i].backgroundColor = [UIColor clearColor];
            [noteScrollerLand addSubview:viewForListLand[i]];
            
            vendorImageLand[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImageLand[i].frame = CGRectMake(10, 2, 100, 100);
            vendorImageLand[i].userInteractionEnabled = YES;
            if ([datatype[i] isEqualToString:@"image"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageWithContentsOfFile:datapath[i]] forState:UIControlStateNormal];
                
                UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100 ,100)];
                blackPhotoImage.image = [UIImage imageNamed:@"blank.png"];
                [vendorImageLand[i] addSubview:blackPhotoImage];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"video"]) {
                
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"video_rec.jpg"] forState:UIControlStateNormal];
            }
            
            
            if ([datatype[i] isEqualToString:@"audio"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"voice_rec.jpg"] forState:UIControlStateNormal];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"text"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"tag-img.png"] forState:UIControlStateNormal];
                
                
            }
            // [ vendorImageLand[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImageLand[i].tag = i;
            [viewForListLand[i] addSubview:vendorImageLand[i]];
            
            NSLog(@"Ashwini datadate = %@",datadate[i]);
            noteDateLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(330, 60, 200, 20)];
            noteDateLand[i].backgroundColor = [UIColor clearColor];
            noteDateLand[i].text = datadateNote[i];
            //noteDateLand[i].text = @"note date";
            noteDateLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            noteDateLand[i].font = [UIFont boldSystemFontOfSize:13.0];
            noteDateLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:noteDateLand[i]];

            noteTagLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 25, 200, 60)];
            noteTagLand[i].backgroundColor = [UIColor clearColor];
           // noteTagLand[i].text = datatype[i];
            noteTagLand[i].text = @"note Tag";
            noteTagLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            noteTagLand[i].font = [UIFont systemFontOfSize:13.0];
            noteTagLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:noteTagLand[i]];
            
            
            
            lineImageLand[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, nYY+115, 1006, 1)];
            lineImageLand[i].backgroundColor = [UIColor grayColor];
            [noteScrollerLand addSubview:lineImageLand[i]];
            
            UILongPressGestureRecognizer *longPressLand = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPressLand.delegate = self;
            [vendorImageLand[i] addGestureRecognizer:longPressLand];
            
            tickmarkButtonlistLand[i] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
            tickmarkButtonlistLand[i].userInteractionEnabled = NO;
            tickmarkButtonlistLand[i].alpha = 0.0;
            tickmarkButtonlistLand[i].tag = i;
            [tickmarkButtonlistLand[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
            [viewForListLand[i] addSubview:tickmarkButtonlistLand[i]];
            
            nXX=nXX+503;
            nYY=nYY+115;
            
        }
        noteScroller.contentSize = CGSizeMake(748, 115*TotalData+150);
        noteScrollerLand.contentSize = CGSizeMake(1006, 115*TotalData/2+150);
        
    }
    
}

- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    if ( gesture.state == UIGestureRecognizerStateBegan ) {
        NSLog(@"Long Press");
        deleteNoteButton.alpha = 1.0;
        shareNoteButton.alpha = 1.0;
        deleteNoteButtonLand.alpha = 1.0;
        shareNoteButtonLand.alpha = 1.0;
        syncButton.alpha = 1.0;
        syncButtonLand.alpha = 1.0;
        offEditModeBtn.alpha = 1.0;
        offEditModeBtnLand.alpha = 1.0;
        sortingTableLand.hidden = YES;
        sortingTable.hidden = YES;
        tableViewBgImageLand.alpha = 0.0;
        tableViewBgImage.alpha = 0.0;
        
        for (int i =0; i<TotalData; i++)
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
   

    NSLog(@"inside tickmarkClicked ");
    //    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website  from ba_tbl_vendor WHERE id=%d",[sender tag]+1];
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
        
        NSString *delete = [NSString stringWithFormat:@"delete from ba_tbl_content where id = %@",[deleteItems objectAtIndex:i]];
        [self saveData:delete];
        
    }
    [deleteItems removeAllObjects];
  
    NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type, created_date from ba_tbl_content where vendor_id=%@",vendorid];
    [self displayContentData:fetchdata];
    
   
    
   [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];
    
}



- (IBAction)sharedButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<TotalData; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;

    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
       sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
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
    
    if ([[sortedArray objectAtIndex:indexPath.row] isEqualToString:[NSString stringWithFormat:@"%@",[sortedArray objectAtIndex:INDEX]]]) {
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
    
    sortingTable.hidden = YES;
}
-(void)tablereloaddata
{
    
    INDEX = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected option"];
    NSLog(@"INDEX = %d",INDEX);
    [sortingTable reloadData];
  
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

- (IBAction)sortByDate:(id)sender
{
     deleteNoteButton.alpha = 0.0;
     shareNoteButton.alpha = 0.0;
     deleteNoteButtonLand.alpha = 0.0;
     shareNoteButtonLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    
    [self.pView addSubview:tableViewBgImage];
    [self.pView addSubview:sortingTable];
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    
    
    [self.lView addSubview:tableViewBgImageLand];
    [self.lView addSubview:sortingTableLand];
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
   
    
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
    for (int i =0; i<TotalData; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;

      
    }
    listAndGridIndex=1;
    deleteNoteButton.alpha = 0.0;
    deleteNoteButtonLand.alpha = 0.0;
    shareNoteButton.alpha = 0.0;
     shareNoteButtonLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb_on.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
  
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    
   [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];
}

- (IBAction)displayListView:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<TotalData; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;

       
    }
    listAndGridIndex=2;
    deleteNoteButtonLand.alpha = 0.0;
     shareNoteButton.alpha = 0.0;
    deleteNoteButton.alpha = 0.0;
    shareNoteButtonLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view_on.jpg"] forState:UIControlStateNormal];
 
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    
   [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];
}
- (IBAction)syncButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<TotalData; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
       
    }
   
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
  
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, Description from ba_tbl_vendor"];
    [self displayContentData:fetchdata];
    
   
   [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];
    
    
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
    
    sortingTable.frame = CGRectMake(616, 43, 137, 170);
    sortingTableLand.frame = CGRectMake(871, 43, 137, 170);
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
    sortingTableLand.frame = CGRectMake(861, 43, 137, 170);
    sortingTable.frame = CGRectMake(616, 43, 137, 170);
    
}
- (IBAction)editButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    
    NSLog(@"VENDORID=%@",vendorid);
    AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
    addNote.vendorTitle=vendorTitle;
    addNote.vendorDesciption=vendorDesciption;
    addNote.vendorWebsite=vendorWebsite;
    addNote.vendorid=vendorid;
    addNote.calledfromopenvendor=@"1";
    
    [self.navigationController pushViewController:addNote animated:YES];
}

- (IBAction)offEditModeBtn:(id)sender {
    
    deleteNoteButton.alpha = 0.0;
    shareNoteButton.alpha = 0.0;
    deleteNoteButtonLand.alpha = 0.0;
    shareNoteButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    for (int i =0; i<TotalData; i++)
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
