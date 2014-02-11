//
//  AppDelegate.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 12/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "HomeViewController.h"
#import "MasterViewController.h"
#import "DDMenuController.h"
#import "GlobalClass.h"

@implementation AppDelegate

@synthesize lockVendorTag,PinCheckvendorid;
@synthesize calledForUpdateAppD;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    GlobalClass *obj=[GlobalClass getInstance];
    obj.CHECK_CATALOG=@"1";
    obj.CHECK_NETWORK=@"1";

   HomeViewController *home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.detailNavController = [[CustomNavigationController alloc]initWithRootViewController:home];
    
    
    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:self.detailNavController];
    _menuController = rootController;
    
     MasterViewController *masterViewController  = [[MasterViewController alloc] init];
    rootController.leftViewController = masterViewController;

    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque
                                                animated:YES];
   
    
    self.window.rootViewController = rootController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  // iOS 6 autorotation fix
{
    GlobalClass     *obj = [GlobalClass getInstance];
    obj.IAPStatus = @"0";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MovePencil" object:nil];
    return UIInterfaceOrientationMaskAll;
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
