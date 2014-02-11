//
//  Switchy.m
//  
//
//  Created by Emir Fithri Samsuddin on 4/5/13.
//  Copyright (c) 2013 Emir Fithri Samsuddin. All rights reserved.
// 100% ROYALTY FREE CLASS. Pls use as u like. :D

#import "Switchy.h"



@interface Switchy(){
  
}
@end




@implementation Switchy

@synthesize isOn, switcher, container, onLabel, offLabel;

float knobSize = 0.9;


-(void)dealloc {
    [super dealloc];
    
    [switcher release];
    [container release];
    [onLabel release];
    [offLabel release];
}

- (id)initWithFrame:(CGRect)frame withOnLabel:(NSString *)ontxt andOfflabel:(NSString *)offtxt
         withContainerColor1:(UIColor *)color1c andContainerColor2:(UIColor *)color2c
        withKnobColor1:(UIColor *)color1k andKnobColor2:(UIColor *)color2k withShine:(BOOL)shine
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.masksToBounds = YES;
        self.layer.opaque = NO;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2.0;
        
        container = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.x, frame.size.width, frame.size.height)];
        container.layer.cornerRadius = frame.size.height/2.0;
        container.backgroundColor = [UIColor blackColor];
        
        gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(0, 0, frame.size.width, frame.size.height); // height 237 max
        gradient.colors = [NSArray arrayWithObjects:(id)[color1c CGColor], (id)[color2c CGColor], nil];
        
        [container.layer insertSublayer:gradient atIndex:0];
        gradient.hidden = YES;
        isOn = NO; // default is like UISwitch, ie off state
        
        //shine
        if (shine) {
            CAGradientLayer *gradient3;
            gradient3 = [CAGradientLayer layer];
            gradient3.frame = CGRectMake((frame.size.width-frame.size.width/1.2)/2, frame.size.height/2, frame.size.width/1.2, frame.size.height/2); // height 237 max
            UIColor *clrShine1 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
            UIColor *clrShine2 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.05];
            gradient3.cornerRadius = frame.size.height/4;
            gradient3.colors = [NSArray arrayWithObjects:(id)[clrShine2 CGColor], (id)[clrShine1 CGColor], nil];
            [container.layer insertSublayer:gradient3 atIndex:1];
        }         
        // create and set Labels
        
        float labelWidth = frame.size.width/2;
        
       
        onLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, labelWidth, frame.size.height)];
        onLabel.backgroundColor = [UIColor clearColor];
        onLabel.textColor = [UIColor whiteColor];
        onLabel.font = [UIFont fontWithName:@"Helvetica" size:frame.size.height/2];
        onLabel.textAlignment = NSTextAlignmentCenter;
        onLabel.text = ontxt;
         onLabel.alpha = 0;
        
        offLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-labelWidth, 0, labelWidth, frame.size.height)];
        offLabel.backgroundColor = [UIColor clearColor];
        offLabel.textColor = [UIColor whiteColor];
        offLabel.font = [UIFont fontWithName:@"Helvetica" size:frame.size.height/2];
        offLabel.textAlignment = NSTextAlignmentCenter;
        offLabel.text = offtxt;
       
        
        [container addSubview:onLabel];
        [container addSubview:offLabel];
        
        // self.frame.size.height*knobSize
        
        switcher = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.height/16.0,
                                                            self.frame.size.height/2-self.frame.size.height*knobSize/2,
                                                            self.frame.size.width/2,
                                                            self.frame.size.height*knobSize)];
        switcher.layer.cornerRadius = frame.size.height*knobSize/2.0;
        switcher.layer.masksToBounds = NO;
        switcher.layer.opaque = YES;
        switcher.clipsToBounds = YES;
        switcher.backgroundColor = [UIColor clearColor];
        
        CAGradientLayer *gradient2 = [CAGradientLayer layer];
        gradient2.frame = CGRectMake(0,0,switcher.frame.size.width,switcher.frame.size.height); // height 237 max
        gradient2.cornerRadius = frame.size.height*knobSize/2.0;
        gradient2.colors = [NSArray arrayWithObjects:(id)[color1k CGColor], (id)[color2k CGColor], nil];
        [switcher.layer insertSublayer:gradient2 atIndex:0];
        [container addSubview:switcher];
        
       
        [self addSubview:container];
 
        
    }
    return self;
}




-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
     [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    // toggles state and visuals

    
    [UIView beginAnimations: @"" context: nil];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDuration: 0.3];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    isOn = !isOn;
    
    if (isOn) {
        switcher.frame =  CGRectMake(self.frame.size.width - switcher.frame.size.width - self.frame.size.height/16.0,
                                     self.frame.size.height/2 - self.frame.size.height*knobSize/2,
                                     switcher.frame.size.width,
                                     self.frame.size.height*knobSize);
        onLabel.alpha = 1;
        offLabel.alpha = 0;
        gradient.hidden = NO;
    } else {
        switcher.frame =  CGRectMake(self.frame.size.height/16.0,
                                     self.frame.size.height/2-self.frame.size.height*knobSize/2,
                                     switcher.frame.size.width,
                                     self.frame.size.height*knobSize);
        onLabel.alpha = 0;
        offLabel.alpha = 1;
        gradient.hidden = YES;
    }
    [UIView commitAnimations];
    
}


-(void)setState:(BOOL)onOff {
    // setState 
    isOn = onOff;
    // set visuals
    [UIView beginAnimations: @"" context: nil];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDuration: 0.3];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    
    
    if (!isOn) {
        
        switcher.frame =  CGRectMake(self.frame.size.height/16.0,
                                     self.frame.size.height/2-self.frame.size.height*knobSize/2,
                                     switcher.frame.size.width,
                                     self.frame.size.height*knobSize);
        onLabel.alpha = 0;
        offLabel.alpha = 1;
        gradient.hidden = YES;
    } else {
        switcher.frame =  CGRectMake(self.frame.size.width - switcher.frame.size.width - self.frame.size.height/16.0,
                                     self.frame.size.height/2 - self.frame.size.height*knobSize/2,
                                     switcher.frame.size.width,
                                     self.frame.size.height*knobSize);
        
        onLabel.alpha = 1;
        offLabel.alpha = 0;
        gradient.hidden = NO;
    }
    [UIView commitAnimations];

}

-(BOOL)getOn {
    
    return isOn;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
