//
//  CreateAccount.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 03/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "CreateAccount.h"
#import "Reachability.h"
#import "GlobalClass.h"

@interface CreateAccount ()

@end

@implementation CreateAccount
@synthesize swipeRight,swipeLeft,backButton;

@synthesize firstName,lastName,emailId,sendActivationBtn,password,confirmPassword,signUpbgView;

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
    
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreen:)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    swipeRight.delegate = (id<UIGestureRecognizerDelegate>)self;
    [swipeRight setEnabled:YES];
    
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreen:)];
    [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    swipeLeft.delegate = (id<UIGestureRecognizerDelegate>)self;
    [swipeLeft setEnabled:YES];
    
    [self.view addGestureRecognizer:swipeRight];
    [self.view addGestureRecognizer:swipeLeft];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)swipedScreen:(UISwipeGestureRecognizer*)gesture
{
    if (gesture == swipeLeft )
    {
        NSLog(@"Left");

        
    }
    
    if (gesture == swipeRight ){
        NSLog(@"Right");
        [self.navigationController popViewControllerAnimated:YES];

    }
    
    
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
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        int currSysVerInInt = [currSysVer intValue];
        if(currSysVerInInt >= 7)
        {
            self.view.frame = CGRectMake(0, 20, 1024, 748);
        }
        else if(currSysVerInInt < 7)
        {
            
        }
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"regi_bg_v.jpg"]];
        
        signUpbgView.frame = CGRectMake(258, 355, 483, 344);
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        int currSysVerInInt = [currSysVer intValue];
        if(currSysVerInInt >= 7)
        {
             self.view.frame = CGRectMake(0, 20, 768, 1004);
        }
        else if(currSysVerInInt < 7)
        {
           
        }
       
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"regi_bg.jpg"]];
        
        signUpbgView.frame = CGRectMake(143, 503, 483, 344);
        
        
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
    
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [emailId resignFirstResponder];
    [password resignFirstResponder];
    [confirmPassword resignFirstResponder];
    
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"regi_bg_v.jpg"]];
        signUpbgView.frame = CGRectMake(258, 355, 483, 344);

    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"regi_bg.jpg"]];
        signUpbgView.frame = CGRectMake(143, 503, 483, 344);
        
    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    
    if(ori == UIInterfaceOrientationLandscapeRight |ori == UIInterfaceOrientationLandscapeLeft)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     -320,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    else if(ori == UIInterfaceOrientationPortrait |ori == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     -150,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    NSLog(@"currSysVer = %@",currSysVer);
    
    int currSysVerInInt = [currSysVer intValue];
    NSLog(@"currSysVerInInt = %d",currSysVerInInt);
    
    if(currSysVerInInt >= 7)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     20,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    else if(currSysVerInInt < 7)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     0,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
        
    }
  
    
    
    [UIView commitAnimations];
    
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
	return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
     [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)generateRandomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}



- (IBAction)sendActivationBtn:(id)sender
{
   // [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:2] animated:YES];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self validateEmailWithString:emailId.text];
            
            if (stricterFilter ) {
                
                if (password.text.length >0 ) {
                    
                    if ([password.text isEqualToString:confirmPassword.text]) {
                        
                        NSDate   *tempDate = [[NSDate alloc] init];
                        
                        v_key = [self generateRandomString:6];
                        
                        
                        NSString *post = [NSString stringWithFormat:@"email=%@&password=%@&f_name=%@&l_name=%@&active=%@&created_date=%@&verification_key=%@",emailId.text,password.text,firstName.text,lastName.text,@"0",tempDate,v_key];
                        
                        NSLog(@"post=%@",post);
                        
                        [self ValidateLogin:post];
                        
                        //      [self.navigationController popToRootViewControllerAnimated:YES];
                        
                        
                        
                    }
                    
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password do not match" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
                        [alert show];
                        
                        
                    }
                }
                
                
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password cannot be blank" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
                    [alert show];
                }
            }
            
            else if (!stricterFilter) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Email in XYZ@abc.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
                [alert show];
                
            }
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
    
    
    }

-(void)ValidateLogin:(NSString *)post
{
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"null",@"null"];
	
    
	
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"1234567890",@"rohan.k@skiusainc.com"];
	NSLog(@"POST=%@",post);
	
    //	dispatch_async(dispatch_get_main_queue()	, ^{
	
    
	
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/saveuser"]]];
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
    
 //   NSDate   *tempDate = [[NSDate alloc] init];
    
    
    
//
//    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO ba_tbl_user (id , email , password , f_name,l_name , device , last_login , active , created_date , verification_key , active_date , old_password , last_modified , created_by , subscribtion_type , user_type, security_pin, password_mod) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",@"1", emailId.text, password.text, firstName.text,lastName.text, @"device",@"last_login",@"0",tempDate,@"verification_key",@"active_date", @"old_password", @"last_modified" , @"Self" , @"individual" , @"individual", @"", @"" ];
//    
//    NSLog(@"query=%@",insertSQL);
    
//    [self saveData:insertSQL];
    

    GlobalClass *OBJ=[GlobalClass getInstance];
    OBJ.fetchall=@"0";
    
		
	for (NSDictionary *actoAgent in responseDict){
		
		NSString  *response1 =[actoAgent objectForKey:@"response"];
		
		
		NSLog(@"responseD=%@",response1);
        
        if ([response1 isEqualToString:@"success"]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Please Check" message:@"Please Check Your Email for Verification" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];


        }
		else
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"User Already Registered" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];

        }

        
		
	}
    
    
    //	});
	
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [firstName resignFirstResponder];
    
    [lastName resignFirstResponder];

    
    
    [emailId resignFirstResponder];
    [password resignFirstResponder];
    [confirmPassword resignFirstResponder];

    
}
- (BOOL)validateEmailWithString:(NSString*)email
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	if( [emailTest evaluateWithObject:email] == YES){
		stricterFilter = TRUE;
		NSLog(@"Match!");
	} else {
		stricterFilter = FALSE;
		NSLog(@"No match!");
		
	}
}
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
