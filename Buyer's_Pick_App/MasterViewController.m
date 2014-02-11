//
//  MasterViewController.m
//  MasterDetail


#import "MasterViewController.h"
#import "CameraAudioVideoNote.h"
#import "HomeViewController.h"
#import "AddNote.h"
#import "MyAccount.h"
#import "AppDelegate.h"
#import "MyProfile.h"
#import "SearchByTag.h"
#import "DatabaseClass.h"
#import "GlobalClass.h"
#import "CardScanner.h"


#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)


@interface MasterViewController ()

@property NSMutableArray *menus;

@end

@implementation MasterViewController
@synthesize dataBase;
@synthesize menus = _menus,userPic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movePencil) name:@"MovePencil" object:nil];
    self.tableView.backgroundColor = [self colorWithHexString:@"154049"];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.menus = [[NSMutableArray alloc]init];
    [self.menus addObject:@"allvendors.jpg"];
    [self.menus addObject:@"creatnewvendor.jpg"];
    [self.menus addObject:@"camera.jpg"];
    [self.menus addObject:@"voice_rec1.jpg"];
    [self.menus addObject:@"card_scan.jpg"];
    [self.menus addObject:@"qrcode.jpg"];
    [self.menus addObject:@"search.jpg"];
    [self.menus addObject:@"myshare.jpg"];
    [self.menus addObject:@"mytag.jpg"];
    [self.menus addObject:@"my_industries.jpg"];
    [self.menus addObject:@"myaccount.jpg"];
    [self.menus addObject:@"space.jpg"];
    [self.menus addObject:@"signout.jpg"];
    
   dataBase = [[DatabaseClass alloc]init];
    [dataBase DATABASECALLED];
    NSString   *fetchdata = [NSString stringWithFormat:@"select f_name , email, l_name  from ba_tbl_user"];
    [dataBase getProfileDetails:fetchdata];
     NSLog(@"dataBase.userName = %@",dataBase.userName);
}


-(void)movePencil
{
    NSLog(@"First one got ");
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    userPic.image = nil;
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSData *myPictureData = [standardUserDefaults dataForKey:@"profilePicture"];
    userPic.image = [UIImage imageWithData:myPictureData];

    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    NSLog(@"currSysVer = %@",currSysVer);
    
    int currSysVerInInt = [currSysVer intValue];
    NSLog(@"currSysVerInInt = %d",currSysVerInInt);

    UIInterfaceOrientation ori =  [[UIApplication sharedApplication] statusBarOrientation];
    if(ori==UIInterfaceOrientationPortrait |ori == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        if(currSysVerInInt >= 7)
        {
             self.view.frame = CGRectMake(0, 0, 192, 1024);
            self.tableView.frame =CGRectMake(0, 0, 192, 1024);

        }
        else if(currSysVerInInt < 7)
        {
           self.view.frame = CGRectMake(0, -20, 192, 1024);
            self.tableView.frame =CGRectMake(0, -20, 192, 1024);

            
        }
        

        
    }
    else if(ori ==UIInterfaceOrientationLandscapeRight | ori == UIInterfaceOrientationLandscapeLeft)
    {
       
        
        if(currSysVerInInt >= 7)
        {
            self.view.frame = CGRectMake(0, 0, 192, 768);
              self.tableView.frame =CGRectMake(0, 0, 192, 768);
        }
        else if(currSysVerInInt < 7)
        {
           self.view.frame = CGRectMake(0, -20, 192, 768);
              self.tableView.frame =CGRectMake(0, -20, 192, 768);
            
        }


       
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self performSelector:@selector(movePencil) withObject:nil afterDelay:0.0];

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
    
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    NSLog(@"currSysVer = %@",currSysVer);
    
    int currSysVerInInt = [currSysVer intValue];
    NSLog(@"currSysVerInInt = %d",currSysVerInInt);
    
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        if(currSysVerInInt >= 7)
        {
            self.view.frame = CGRectMake(0, 0, 192, 768);
            self.tableView.frame =CGRectMake(0, 0, 192, 768);
        }
        else if(currSysVerInInt < 7)
        {
            self.view.frame = CGRectMake(0, -20, 192, 768);
            self.tableView.frame =CGRectMake(0, -20, 192, 768);
            
        }
        
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        if(currSysVerInInt >= 7)
        {
            self.view.frame = CGRectMake(0, 0, 192, 1024);
            self.tableView.frame =CGRectMake(0, 0, 192, 1024);
            
        }
        else if(currSysVerInInt < 7)
        {
            self.view.frame = CGRectMake(0, -20, 192, 1024);
            self.tableView.frame =CGRectMake(0, -20, 192, 1024);
            
            
        }
        

    }
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];    
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UIImageView *cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 192, 70)];
    cellImage.image =[UIImage imageNamed:[self.menus objectAtIndex:indexPath.row]];
    cell.backgroundView =cellImage;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 192, 150)];
   // view.userInteractionEnabled = NO;
    userPic = [[UIImageView alloc]initWithFrame:CGRectMake(41, 10, 110, 110)];
    userPic.image = nil;
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSData *myPictureData = [standardUserDefaults dataForKey:@"profilePicture"];
    userPic.image = [UIImage imageWithData:myPictureData];

    userPic.layer.cornerRadius = 55.0;
    userPic.clipsToBounds = YES;
    [userPic.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [userPic.layer setBorderWidth:7];
    
    CGAffineTransform rotate =CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
    [userPic setTransform:rotate];
    
    [view addSubview:userPic];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, 192, 18)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor clearColor];
    NSString *myName = [NSString stringWithFormat:@"Welcome "];
    myName = [myName stringByAppendingString:dataBase.userName];
    label.text = myName;
    [view addSubview:label];
    
    [view setBackgroundColor:[self colorWithHexString:@"154049"]];
    
    UITapGestureRecognizer *webViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openclass:)];
    webViewTapped.numberOfTapsRequired = 1;
    webViewTapped.delegate = self;
    [view addGestureRecognizer:webViewTapped];
    
    return view;
}
-(void)openclass:(UITapGestureRecognizer *)sender
{
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    MyProfile *myProfile = [[MyProfile alloc]init];
    myProfile.TAG = @"fromSplitView";
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:myProfile];
    
    [menuController setRootController:navController animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.row == 0)
    {
     
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        HomeViewController *home = [[HomeViewController alloc]init];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:home];
        
        [menuController setRootController:navController animated:YES];

    
       
    }
    else if (indexPath.row == 1)
    {
        
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        AddNote *addNote = [[AddNote alloc]init];
        addNote.TAG = @"fromSplitView";

        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addNote];
        
        [menuController setRootController:navController animated:YES];

    }
    else if (indexPath.row == 2)
    {
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
         CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]init];
         openCamera.navTagFromHome = 0;
        openCamera.TAG = @"fromSplitView";
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:openCamera];
        
        [menuController setRootController:navController animated:YES];
       
    }
    else if (indexPath.row == 3)
    {
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]init];
        openCamera.navTagFromHome = 1;

        openCamera.TAG = @"fromSplitView";
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:openCamera];
        
        [menuController setRootController:navController animated:YES];
       
    }
    else if (indexPath.row == 4)
    {
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        CardScanner *cardScanner = [[CardScanner alloc]init];
      
        cardScanner.TAG = @"fromSplitView";
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cardScanner];
        
        [menuController setRootController:navController animated:YES];
        
    }

    
    else if (indexPath.row == 6)
    {
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        SearchByTag *search = [[SearchByTag alloc]init];
        search.TAG = @"fromSplitView";
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:search];
        
        [menuController setRootController:navController animated:YES];
        
        
    }

    else if (indexPath.row == 10)
    {
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        MyAccount *myAccount = [[MyAccount alloc]init];
            myAccount.TAG = @"fromSplitView";
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:myAccount];
        
        [menuController setRootController:navController animated:YES];

        
    }
    
    
    else if (indexPath.row == 12)
    {
        DatabaseClass   *db = [[DatabaseClass alloc] init];
        [db DATABASECALLED];
        NSString *insertSQL11 = [NSString stringWithFormat:@"delete from ba_tbl_user where id =1"];
        
        [db saveData:insertSQL11];
        
        
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        HomeViewController *home = [[HomeViewController alloc]init];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:home];
        
        [menuController setRootController:navController animated:YES];
        
        
    }

    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0||indexPath.row==1||indexPath.row==2||indexPath.row==3||indexPath.row==4||indexPath.row==5)
    {
        return 70;
    }
    if(indexPath.row ==6)
    {
        return 152;
    }
     if (indexPath.row==7)
     {
         return 48;
     }
    if (indexPath.row==8||indexPath.row==9)
    {
        return 41;
    }
       if (indexPath.row==10 ||indexPath.row==12)
    {
        return 36;
    }
       else
        return 77;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];

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
