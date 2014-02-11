//
//  Switchy.h
//  
//
//  Created by Emir Fithri Samsuddin on 4/5/13.
//  Copyright (c) 2013 Emir Fithri Samsuddin. All rights reserved.
//  100% ROYALTY FREE CLASS. Pls use as u like. :D

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Switchy : UIControl {
    
    UIView *container;
    UILabel *onLabel, *offLabel;
    UIView *switcher;
    CAGradientLayer *gradient;
}

@property (nonatomic, setter = setState:, getter = getOn) BOOL isOn;
@property(nonatomic, retain) UIView *container;
@property(nonatomic, retain) UILabel *onLabel, *offLabel;
@property(nonatomic, retain) UIView *switcher;

- (id)initWithFrame:(CGRect)frame withOnLabel:(NSString *)ontxt andOfflabel:(NSString *)offtxt
withContainerColor1:(UIColor *)color1c andContainerColor2:(UIColor *)color2c
withKnobColor1:(UIColor *)color1k andKnobColor2:(UIColor *)color2k withShine:(BOOL)shine;


@end

