//
//  ContactUs.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 17/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "ContactUs.h"
#import <MessageUI/MessageUI.h>

@interface ContactUs ()

@end

@implementation ContactUs
@synthesize mainView,backgroundImage;

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
    
    mainView.layer.cornerRadius = 10.0;
    mainView.clipsToBounds = YES;
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
        mainView.frame = CGRectMake(275, 226, 475, 296);
        
        
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

        mainView.frame = CGRectMake(132, 354, 475, 296);
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
        mainView.frame = CGRectMake(275, 226, 475, 296);
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
        mainView.frame = CGRectMake(132, 354, 475, 296);
        
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)emailUsBtn:(id)sender
{
    
    NSString	*shareText= [NSString stringWithFormat:@""];
    
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet:shareText];
		}
		
		else
		{
			[self launchMailAppOnDevice:shareText];
		}
	}
	
	else
	{
		[self launchMailAppOnDevice:shareText];
	}
	
  
	
}
-(IBAction)displayComposerSheet:(NSString*)String
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
    [picker setSubject:@"Reliance Entertainment Application related feedback"];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"info@relianceada.com"];
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"", nil];
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    NSString	*str= [NSString stringWithFormat:@"To the Reliance Entertainment App Team,"];
    [picker setToRecipients:toRecipients];
    [picker setCcRecipients:ccRecipients];
    NSString *emailBody = str;
    [picker setMessageBody:emailBody isHTML:NO];
    
    
	
	//	[picker setBccRecipients:bccRecipients];
	
	
	
   	
	// Fill out the email body text
	
	[self presentModalViewController:picker animated:YES];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	//	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//[self dismissModalViewControllerAnimated:YES];
			//message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			//[self dismissModalViewControllerAnimated:YES];
			//message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			//message.text = @"Result: sent";
			//[self dismissModalViewControllerAnimated:YES];
			break;
		case MFMailComposeResultFailed:
			//message.text = @"Result: failed";
			//[self dismissModalViewControllerAnimated:YES];
			break;
		default:
			//message.text = @"Result: not sent";
			//[self dismissModalViewControllerAnimated:YES];
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice:(NSString*)string
{
	NSString *recipients = @"mailto:info@relianceada.com?cc=&subject=Reliance Entertainment Application related feedback";
	//NSString *body = @"&body=All Dabangg 2 Movie details are Available on Dabangg2 App!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, string];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}
- (IBAction)writeReviewBtn:(id)sender
{
    NSString *str = [NSString stringWithFormat:@"http://www.skiusainc.com/contactus.php#report-an-app-problem"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (IBAction)spreadWordBtn:(id)sender {
}
@end
