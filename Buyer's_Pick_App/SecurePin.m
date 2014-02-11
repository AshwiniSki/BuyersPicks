//
//  SecurePin.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 15/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "SecurePin.h"

@interface SecurePin ()

@end

@implementation SecurePin
@synthesize MainBgView,headerImage,lockImage,closeButton,backgroundImage,createSecurePINView,changeAndRemoveBgView,changePinBtn,removePinBtn,pinLabel1,pinLabel2,pinLabel3,pinLabel4,pinTitle,keyBoardView;
@synthesize pinLableCounter,pinViewCounter,pinCheck,enterPinStr,confirmPinStr,enterOldPinStr,pinTitleCounter,pinSavingCounter;
@synthesize pinLabel1Str,pinLabel2Str,pinLabel3Str,pinLabel4Str;

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
    
    pinLableCounter=0;
    pinTitleCounter=1;
    pinSavingCounter=1;
    
    
    
    createSecurePINView.alpha = 1.0;
    changeAndRemoveBgView.alpha = 0.0;
    
    [self checkSecurePIN];
    if ([pinCheck isEqualToString:@"0"]) {
        pinViewCounter=1;
        changeAndRemoveBgView.alpha=0.0;
        [self setInitialView];
    }
    else
    {
        changeAndRemoveBgView.alpha=1.0;
        createSecurePINView.alpha=0.0;
        keyBoardView.alpha=0.0;
    }
    
}


-(void)checkSecurePIN
{
    NSString   *fetchdata = [NSString stringWithFormat:@"select security_pin from ba_tbl_user where id=1"];
       [self displayAll:fetchdata];
    pinCheck=MobileNo;
    NSLog(@"pinCheck = %@",pinCheck);


}
-(void)setInitialView
{
    if (pinViewCounter==1) {
        if (pinTitleCounter==1) {
            pinTitle.text= @"Set New PIN";
        }
    }
    
    if (pinViewCounter==2) {
        if (pinTitleCounter==1) {
            pinTitle.text= @"Enter Old PIN";
        }
    }
    
    
    if (pinViewCounter==3) {
        if (pinTitleCounter==1) {
            pinTitle.text= @"Enter PIN";
        }
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
            backgroundImage.frame = CGRectMake(0, 0, 1024, 768);
        }
        else if(currSysVerInInt < 7)
        {
            backgroundImage.frame = CGRectMake(0, 0, 1024, 748);
        }
        
        MainBgView.frame = CGRectMake(381, 172, 262, 403);
        
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        int currSysVerInInt = [currSysVer intValue];
        if(currSysVerInInt >= 7)
        {
            backgroundImage.frame = CGRectMake(0, 0, 768, 1024);
        }
        else if(currSysVerInInt < 7)
        {
            backgroundImage.frame = CGRectMake(0, 0, 768, 1004);
        }
        
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
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        int currSysVerInInt = [currSysVer intValue];
        if(currSysVerInInt >= 7)
        {
             backgroundImage.frame = CGRectMake(0, 0, 1024, 768);
        }
        else if(currSysVerInInt < 7)
        {
             backgroundImage.frame = CGRectMake(0, 0, 1024, 748);
        }
       
        MainBgView.frame = CGRectMake(381, 172, 262, 403);
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        int currSysVerInInt = [currSysVer intValue];
        if(currSysVerInInt >= 7)
        {
              backgroundImage.frame = CGRectMake(0, 0, 768, 1024);
        }
        else if(currSysVerInInt < 7)
        {
              backgroundImage.frame = CGRectMake(0, 0, 768, 1004);
        }
      
       MainBgView.frame = CGRectMake(253, 297, 262, 403);
       
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        if (pinLableCounter>0)  {
            pinLableCounter=pinLableCounter-2;
            if (pinLableCounter<0) {
                pinLableCounter=0;
            }
        }
        }
    
  
      [self performSelector:@selector(resetFields) withObject:nil afterDelay:1.0];
   
    NSLog(@"pinLableCounter3 %d",pinLableCounter);
}

-(void)resetFields
{
    if (pinLableCounter==4) {
        pinTitleCounter=pinTitleCounter+1;
        
        if (pinViewCounter==1) {
            if (pinTitleCounter==1)
            {
                //                    pinTitle.text= @"Enter New PIN";
                //                    enterPinStr=[NSString stringWithFormat:@"%@%@%@%@",pinLabel1,pinLabel2,pinLabel3,pinLabel4];
                //                    pinLabel1.text=@"";
                //                    pinLabel2.text=@"";
                //                    pinLabel3.text=@"";
                //                    pinLabel4.text=@"";
                
            }
            
            if (pinTitleCounter==2) {
                
                enterPinStr=[NSString stringWithFormat:@"%@%@%@%@",pinLabel1Str,pinLabel2Str,pinLabel3Str,pinLabel4Str];
                pinLabel1.text=@"";
                pinLabel2.text=@"";
                pinLabel3.text=@"";
                pinLabel4.text=@"";
                pinLabel1Str=@"";
                pinLabel2Str=@"";
                pinLabel3Str=@"";
                pinLabel4Str=@"";
                pinTitle.text= @"Confirm New PIN";
                
            }
            if (pinTitleCounter==3) {
                confirmPinStr=[NSString stringWithFormat:@"%@%@%@%@",pinLabel1Str,pinLabel2Str,pinLabel3Str,pinLabel4Str];
                [self updateDBpin];
            }
        }
        
        if (pinViewCounter==2) {
            if (pinTitleCounter==1) {
                pinTitle.text= @"Enter Old PIN";
            }
            if (pinTitleCounter==2) {
                enterOldPinStr=[NSString stringWithFormat:@"%@%@%@%@",pinLabel1Str,pinLabel2Str,pinLabel3Str,pinLabel4Str];
                pinLabel1.text=@"";
                pinLabel2.text=@"";
                pinLabel3.text=@"";
                pinLabel4.text=@"";
                pinLabel1Str=@"";
                pinLabel2Str=@"";
                pinLabel3Str=@"";
                pinLabel4Str=@"";
                pinTitle.text= @"Enter New PIN";
            }
            if (pinTitleCounter==3) {
                enterPinStr=[NSString stringWithFormat:@"%@%@%@%@",pinLabel1Str,pinLabel2Str,pinLabel3Str,pinLabel4Str];
                pinLabel1.text=@"";
                pinLabel2.text=@"";
                pinLabel3.text=@"";
                pinLabel4.text=@"";
                pinLabel1Str=@"";
                pinLabel2Str=@"";
                pinLabel3Str=@"";
                pinLabel4Str=@"";
                pinTitle.text= @"Confirm New PIN";
            }
            if (pinTitleCounter==4) {
                confirmPinStr=[NSString stringWithFormat:@"%@%@%@%@",pinLabel1Str,pinLabel2Str,pinLabel3Str,pinLabel4Str];
                [self updateDBpin];
                
            }
        }
        
        
        if (pinViewCounter==3) {
            if (pinTitleCounter==1) {
                pinTitle.text= @"Enter new PIN";
            }
            if (pinTitleCounter==2) {
                enterPinStr=[NSString stringWithFormat:@"%@%@%@%@",pinLabel1Str,pinLabel2Str,pinLabel3Str,pinLabel4Str];
                pinLabel1.text=@"";
                pinLabel2.text=@"";
                pinLabel3.text=@"";
                pinLabel4.text=@"";
                pinLabel1Str=@"";
                pinLabel2Str=@"";
                pinLabel3Str=@"";
                pinLabel4Str=@"";
                [self updateDBpin];
                
            }
            if (pinTitleCounter==3) {
                
            }
        }
        
        pinLableCounter=0;
    }

}

- (IBAction)changePinBtn:(UIButton *)sender
{
    pinViewCounter=2;
    pinSavingCounter=2;
    keyBoardView.alpha=1.0;
    changeAndRemoveBgView.alpha=0.0;
    createSecurePINView.alpha=1.0;
    [self setInitialView];
}
- (IBAction)removePinBtn:(UIButton *)sender
{
     pinViewCounter=3;
    pinSavingCounter=3;
    keyBoardView.alpha=1.0;
     changeAndRemoveBgView.alpha=0.0;
    createSecurePINView.alpha=1.0;
   [self setInitialView];
}

-(void)updateDBpin
{
    if (pinSavingCounter==1) {
        NSLog(@"Change option pinSavingCounter %d %@ %@ ",pinSavingCounter,enterPinStr,confirmPinStr);
    if ([enterPinStr isEqualToString:confirmPinStr]) {
        
    NSString   *insertquery = [NSString stringWithFormat:@"update  ba_tbl_user SET security_pin =\"%@\" where id =1" ,confirmPinStr ];
    [self saveData:insertquery];
        
        if ([appD.lockVendorTag isEqualToString:@"2"]) {
        
        appD=(AppDelegate *) [[UIApplication sharedApplication]delegate];
        NSString   *insertquery1 = [NSString stringWithFormat:@"update  ba_tbl_vendor SET security_pin =\"1\" where id =%@" ,appD.PinCheckvendorid ];
        [self saveData:insertquery1];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !" message:@" PIN set sucessfully & Vendor Locked " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
       // [self dismissViewControllerAnimated:YES completion:nil];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !" message:@" PIN set sucessfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        alert.tag=1;
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter Correct PIN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    }
    if (pinSavingCounter==2) {
         NSLog(@"Change option pinSavingCounter %d %@ %@ %@ %@",pinSavingCounter,enterPinStr,confirmPinStr,enterOldPinStr,pinCheck);
        if ([enterPinStr isEqualToString:confirmPinStr])
        {
            if ([pinCheck isEqualToString:enterOldPinStr])
            {
            
            NSString   *insertquery = [NSString stringWithFormat:@"update  ba_tbl_user SET security_pin =\"%@\" where id =1" ,confirmPinStr ];
            [self saveData:insertquery];
           // [self dismissViewControllerAnimated:YES completion:nil];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"PIN updated sucessfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                alert.tag=2;
            }
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter Correct PIN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }

    if (pinSavingCounter==3) {
        NSLog(@"Delete option pinSavingCounter %d %@ %@",pinSavingCounter,pinCheck,enterPinStr);
        if ([pinCheck isEqualToString:enterPinStr]) {
            
            NSString   *insertquery = [NSString stringWithFormat:@"update  ba_tbl_user SET security_pin =0 where id=1" ];
            [self saveData:insertquery];
           // [self dismissViewControllerAnimated:YES completion:nil];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"PIN removed sucessfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            alert.tag=3;
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

@end
