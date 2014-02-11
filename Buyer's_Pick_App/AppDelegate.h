//
//  AppDelegate.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 12/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDMenuController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic)NSString *lockVendorTag;
@property (strong, nonatomic) NSString *PinCheckvendorid;
@property (strong,nonatomic)UINavigationController *detailNavController;
@property (strong, nonatomic) DDMenuController *menuController;

@property (strong,nonatomic)NSString *calledForUpdateAppD;// AddContactsDetails edit btn pressed


@end
