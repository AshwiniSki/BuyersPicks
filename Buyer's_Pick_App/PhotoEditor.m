//
//  PhotoEditor.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 07/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "PhotoEditor.h"
#define kAFSDKDemoImageViewInset 10.0f
#define kAFSDKDemoBorderAspectRatioPortrait 3.0f/4.0f
#define kAFSDKDemoBorderAspectRatioLandscape 4.0f/3.0f
#import "GlobalClass.h"
@interface PhotoEditor ()

@end

@implementation PhotoEditor

@synthesize TAG,DATAPATH,DATATYPE,imageToEdit,editOptionsArray,scrollBgImage,optionsScroller,addCustmFldsInScrll,addCustmFldsInTbl,detailTableView;

@synthesize brandLabel,beltLabel,availabilityLabel,briefDescLabel,productTextFld,priceTextFld,QuantityTextFld,modelTextFld,CertifctnTextFld,minOrderTextFld,paymentTextFld,manufacturerTextFld,DATAID,yDistance,changeIndustrybgImage,changeIndustrylabel,addColorbgImage,addColorlabel;


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
    GlobalClass  *obj =[GlobalClass getInstance];
    changeIndustrylabel.text   = obj.industryname;
  
    obj1 = [[NSMutableArray alloc] init];
    obj2 = [[NSMutableArray alloc] init];

    NSString  *fetchdata = [NSString stringWithFormat:@"SELECT ind.industry, att.id tag_id, att.attibute tags, att2.id sub_tag_id, att2.attibute sub_tags FROM ba_tbl_attributes att LEFT JOIN ba_tbl_attributes att2 ON  att.id = att2.master_attibute_id, ba_tbl_industry_master ind WHERE ind.id = att.industry_id AND att.master_attibute_id = %@",obj.industryIDfromGC];
    [self getDataFrom_ba_tbl_industry_master:fetchdata];
    NSLog(@"display_attribute=%@",data3[0]);

      yDistance = 173;
    
    NSLog(@"obj1=%@",obj1);

    for (int i =0; i<TotalData; i++)
    {

        
        
   
        if (![obj1 containsObject:data2[i]]) {
        
            [obj1 addObject:data2[i]];

            
            NSLog(@"insideobj1=%@",obj1);

            
            
            bgImageCustmFldsScroller[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, yDistance, 214, 47)];
            bgImageCustmFldsScroller[i].image = [UIImage imageNamed:@"txtfield.png"];
            [optionsScroller addSubview:bgImageCustmFldsScroller[i]];
            
            custmTextField[i] = [[UITextField alloc] initWithFrame:CGRectMake(10, yDistance+7, 204, 30)];
            custmTextField[i].borderStyle = UITextBorderStyleNone;
            custmTextField[i].font = [UIFont systemFontOfSize:14];
            custmTextField[i].textColor = [UIColor grayColor];
            custmTextField[i].backgroundColor = [UIColor clearColor];
            custmTextField[i].placeholder = data3[i];
            [custmTextField[i] setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
            custmTextField[i].autocorrectionType = UITextAutocorrectionTypeNo;
            custmTextField[i].keyboardType = UIKeyboardTypeDefault;
            custmTextField[i].returnKeyType = UIReturnKeyDone;
            custmTextField[i].clearButtonMode = UITextFieldViewModeWhileEditing;
            custmTextField[i].contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            custmTextField[i].delegate = self;
            [optionsScroller addSubview:custmTextField[i]];
            
            yDistance= yDistance+50;

            
            
            
       }

        
        else{

            if (![obj2 containsObject:data2[i]]) {
                [obj2 addObject:data2[i]];

            }

        
    }
    }
    
    NSLog(@"obj1=%@",obj1);
    NSLog(@"obj2=%@",obj2);


    optionsScroller.contentSize = CGSizeMake(224, yDistance+100);

    
    if ([DATATYPE isEqualToString:@"image"])
    {

        imageToEdit.image = [UIImage imageWithContentsOfFile:DATAPATH];
        [self displayEditorForImage:imageToEdit.image];
        
    }
    if ([DATATYPE isEqualToString:@"video"])
    {

        imageToEdit.backgroundColor = [UIColor viewFlipsideBackgroundColor];
        
    }

    if ([DATATYPE isEqualToString:@"audio"])
    {

         imageToEdit.image = [UIImage imageNamed:@"recbg.jpg"];
        
    }

    if ([DATATYPE isEqualToString:@"text"])
    {

        imageToEdit.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
    }

    
    addCustmFldsInTbl.layer.cornerRadius = 10.0;
    addCustmFldsInTbl.clipsToBounds = YES;
    scrollBgImage.alpha = 0.0;
    optionsScroller.alpha = 0.0;
    addCustmFldsInTbl.alpha = 0.0;
    detailTableView.hidden = YES;
    
    editOptionsArray = [[NSMutableArray alloc]init];
    [editOptionsArray addObject:@"Steel Belt"];
    [editOptionsArray addObject:@"Rubber Belt"];
    [editOptionsArray addObject:@"Leather Belt"];
    
    
    UIImage *undoImage = [UIImage imageNamed:@"reset.png"];
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [undoButton setImage:undoImage forState:UIControlStateNormal];
    undoButton.frame = CGRectMake(0, 5, undoImage.size.width, undoImage.size.height);
    undoButton.tag = 1;
    [undoButton addTarget:self action:@selector(navRightButtonClked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemAudio = [[UIBarButtonItem alloc] initWithCustomView:undoButton];
    
    
    UIImage *deleteImage = [UIImage imageNamed:@"delete.png"];
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:deleteImage forState:UIControlStateNormal];
    deleteButton.frame = CGRectMake(0, 5, deleteImage.size.width, deleteImage.size.height);
    deleteButton.tag = 2;
    [deleteButton addTarget:self action:@selector(navRightButtonClked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemNote = [[UIBarButtonItem alloc] initWithCustomView:deleteButton];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemNote, customBarItemAudio,nil]];
    
        
    if([TAG isEqualToString:@"fromSplitView"])
    {
        
    }
    else
    {
        UIImage *doneImage = [UIImage imageNamed:@"done.png"];
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneButton setImage:doneImage forState:UIControlStateNormal];
        doneButton.frame = CGRectMake(0, 3, 64, 37);
        [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarItemDone = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
        self.navigationItem.leftBarButtonItem = customBarItemDone;
    }
    
   
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.text = @"TITLE TAG";
    navTitleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    navTitleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    navTitleLabel.textColor = [UIColor darkGrayColor];
    self.navigationItem.titleView = navTitleLabel;
    
    UITapGestureRecognizer *brandTextFldTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openTable:)];
    brandTextFldTapped.numberOfTapsRequired = 1;
    brandTextFldTapped.delegate = self;
    [brandLabel addGestureRecognizer:brandTextFldTapped];
    
    UITapGestureRecognizer *beltTxtFldTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openTable:)];
    beltTxtFldTapped.numberOfTapsRequired = 1;
    beltTxtFldTapped.delegate = self;
    [beltLabel addGestureRecognizer:beltTxtFldTapped];
    
    UITapGestureRecognizer *availabilityTextFldTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openTable:)];
    availabilityTextFldTapped.numberOfTapsRequired = 1;
    availabilityTextFldTapped.delegate = self;
    [availabilityLabel addGestureRecognizer:availabilityTextFldTapped];
    
    UITapGestureRecognizer *briefDescTxtFldTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openTable:)];
    briefDescTxtFldTapped.numberOfTapsRequired = 1;
    briefDescTxtFldTapped.delegate = self;
    [briefDescLabel addGestureRecognizer:briefDescTxtFldTapped];
    
    UITapGestureRecognizer *changeIndustryLabelTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openTable:)];
    changeIndustryLabelTapped.numberOfTapsRequired = 1;
    changeIndustryLabelTapped.delegate = self;
    [changeIndustrylabel addGestureRecognizer:changeIndustryLabelTapped];
    
    UITapGestureRecognizer *addColorLabelTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openTable:)];
    addColorLabelTapped.numberOfTapsRequired = 1;
    addColorLabelTapped.delegate = self;
    [addColorlabel addGestureRecognizer:addColorLabelTapped];
}

-(void)navRightButtonClked:(UIButton *)sender
{
    
}

-(void)openTable:(UITapGestureRecognizer *)sender
{
    [editOptionsArray removeAllObjects];
    
    if(sender.view.tag == 10)
    {
        [editOptionsArray addObject:@"FastTrack"];
        [editOptionsArray addObject:@"Sonata"];
    }
    if(sender.view.tag == 11)
    {
        [editOptionsArray addObject:@"Plastic"];
        [editOptionsArray addObject:@"Steel"];
        [editOptionsArray addObject:@"Leather"];
    }
    if(sender.view.tag == 12)
    {
        [editOptionsArray addObject:@"Availabel now"];
        [editOptionsArray addObject:@"Availabel from March"];
    }
    if(sender.view.tag == 13)
    {
        [editOptionsArray addObject:@"High Quality"];
        [editOptionsArray addObject:@"Low Quality"];
    }
    if(sender.view.tag == 14)
    {
        //for industry
    }
    if(sender.view.tag == 15)
    {
        //for add color
    }
    [detailTableView reloadData];
    detailTableView.frame = CGRectMake(260, 111, 211, editOptionsArray.count*34);
    addCustmFldsInTbl.alpha = 1.0;
    detailTableView.hidden = NO;
}
-(void)done
{
    [self.navigationController popViewControllerAnimated:YES];
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        
        imageToEdit.frame = CGRectMake(20, 20, 984, 664);
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        imageToEdit.frame = CGRectMake(38, 20, 693, 920);
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
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        imageToEdit.frame = CGRectMake(20, 20, 984, 664);
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        imageToEdit.frame = CGRectMake(38, 20, 693, 920);
        
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return editOptionsArray.count;
    
    
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
    cell1.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    cell1.textLabel.textColor = [UIColor whiteColor];
    cell1.textLabel.text = [editOptionsArray objectAtIndex:indexPath.row];
    [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
    //[cell1 setAccessoryType:UITableViewCellAccessoryCheckmark];

    return cell1;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell2 = [detailTableView cellForRowAtIndexPath:indexPath];
   
    [cell2 setAccessoryType:UITableViewCellAccessoryCheckmark];

    NSLog(@"indexpath.row = %d",indexPath.row);
    //[detailTableView reloadData];
    
    //    scrollBgImage.alpha = 0.0;
//    optionsScroller.alpha = 0.0;
//    addCustmFldsInTbl.alpha = 0.0;
//    detailTableView.hidden = YES;

    
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addCustmFldsInTbl:(id)sender
{
    [editOptionsArray addObject:@"new Field"];
    [detailTableView reloadData];
    if(detailTableView.frame.size.height <= 829)
    {
        detailTableView.frame = CGRectMake(260, 111, 211, editOptionsArray.count*34);
    }
}

- (IBAction)addDetailsButton:(id)sender
{
    if (optionsScroller.alpha == 1.0)
    {
    scrollBgImage.alpha = 1.0;
    optionsScroller.alpha = 1.0;
    }
    else if (optionsScroller.alpha == 0.0)
    {
        scrollBgImage.alpha = 0.0;
        optionsScroller.alpha = 01.0;
    }
    detailTableView.frame = CGRectMake(260, 111, 211, editOptionsArray.count*34);
}

- (IBAction)changeIndustryClicked:(id)sender {
}

- (IBAction)addColorTagClicked:(id)sender {
}

- (IBAction)addCustmFldsinScrll:(id)sender
{
    bgImageCustmFldsScroller1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, yDistance, 214, 47)];
    bgImageCustmFldsScroller1.image = [UIImage imageNamed:@"txtfield.png"];
    [optionsScroller addSubview:bgImageCustmFldsScroller1];
    
    custmTextField1 = [[UITextField alloc] initWithFrame:CGRectMake(10, yDistance+7, 204, 30)];
    custmTextField1.borderStyle = UITextBorderStyleNone;
    custmTextField1.font = [UIFont systemFontOfSize:14];
    custmTextField1.textColor = [UIColor grayColor];
    custmTextField1.backgroundColor = [UIColor clearColor];
    custmTextField1.placeholder = @"Add Custom Field";
    [custmTextField1 setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    custmTextField1.autocorrectionType = UITextAutocorrectionTypeNo;
    custmTextField1.keyboardType = UIKeyboardTypeDefault;
    custmTextField1.returnKeyType = UIReturnKeyDone;
    custmTextField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    custmTextField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    custmTextField1.delegate = self;
    [optionsScroller addSubview:custmTextField1];
    
    yDistance= yDistance+50;
    
    optionsScroller.contentSize = CGSizeMake(224, yDistance+50);
}




- (void)displayEditorForImage:(UIImage *)imageToEdit1
{
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:imageToEdit1];
    [editorController setDelegate:self];
    [self presentViewController:editorController animated:YES completion:nil];
}

- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    NSData *imageData= UIImageJPEGRepresentation(image,0.0);
    
    
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy||HH:mm:SS"];
    NSDate *now = [[NSDate alloc] init];
    NSString*  theDate = [dateFormat stringFromDate:now];
    
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Photos"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    
    NSString *imagepath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@-image.png",documentsDirectory,theDate]];
    
    
    BOOL success = [imageData writeToFile:imagepath atomically:NO];
    
    NSLog(@"Successs:::: %@", success ? @"YES" : @"NO");
    NSLog(@"Image path --> %@",imagepath);
    
    
    
//    [self DATABASECALLED];
    NSString   *insertquery1 = [NSString stringWithFormat:@"SELECT * from  ba_tbl_vendor"];
    [self displayAll:insertquery1];
    NSString   *insertquery = [NSString stringWithFormat:@"update ba_tbl_content set  path = \"%@\" where id=%@ ", imagepath,DATAID];
    
    
    
    
    [self saveData:insertquery];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    imageToEdit.image = [UIImage imageWithContentsOfFile:imagepath];




    // Handle the result image here
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    
    [self dismissViewControllerAnimated:YES completion:nil];

    // Handle cancellation here
}

@end
