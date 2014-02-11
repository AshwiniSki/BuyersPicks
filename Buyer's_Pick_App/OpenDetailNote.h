//
//  OpenDetailNote.h
//  Buyer's_Pick_App
//
//  Created by Akshay Jain on 12/23/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
@interface OpenDetailNote : DatabaseClass
{
	MPMoviePlayerController	*videoPlayer;
	NSString				*urlStr;
	NSURL					*url;
    UIButton *videoButton[1000];
    int totalVideo;
    int check;
    UIView  *view1 ;}


@property(nonatomic,retain) NSString    *DATATYPE;
@property(nonatomic,retain) NSString    *DATAPATH;
@property (strong, nonatomic) IBOutlet UIView *videoPlayerView;

@property (strong, nonatomic) IBOutlet UIImageView *image;

@end
