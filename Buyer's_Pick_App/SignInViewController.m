//
//  SignInViewController.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 03/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "SignInViewController.h"
#import "Reachability.h"
#import "GlobalClass.h"

@interface SignInViewController ()

@end

@implementation SignInViewController
@synthesize emailIdTextField,passwordTextField,signInButton,signUpbgView,forgetPswdBgView,Forgetpwd,submitBtn,closePopUpButton,forgetPswdBgImage,popUpview,resendOrForgotLabel,keyImage,noteLabel,textFldBgImage;
@synthesize swipeRight,swipeLeft,backButton;

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
    forgetPswdBgView.alpha = 0.0;
    
    popUpview.layer.cornerRadius = 7.0;
    popUpview.clipsToBounds = YES;
    
    textFldBgImage.layer.cornerRadius = 5.0;
    textFldBgImage.clipsToBounds = YES;
    
    [textFldBgImage.layer setBorderColor:[UIColor grayColor].CGColor];
    [textFldBgImage.layer setBorderWidth:1];

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
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg_v.jpg"]];
        
        signUpbgView.frame = CGRectMake(279, 348, 455, 339);
        forgetPswdBgView.frame = CGRectMake(0, 0, 1024, 748);
        forgetPswdBgImage.frame = CGRectMake(0, 0, 1024, 748);
        popUpview.frame = CGRectMake(280, 252, 475, 244);
        
        
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
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.jpg"]];
        
        signUpbgView.frame = CGRectMake(152, 505, 455, 339);
        forgetPswdBgView.frame = CGRectMake(0, 0, 768, 1004);
        forgetPswdBgImage.frame = CGRectMake(0, 0, 768, 1004);
        popUpview.frame = CGRectMake(147, 380, 475, 244);
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
       
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg_v.jpg"]];
        
        signUpbgView.frame = CGRectMake(279, 348, 455, 339);
        forgetPswdBgView.frame = CGRectMake(0, 0, 1024, 748);
        forgetPswdBgImage.frame = CGRectMake(0, 0, 1024, 748);
        popUpview.frame = CGRectMake(280, 252, 475, 244);
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
       
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.jpg"]];
        signUpbgView.frame = CGRectMake(152, 505, 455, 339);
        forgetPswdBgView.frame = CGRectMake(0, 0, 768, 1004);
        forgetPswdBgImage.frame = CGRectMake(0, 0, 768, 1004);
        popUpview.frame = CGRectMake(147, 380, 475, 244);

    }
    
    [emailIdTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
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
                                     -290,
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

- (IBAction)signInButton:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self validateEmailWithString:emailIdTextField.text];
            
            if (stricterFilter) {
                
                
                if (passwordTextField.text.length >0 && emailIdTextField.text.length>0) {
                    
                    
                    NSString *post = [NSString stringWithFormat:@"email=%@&password=%@&active=%@",emailIdTextField.text,passwordTextField.text,@"0"];
                    NSLog(@"post=%@",post);
                    NSString *uid = [[NSUserDefaults standardUserDefaults] stringForKey:@"userID"];
                    
                    NSString *insertSQL11 = [NSString stringWithFormat:@"select active from ba_tbl_user where id = %@",uid];
                    
                    [self displayAll:insertSQL11];
                    
                    
                    
                    
                    if ([MobileNo isEqualToString:@"0"])
                    {
                        
                        [self ValidateLogin:post];
                        
                        
                    }
                    else
                    {
                        
                        [self DataPresentValidateLogin:post];
                        
                    }
                    
                    
                    
                }
                
                
                else{
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [emailIdTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
//    [self.navigationController popViewControllerAnimated:YES];

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
            
            NSString  *response =[actoAgent objectForKey:@"response"];
            
            if ([response isEqualToString:@"fail"]) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"User not regestered, Please Sign up" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
                [alert show];

                
            }
            
            else{
            
            
    		NSString  *response1 =[actoAgent objectForKey:@"active"];
            NSString  *responseid =[actoAgent objectForKey:@"id"];

    		NSLog(@"responseD=%@",response1);
           
//            if (response1!=nil) {
          
        if ([response1 isEqualToString:@"1"])
            {
                [[NSUserDefaults standardUserDefaults] setObject:responseid forKey:@"userID"];

            NSString *insertSQL = [NSString stringWithFormat:@"update ba_tbl_user set active = %@ , id=\"%@\" where id = 1",responseid,@"1"];
            [self saveData:insertSQL];
                
                NSString *insertSQL1 = [NSString stringWithFormat:@"select password from ba_tbl_user where id = 1"];
                
                [self displayAll:insertSQL1];
                
                
                if ([MobileNo isEqualToString:passwordTextField.text]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                }
                
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password Incorrect" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
                    alert.tag = 5;
                    [alert show];
                    
                }


//            }
//            
//            else
//            {
//                NSLog(@"no entry");
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please verify your account" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
//                [alert show];
//                
//                [self performSelector:@selector(verificationcode:) withObject:nil afterDelay:0.0];
//            }

    	}
            
       }
     }
    
}


-(void)DataPresentValidateLogin:(NSString *)post
{
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"null",@"null"];
	
    
	
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"1234567890",@"rohan.k@skiusainc.com"];
	NSLog(@"POST=%@",post);
	
    //	dispatch_async(dispatch_get_main_queue()	, ^{
	
    
	
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/senduserdata"]]];
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
    
    
//    NSString   *str;
//    for (NSDictionary *actoAgent in responseDict)
//    {
//        str= [actoAgent objectForKey:@"response"];
//        NSLog(@"res=%@",str);
//        
//    }

    
    for (NSDictionary *actoAgent in responseDict){
        
        
        NSString  *response1 =[actoAgent objectForKey:@"response"];
        
        if ([response1 isEqualToString:@"fail"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"User not regestered, Please Sign up" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];
            
            
            
        }
        
        
        else{

        NSString  *response1 =[actoAgent objectForKey:@"active"];
        
        NSLog(@"responseD=%@",response1);
        

        
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO ba_tbl_user (id , email , password , f_name,l_name , device , last_login , active , created_date , verification_key , active_date , old_password , last_modified , created_by , subscribtion_type , user_type, security_pin, password_mod) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[actoAgent objectForKey:@"id"], [actoAgent objectForKey:@"email"], [actoAgent objectForKey:@"password"], [actoAgent objectForKey:@"f_name"],[actoAgent objectForKey:@"l_name"], @"device",@"last_login",[actoAgent objectForKey:@"active"],[actoAgent objectForKey:@"created_date"],[actoAgent objectForKey:@"verification_key"],[actoAgent objectForKey:@"active_date"], [actoAgent objectForKey:@"old_password"], [actoAgent objectForKey:@"last_modified"] , [actoAgent objectForKey:@"created_by"] , [actoAgent objectForKey:@"subscription_type"] , [actoAgent objectForKey:@"user_type"], [actoAgent objectForKey:@"security_pin"], [actoAgent objectForKey:@"password_mod"]];
        
        NSLog(@"query=%@",insertSQL);
        
        [self saveData:insertSQL];
            
            [[NSUserDefaults standardUserDefaults] setObject:[actoAgent objectForKey:@"id"] forKey:@"userID"];
            
            

            NSString *insertSQL1 = [NSString stringWithFormat:@"select password from ba_tbl_user where id = %@",[actoAgent objectForKey:@"id"]];
            
            [self displayAll:insertSQL1];
            
            
            if ([MobileNo isEqualToString:passwordTextField.text]) {
                
                
                
                NSString *insertSQL11 = [NSString stringWithFormat:@"select active from ba_tbl_user where id = %@",[actoAgent objectForKey:@"id"]];
                
                [self displayAll:insertSQL11];
                
                
                
                
                if ([MobileNo isEqualToString:@"0"])
                {
                    
                    [self performSelector:@selector(verificationcode:) withObject:nil afterDelay:0.0];
                    
                }
                
                else
                {
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                
                
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password Incorrect" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
                alert.tag = 5;
                [alert show];
                
            }

        }
    
    
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"User not regestered, Please Sign up" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
//            [alert show];
//            
//        }
        


    }
    
   
    
   

}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (alertView.tag==5) {
//        NSString *insertSQL11 = [NSString stringWithFormat:@"delete from ba_tbl_user where id =1"];
//        
//        [self saveData:insertSQL11];
//    }
//}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==5) {
        NSString *insertSQL11 = [NSString stringWithFormat:@"delete from ba_tbl_user where id =1"];
        
        [self saveData:insertSQL11];
    }

    
   /* if (alertView.tag==1) {
        if (buttonIndex == 0) {
            
        }
        
        else{
        [self validateEmailWithString:Forgetpwd.text];
            v_key = [self generateRandomString:10];

        
        if (stricterFilter ) {
            
            
            NSString *post = [NSString stringWithFormat:@"email=%@",Forgetpwd.text];
            
            
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/forgotpassemail"]]];
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
            
            
            
            
        }
        
        else if (!stricterFilter) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Email in XYZ@abc.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];
            
        }
        
        
    }
    }
    if (alertView.tag==2) {
        
        if (buttonIndex == 0) {
            
        }
        
        else{

        [self validateEmailWithString:Forgetpwd.text];
        
        
        if (stricterFilter ) {
            v_key = [self generateRandomString:10];

            
            NSString *post = [NSString stringWithFormat:@"email=%@&verification_key=%@",Forgetpwd.text,v_key];
            
            
            NSLog(@"post=%@",post);
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/resendactivation"]]];
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
            
            
            
            
        }
        
        else if (!stricterFilter) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Email in XYZ@abc.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];
            
        }
        
        
    }
    }*/
}
//-(IBAction)FORGETPASSWORD:(id)sender
//{
//    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Forget Password" message:@"Please Enter your Email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    
//    Forgetpwd = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 50.0, 260.0, 25.0)];
//    Forgetpwd.tag=1;
//    Forgetpwd.borderStyle=UITextBorderStyleRoundedRect;
//    Forgetpwd.delegate=self;
//    alert.tag=1;
//    [alert addSubview:Forgetpwd];
//}




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

- (IBAction)forgotPassword:(id)sender {
    NSLog(@"f");
    [self performSelector:@selector(changeView) withObject:nil afterDelay:0.0];

  
//    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Forget Password" message:@"Please Enter your Email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    
//    Forgetpwd = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 50.0, 260.0, 25.0)];
//    Forgetpwd.tag=1;
//    Forgetpwd.borderStyle=UITextBorderStyleRoundedRect;
//    Forgetpwd.placeholder=@"Pleae Enter Your Email Id";
//    Forgetpwd.delegate=self;
//    alert.tag=1;
//    [alert addSubview:Forgetpwd];
//    [alert show];
    
    submitBtn.tag = 1;
    noteLabel.text = @" ";
    resendOrForgotLabel.text = @" ";
    
     forgetPswdBgView.alpha = 1.0;
    noteLabel.text = @"Enter your email address here to receive a link to change password.";
    resendOrForgotLabel.text = @"Forgot Password";
    keyImage.image = [UIImage imageNamed:@"keyicon.png"];
}

- (IBAction)resendActivationEmail:(id)sender {
    
    [self performSelector:@selector(changeView) withObject:nil afterDelay:0.0];

//    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Resent Activation Email" message:@"Please Enter your Email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    
//    Forgetpwd = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 50.0, 260.0, 25.0)];
//    Forgetpwd.tag=2;
//    Forgetpwd.borderStyle=UITextBorderStyleRoundedRect;
//    Forgetpwd.placeholder=@"Pleae Enter Your Email Id";
//    Forgetpwd.delegate=self;
//    alert.tag=2;
//    [alert addSubview:Forgetpwd];
//    [alert show];
   
    submitBtn.tag = 2;
    noteLabel.text = @" ";
    resendOrForgotLabel.text = @" ";
    
    forgetPswdBgView.alpha = 1.0;
    noteLabel.text = @"Enter your email address here to receive a your activation code.";
    resendOrForgotLabel.text = @"Resend Activation Code";
    keyImage.image = [UIImage imageNamed:@"resend.png"];
}

- (IBAction)verificationcode:(id)sender {
    
    
    submitBtn.tag = 3;
    noteLabel.text = @" ";
    resendOrForgotLabel.text = @" ";
    Forgetpwd.placeholder=@"Enter activation code";
    forgetPswdBgView.alpha = 1.0;
    noteLabel.text = @"Please Enter activation code which you have received on your email.";
    resendOrForgotLabel.text = @"Enter Activation Code";
    keyImage.image = [UIImage imageNamed:@"resend.png"];
}


-(NSString*)generateRandomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}

- (IBAction)closePopUpButton:(id)sender {
     forgetPswdBgView.alpha = 0.0;
}
- (IBAction)submitBtn:(id)sender {
     forgetPswdBgView.alpha = 0.0;
    if(submitBtn.tag == 1)
    {
         NSLog(@"submitbtn.tag = %d",submitBtn.tag);
    [self validateEmailWithString:Forgetpwd.text];
    v_key = [self generateRandomString:6];
    
    
    if (stricterFilter ) {
        
        
        NSString *post = [NSString stringWithFormat:@"email=%@",Forgetpwd.text];
        
        
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/forgotpassemail"]]];
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
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Please check Your Email" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
        [alert show];

        
    }
    
    else if (!stricterFilter) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Email in XYZ@abc.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
        [alert show];
        
    }
    
    }
    if(submitBtn.tag == 2)
    {
        NSLog(@"submitbtn.tag = %d",submitBtn.tag);
        [self validateEmailWithString:Forgetpwd.text];
        
        
        if (stricterFilter ) {
            v_key = [self generateRandomString:6];
            
            
            NSString *post = [NSString stringWithFormat:@"email=%@&verification_key=%@",Forgetpwd.text,v_key];
            
            
            NSLog(@"post=%@",post);
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/resendactivation"]]];
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
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Please check Your Email" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];

        
            [self performSelector:@selector(verificationcode:) withObject:nil afterDelay:0.0];

        }
        
        else if (!stricterFilter) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Email in XYZ@abc.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];
            
        }
        
        
    
  
    }
    

    
    if(submitBtn.tag == 3)
    {
        NSLog(@"submitbtn.tag = %d",submitBtn.tag);
        [self validateEmailWithString:emailIdTextField.text];
        
        
        if (stricterFilter ) {
            v_key = [self generateRandomString:6];
        
            
            NSString *post = [NSString stringWithFormat:@"email=%@&verification_key=%@",emailIdTextField.text,Forgetpwd.text];
            
            
            NSLog(@"post=%@",post);
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/verificationcodeverify"]]];
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
            
            for (NSDictionary *actoAgent in responseDict){
                
                
                NSString  *response1 =[actoAgent objectForKey:@"active"];
                
                NSLog(@"responseD=%@",response1);
                
                
                    if ([response1 isEqualToString:@"1"])
                    {
                        
                        NSString *insertSQL = [NSString stringWithFormat:@"update ba_tbl_user set active = %@ where id = 1",@"1"];
                        [self saveData:insertSQL];
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                            

            }
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"Activation code Incorrect" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
                        [alert show];
                        
                        [self performSelector:@selector(verificationcode:) withObject:nil afterDelay:0.0];

                    }
    
            }
        }
        
        else if (!stricterFilter) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Email in XYZ@abc.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];
            
        }
        
        
    }

    
    
    Forgetpwd.text=@"";
    
    [Forgetpwd resignFirstResponder];
}
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
