//
//  CardScanner.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 04/02/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardScanner : UIViewController
{
//    CAGradientLayer *bgLayer;
//    CAGradientLayer *bgLayer1;
}
@property (strong, nonatomic) IBOutlet UIView *viewForDisplayCard;
@property (strong, nonatomic) IBOutlet UIImageView *cardImageView;
@property (strong, nonatomic) IBOutlet UIView *viewForDetailsOfCard;
@property (strong, nonatomic) IBOutlet UIScrollView *cardScroller;
@property (strong, nonatomic) IBOutlet UIView *viewForDetailsFields;
@property (nonatomic,strong)NSString* TAG;

@end
