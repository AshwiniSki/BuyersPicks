//
//  CardScanner.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 04/02/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "CardScanner.h"
#import "BackgroundLayer.h"

@interface CardScanner ()

@end

@implementation CardScanner

@synthesize viewForDetailsFields,viewForDetailsOfCard,viewForDisplayCard,cardImageView,cardScroller,TAG;

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
    
    viewForDisplayCard.layer.cornerRadius = 10.0;
    viewForDisplayCard.clipsToBounds = YES;
    
    viewForDetailsOfCard.layer.cornerRadius = 10.0;
    viewForDetailsOfCard.clipsToBounds = YES;

    [viewForDisplayCard.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [viewForDisplayCard.layer setBorderWidth:0.5];
    
    [viewForDetailsOfCard.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [viewForDetailsOfCard.layer setBorderWidth:0.5];
    
   
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
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Card Edit";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    titleLabel.textColor = [UIColor darkGrayColor];
    self.navigationItem.titleView = titleLabel;


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
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        viewForDisplayCard.frame = CGRectMake(1, 162, 415, 380);
        viewForDetailsOfCard.frame = CGRectMake(424, 10, 595, 684);
        cardScroller.frame = CGRectMake(0, 0, 595, 684);
        cardImageView.frame = CGRectMake(0, 44, 415, 269);
    }
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
        viewForDisplayCard.frame = CGRectMake(87, 20, 595, 325);
        viewForDetailsOfCard.frame = CGRectMake(87, 353, 595, 587);
        cardScroller.frame = CGRectMake(0, 0, 595, 587);
        cardImageView.frame = CGRectMake(68, 29, 459, 267);
    }
    cardScroller.contentSize = CGSizeMake(cardScroller.frame.size.width, 800);

    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = viewForDisplayCard.bounds;
    [viewForDisplayCard.layer insertSublayer:bgLayer atIndex:0];
    
    CAGradientLayer *bgLayer1 = [BackgroundLayer blueGradient];
    bgLayer1.frame = viewForDetailsOfCard.bounds;
    [viewForDetailsOfCard.layer insertSublayer:bgLayer1 atIndex:0];
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
        viewForDisplayCard.frame = CGRectMake(1, 162, 415, 380);
        viewForDetailsOfCard.frame = CGRectMake(424, 10, 595, 684);
        cardScroller.frame = CGRectMake(0, 0, 595, 684);
        cardImageView.frame = CGRectMake(0, 44, 415, 269);
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        viewForDisplayCard.frame = CGRectMake(87, 20, 595, 325);
        viewForDetailsOfCard.frame = CGRectMake(87, 353, 595, 587);
        cardScroller.frame = CGRectMake(0, 0, 595, 587);
        cardImageView.frame = CGRectMake(68, 29, 459, 267);
    }
    cardScroller.contentSize = CGSizeMake(cardScroller.frame.size.width, 800);
//    [viewForDisplayCard setClipsToBounds:YES];
//    [viewForDisplayCard.layer setFrame:viewForDisplayCard.bounds];
    
//    for (CAGradientLayer *layer in viewForDisplayCard.layer.sublayers) {
//        [layer removeFromSuperlayer];
//    }
    
    
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = viewForDisplayCard.bounds;
    [viewForDisplayCard.layer insertSublayer:bgLayer atIndex:0];
    
    CAGradientLayer *bgLayer1 = [BackgroundLayer blueGradient];
    bgLayer1.frame = viewForDetailsOfCard.bounds;
    [viewForDetailsOfCard.layer insertSublayer:bgLayer1 atIndex:0];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
