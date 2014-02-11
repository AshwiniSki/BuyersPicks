//
//  LockVendor.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 27/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "LockVendor.h"
#import "OpenVendor.h"

@interface LockVendor ()

@end

@implementation LockVendor
@synthesize MainBgView,headerImage,lockImage,closeButton,backgroundImage,enterSecurePINView,pinLabel1,pinLabel2,pinLabel3,pinLabel4,pinTitle,keyBoardView;

@synthesize pinLabel1Str,pinLabel2Str,pinLabel3Str,pinLabel4Str,pinLableCounter,enterPinStr,pinCheck;

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
    
    MainBgView.layer.cornerRadius = 10.0;
    MainBgView.clipsToBounds = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self checkSecurePIN];
    [self performSelector:@selector(changeView) withObject:nil afterDelay:0.0];
}
-(void)checkSecurePIN
{
    NSString   *fetchdata = [NSString stringWithFormat:@"select security_pin from ba_tbl_user where id=1"];
    [self displayAll:fetchdata];
    pinCheck=MobileNo;
    NSLog(@"pinCheck = %@",pinCheck);
    
    
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
        
        backgroundImage.frame = CGRectMake(0, 0, 1024, 748);
        MainBgView.frame = CGRectMake(381, 172, 262, 403);
        
        
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        
        backgroundImage.frame = CGRectMake(0, 0, 768, 1004);
        MainBgView.frame = CGRectMake(253, 297, 262, 403);
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
        backgroundImage.frame = CGRectMake(0, 0, 1024, 748);
        MainBgView.frame = CGRectMake(381, 172, 262, 403);
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        backgroundImage.frame = CGRectMake(0, 0, 768, 1004);
        MainBgView.frame = CGRectMake(253, 297, 262, 403);
        
    }
    
    
}


- (IBAction)closeButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)keyboardBtnPressed:(UIButton *)sender
{
    NSLog(@"pinLableCounter1 %d",pinLableCounter);
    pinLableCounter=pinLableCounter+1;
    NSLog(@"pinLableCounter2 %d",pinLableCounter);
    if (sender.tag==0) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"*";
            pinLabel1Str=@"0";
        }
        if (pinLableCounter==2) {
            pinLabel2.text=@"*";
            pinLabel2Str=@"0";
        }
        if (pinLableCounter==3) {
            pinLabel3.text=@"*";
            pinLabel3Str=@"0";
        }
        if (pinLableCounter==4) {
            pinLabel4.text=@"*";
            pinLabel4Str=@"0";
        }
        
    }
    if (sender.tag==1) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"*";
            pinLabel1Str=@"1";
        }
        if (pinLableCounter==2) {
            pinLabel2.text=@"*";
            pinLabel2Str=@"1";
        }
        if (pinLableCounter==3) {
            pinLabel3.text=@"*";
            pinLabel3Str=@"1";
        }
        if (pinLableCounter==4) {
            pinLabel4.text=@"*";
            pinLabel4Str=@"1";
        }
        
    }
    if (sender.tag==2) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"*";
            pinLabel1Str=@"2";
        }
        if (pinLableCounter==2) {
            pinLabel2.text=@"*";
            pinLabel2Str=@"2";
        }
        if (pinLableCounter==3) {
            pinLabel3.text=@"*";
            pinLabel3Str=@"2";
        }
        if (pinLableCounter==4) {
            pinLabel4.text=@"*";
            pinLabel4Str=@"2";
        }
        
    }
    if (sender.tag==3) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"*";
            pinLabel1Str=@"3";
        }
        if (pinLableCounter==2) {
            pinLabel2.text=@"*";
            pinLabel2Str=@"3";
        }
        if (pinLableCounter==3) {
            pinLabel3.text=@"*";
            pinLabel3Str=@"3";
        }
        if (pinLableCounter==4) {
            pinLabel4.text=@"*";
            pinLabel4Str=@"3";
        }
        
    }
    if (sender.tag==4) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"*";
            pinLabel1Str=@"4";
            
        }
        if (pinLableCounter==2) {
            pinLabel2.text=@"*";
            pinLabel2Str=@"4";
        }
        if (pinLableCounter==3) {
            pinLabel3.text=@"*";
            pinLabel3Str=@"4";
        }
        if (pinLableCounter==4) {
            pinLabel4.text=@"*";
            pinLabel4Str=@"4";
        }
        
    }
    if (sender.tag==5) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"*";
            pinLabel1Str=@"5";
            
        }
        if (pinLableCounter==2) {
            pinLabel2.text=@"*";
            pinLabel2Str=@"5";
        }
        if (pinLableCounter==3) {
            pinLabel3.text=@"*";
            pinLabel3Str=@"5";
        }
        if (pinLableCounter==4) {
            pinLabel4.text=@"*";
            pinLabel4Str=@"5";
        }
        
    }
    if (sender.tag==6) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"*";
            pinLabel1Str=@"6";
            
        }
        if (pinLableCounter==2) {
            pinLabel2.text=@"*";
            pinLabel2Str=@"6";
        }
        if (pinLableCounter==3) {
            pinLabel3.text=@"*";
            pinLabel3Str=@"6";
        }
        if (pinLableCounter==4) {
            pinLabel4.text=@"*";
            pinLabel4Str=@"6";
        }
        
    }
    if (sender.tag==7) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"*";
            pinLabel1Str=@"7";
            
        }
        if (pinLableCounter==2) {
            pinLabel2.text=@"*";
            pinLabel2Str=@"7";
        }
        if (pinLableCounter==3) {
            pinLabel3.text=@"*";
            pinLabel3Str=@"7";
        }
        if (pinLableCounter==4) {
            pinLabel4.text=@"*";
            pinLabel4Str=@"7";
        }
        
    }
    if (sender.tag==8) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"*";
            pinLabel1Str=@"8";
            
        }
        if (pinLableCounter==2) {
            pinLabel2.text=@"*";
            pinLabel2Str=@"8";
        }
        if (pinLableCounter==3) {
            pinLabel3.text=@"*";
            pinLabel3Str=@"8";
        }
        if (pinLableCounter==4) {
            pinLabel4.text=@"*";
            pinLabel4Str=@"8";
        }
        
    }
    if (sender.tag==9) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"*";
            pinLabel1Str=@"9";
            
        }
        if (pinLableCounter==2) {
            pinLabel2.text=@"*";
            pinLabel2Str=@"9";
        }
        if (pinLableCounter==3) {
            pinLabel3.text=@"*";
            pinLabel3Str=@"9";
        }
        if (pinLableCounter==4) {
            pinLabel4.text=@"*";
            pinLabel4Str=@"9";
        }
        
    }
    if (sender.tag==10) {
        if (pinLableCounter==1) {
            pinLabel1.text=@"";
            pinLabel1Str=@"";
            
        }
        if (pinLableCounter==2) {
            pinLabel1.text=@"";
            pinLabel1Str=@"";
        }
        if (pinLableCounter==3) {
            pinLabel2.text=@"";
            pinLabel2Str=@"";
            
        }
        if (pinLableCounter==4) {
            pinLabel3.text=@"";
            pinLabel3Str=@"";
            
            
        }
        if (pinLableCounter>0) {
            pinLableCounter=pinLableCounter-2;
            
            if (pinLableCounter<0) {
                pinLableCounter=0;
            }
        }
        
    }
    
    if (pinLableCounter==4) {
    [self performSelector:@selector(updateDBpin) withObject:nil afterDelay:0.0];
    }
    
    NSLog(@"pinLableCounter3 %d",pinLableCounter);
}


-(void)updateDBpin
{
    appD=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    if (pinLableCounter==4) {
          enterPinStr=[NSString stringWithFormat:@"%@%@%@%@",pinLabel1Str,pinLabel2Str,pinLabel3Str,pinLabel4Str];
        NSLog(@"Change option pinSavingCounter %d %@  ",pinLableCounter,enterPinStr);
        
        if ([pinCheck isEqualToString:enterPinStr] ) {
            
            if ([appD.lockVendorTag isEqualToString:@"1"]) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"enterIntoOpenVendor" object:nil];

            }
            
        
        if ([appD.lockVendorTag isEqualToString:@"2"]) {
            appD=(AppDelegate *)[[UIApplication sharedApplication]delegate];

            NSString   *insertquery = [NSString stringWithFormat:@"update  ba_tbl_vendor SET security_pin =\"0\" where id =%@",appD.PinCheckvendorid ];
            [self saveData:insertquery];
            NSLog(@"insertquery checkSecurePIN   =%@",insertquery);

          //  [self dismissViewControllerAnimated:YES completion:nil];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !" message:@"Vendor Unlocked ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            }
        }
      
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter Correct PIN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
