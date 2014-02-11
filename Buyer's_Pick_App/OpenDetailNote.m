//
//  OpenDetailNote.m
//  Buyer's_Pick_App
//
//  Created by Akshay Jain on 12/23/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import "OpenDetailNote.h"
#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)

@interface OpenDetailNote ()

@end

@implementation OpenDetailNote
@synthesize DATAPATH,DATATYPE,videoPlayerView;

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
    NSLog(@"DATATYPE1=%@",DATAPATH);
    
//    if ([DATATYPE isEqualToString:@"image"]) {
//        
//        
//        _image.image = [UIImage imageWithContentsOfFile:DATAPATH];
//
//        
//    }
    
    UIImage *doneImage = [UIImage imageNamed:@"done.png"];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setImage:doneImage forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(0, 3, 64, 37);
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemDone = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    [self.navigationItem setLeftBarButtonItem:customBarItemDone];
    
    
    if ([DATATYPE isEqualToString:@"video"] || [DATATYPE isEqualToString:@"audio"]) {
 

    CGAffineTransform rotate =CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));

	url	= [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",DATAPATH]];
	videoPlayer	= [[MPMoviePlayerController alloc] initWithContentURL:url];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:)name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayer];
	videoPlayer.view.frame	= CGRectMake(0,0,768 ,960);
    videoPlayer.fullscreen = YES;
    videoPlayer.scalingMode = MPMovieScalingModeAspectFill;
    [videoPlayer.view setTransform:rotate];
	[self.view addSubview:videoPlayer.view];
	[videoPlayer play];
        
    }

    // Do any additional setup after loading the view from its nib.
}

-(void)done
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    NSLog(@"In view will Appear");
    
    
    
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
        videoPlayer.view.frame	= CGRectMake(0,0,960 ,768);

        
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        videoPlayer.view.frame	= CGRectMake(0,0,768 ,960);

        
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
        videoPlayer.view.frame	= CGRectMake(0,0,960 ,768);
        
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        videoPlayer.view.frame	= CGRectMake(0,0,768 ,960);
    }
    
    
}
- (void)movieFinishedCallback:(NSNotification*) aNotification
{
    videoPlayer = [aNotification object];
    [[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object:videoPlayer];
    [videoPlayer stop];
	[videoPlayer prepareToPlay];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [videoPlayer stop];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
