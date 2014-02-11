//
//  FAQViewController.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 17/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "FAQViewController.h"
#import "AddNote.h"
#import "CameraAudioVideoNote.h"
#import "BackgroundLayer.h"
#import "SearchByTag.h"

@interface FAQViewController ()

@end

@implementation FAQViewController
@synthesize placeHolderTitle,faqTable,selectedValueIndex,isShowingList,underlineImage,backBtn;
@synthesize dataForSection0;
@synthesize dataForSection2;
@synthesize demoData,ansArray,ads,activityIndicator1;


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
  
    
    
    dataForSection0 = @"This is some cell content.";
    dataForSection2 = @"This is another cell content.";
    ansArray = [[NSMutableArray alloc]init];
//    [ansArray addObject:@"1"];
//    [ansArray addObject:@"2"];
//     [ansArray addObject:@"3"];
//     [ansArray addObject:@"4"];
//     [ansArray addObject:@"5"];
    
    for (int i = 0; i< [ansArray count]; i++) {
        dataForSection[i]=[NSString stringWithFormat:@"%@",[ansArray objectAtIndex:i]];
        NSLog(@"dataForSection[i] = %@",dataForSection[i]);
    }
    
    
    demoData = [[NSMutableArray alloc] init];
  
//    [demoData addObject:@"One"];
//    [demoData addObject:@"Two"];
//    [demoData addObject:@"Three"];
//    [demoData addObject:@"Four"];
//    [demoData addObject:@"Five"];
    
   
    isShowingList = NO;
    
     selectedValueIndex = 0;
    
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
    titleLabel.text = @"FAQ & HELP";
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
-(void)fetchAllData
{
     [activityIndicator1 startAnimating];
    
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		NSString* post = [NSString stringWithFormat:@"http://apps.medialabs24x7.com/besharam/fetch_data_all_faq_ios.php?deviceno=23232"];
		
		
		
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:post] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
		
		
		
		[request setHTTPMethod:@"GET"];
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
		NSError *errorReturned = nil;
		NSURLResponse *theResponse =[[NSURLResponse alloc]init];
		NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&errorReturned];
		
		
		if (errorReturned) {
			NSLog(@"errorReturned=%@",errorReturned);
		          
            //			UIAlertView* alertBox = [[ UIAlertView alloc]initWithTitle:@"Network Error" message:@"Network Not Connected" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Retry", nil ];
            //			alertBox.tag=3;
            //			alertBox.delegate=self;
            //			[alertBox show];
			
			
			
		}
		else
		{
			
			
			
			
			NSError* error;
			NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data //1
                                                                 options:kNilOptions
                                                                   error:&error];
			
			
			//		NSURLResponse *response;
			//		NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
			//		NSString *stringResponse = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
			//		NSLog(@"response1=%@",stringResponse);
			//
			//		//
			//		////
			//		NSArray *responseDict = [stringResponse JSONValue];
			
			//	for (NSDictionary *actoAgent in responseDict){
			
			
			// NSLog(@"json: %@", json); //3
			
			
			
			
			//for (NSDictionary *actoAgent in responseDict){
			
			NSLog(@"json=%@",json);
			
			
       			int i=0;
			for (NSDictionary *actoAgent in json)
			{
                
				data1[i] =[actoAgent objectForKey:@"title"];
				NSLog(@"title=%@", data1[i]);
				[demoData addObject:data1[i]];
				
				data2[i] =[actoAgent objectForKey:@"faq1"];
				NSLog(@"faq1=%@", data2[i]);
				[ansArray addObject:data2[i]];
             				
				i++;
			}
				
		}
       

		dispatch_async(dispatch_get_main_queue()	, ^{
			       [faqTable reloadData];
		});
		
	});
   [self performSelector:@selector(loadTableView) withObject:nil afterDelay:1.5];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [demoData count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//      if (section == 0 || section == 2) {
//        return 1;
//    }
//    else{
    
        if (!isShowingList) {
            return 1;
        }
        else{
            return 2;
        }
   // }
    
}


// Add header titles in sections.
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
////    if (section == 0) {
////        return @"My first section";
////    }
////    else if (section == 1){
////        return @"My demo section";
////    }
////    else{
//        return @"Another section";
// //   }
//}


// Set the row height.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0)
    {
        return 100.0;
    }
    else
    {
//        CGSize maximumLabelSize = CGSizeMake(694, 9000);
//        
//        CGSize expectedLabelSize = [[ansArray objectAtIndex:indexPath.row] sizeWithFont:[UIFont fontWithName:@"Marker Felt" size:16.0] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
//     
//        NSLog(@"height-=%f",expectedLabelSize.height);
//        
//        return expectedLabelSize.height;
        return 250;
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [[cell textLabel] setFont:[UIFont fontWithName:@"Marker Felt" size:16.0]];
    cell.textLabel.numberOfLines = 20;
    
    //    if ([indexPath section] == 0) {
    //        [[cell textLabel] setText:dataForSection0];
    //    }
    //    else if ([indexPath section] == 2){
    //        [[cell textLabel] setText:dataForSection2];
    //    }
    //    else{
    NSLog(@"selectedValueIndex in cellForRow=%d",selectedValueIndex);
  
    if (!isShowingList) {
        
        [[cell textLabel] setText:[demoData objectAtIndex:indexPath.section]];
        cell.imageView.image = [UIImage imageNamed:@"Untitled-1.png"];
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 100)];
        
        CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
        bgLayer.frame = av.bounds;
        [av.layer insertSublayer:bgLayer atIndex:0];
        
        
        av.layer.cornerRadius = 10.0;
        av.clipsToBounds = YES;
        [av.layer setBorderColor:[self colorWithHexString:@"aaaaaa"].CGColor];
        [av.layer setBorderWidth:1.0];
        av.opaque = NO;
        cell.backgroundView = av;
        cell.textLabel.textColor = [UIColor darkGrayColor];

    }
    else{
       
        if(indexPath.row==0)
        {
            [[cell textLabel] setText:[demoData objectAtIndex:indexPath.section]];
            cell.imageView.image = [UIImage imageNamed:@"Untitled-1.png"];
              cell.backgroundColor = [UIColor clearColor];
            UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 100)];
           
            CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
            bgLayer.frame = av.bounds;
            [av.layer insertSublayer:bgLayer atIndex:0];

         
            av.layer.cornerRadius = 10.0;
            av.clipsToBounds = YES;
            [av.layer setBorderColor:[self colorWithHexString:@"aaaaaa"].CGColor];
            [av.layer setBorderWidth:1.0];
            av.opaque = NO;
            cell.backgroundView = av;
            cell.textLabel.textColor = [UIColor darkGrayColor];
        }
        if(indexPath.row==1)
        {
            [[cell textLabel] setText:[ansArray objectAtIndex:indexPath.section]];
            cell.imageView.image = [UIImage imageNamed:@"arrow.png"];
              cell.backgroundColor = [UIColor clearColor];
            UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 200)];
            av.backgroundColor = [self colorWithHexString:@"e6e6e6"];
            av.layer.cornerRadius = 10.0;
            av.clipsToBounds = YES;
            [av.layer setBorderColor:[self colorWithHexString:@"b8b8b8"].CGColor];
            [av.layer setBorderWidth:1.0];
            av.opaque = NO;
          //  av.image = [UIImage imageNamed:@"location-box.png"];
            cell.backgroundView = av;
            cell.textLabel.textColor = [self colorWithHexString:@"38616d"];
        }
    }
  
    //  }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==0)
    {
        
        if (isShowingList) {
            selectedValueIndex = [indexPath section];
        }
    
    
        isShowingList = !isShowingList;
    
       // NSArray *rowArray = [[NSArray alloc]initWithObjects:indexPath,nil];

       // [faqTable reloadRowsAtIndexPaths:rowArray withRowAnimation:UITableViewRowAnimationFade];
      // [faqTable reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        
        [faqTable reloadData];
  
    }
}




-(void)cameraClicked:(UIButton *)sender
{
    if(sender.tag == 2)
    {
        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
        [self.navigationController pushViewController:addNote animated:YES];
    }
    else
    {
            CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
            openCamera.navTagFromHome = sender.tag;
            [self.navigationController pushViewController:openCamera animated:YES];
        
        
//        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
//        addNote.SHORTCUTCLICKED=@"1";
//        [self.navigationController pushViewController:addNote animated:YES];
        
    }
}

-(void)done
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadTableView
{
   
    [faqTable reloadData];
    [activityIndicator1 stopAnimating];
    activityIndicator1.alpha = 0.0;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    
    [self performSelector:@selector(fetchAllData) withObject:nil afterDelay:0.0];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    
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
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        underlineImage.frame = CGRectMake(0, 40, 1024, 1);
        faqTable.frame = CGRectMake(20, 11, 984, 682);
        
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        underlineImage.frame = CGRectMake(0, 40, 768, 1);
        faqTable.frame = CGRectMake(20, 11, 728, 941);
        
    }

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
// iOS 6 autorotation fix
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
        underlineImage.frame = CGRectMake(0, 40, 1024, 1);
        faqTable.frame = CGRectMake(20, 11, 984, 682);
       
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
              self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
            underlineImage.frame = CGRectMake(0, 40, 768, 1);
             faqTable.frame = CGRectMake(20, 11, 728, 941);
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
