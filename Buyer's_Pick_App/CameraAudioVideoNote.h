//
//  CameraAudioVideoNote.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 13/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Switchy.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/CGImageProperties.h>
#import <ImageIO/ImageIO.h>
#import "OpenDetailNote.h"
#import "ASIFormDataRequest.h"

@interface CameraAudioVideoNote : DatabaseClass<UIImagePickerControllerDelegate,UITextViewDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate,UIGestureRecognizerDelegate,UIWebViewDelegate>
{
    Switchy *sw1;
    UIImageView *savedImageToiPad[5000];
    AVCaptureSession *session;
    UIImageView *saveImage;
    UIImageView *frame[5000];
    NSTimer     *progressUpdateTimer;
    
    UIButton *navCameraButton;
    UIButton *videoButton;
    UIButton *audioButton;
    UIButton *noteButton;
    UIButton *deleteButton;
    UIButton *photoEditButton[5000];
    UIButton *photoEditButtonLand[5000];
    UIButton *crossButton[5000];
    
    UIScrollView *scrollLand;
    UIImageView *savedImageToiPadLand[5000];
    UIImageView *frameLand[5000];
    UIButton *crossButtonLand[5000];
}

@property (nonatomic,strong)NSString* TAG;
@property (nonatomic)int deleteNoteIndex;
@property (nonatomic)int orientationChanged;
@property (nonatomic)int navTagFromHome;
@property (strong, nonatomic) IBOutlet UIView *pView;
@property (strong, nonatomic) IBOutlet UIView *lView;
@property (strong, nonatomic) IBOutlet UIScrollView *noteScroller;
@property (strong, nonatomic) IBOutlet UIScrollView *noteScrollerLand;
@property(strong,nonatomic) NSMutableDictionary *AllNotes;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *mainActivityIndicator;
@property (strong, nonatomic) IBOutlet UIWebView *ads;

//Camera
//@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic)NSMutableArray*imageArray;
@property (strong, nonatomic) IBOutlet UISwitch *cameraToggleSwitch;
@property (strong, nonatomic) IBOutlet UIView *viewForRecording;
@property (strong, nonatomic) UIImageView *savedImage;
@property (strong, nonatomic) IBOutlet UIButton *imageCaptureButton;
@property (strong, nonatomic) IBOutlet UIButton *cameraButton;
@property (strong, nonatomic) AVCaptureDevice *frontCamera;
@property (strong, nonatomic) AVCaptureDevice *backCamera;
@property (strong, nonatomic) AVCaptureDevice *device;
@property (nonatomic)int cameraTag;
@property (strong, nonatomic) AVCaptureDeviceInput *input;
@property (strong, nonatomic) UIColor *thumbTintColor;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageForSwitch;


@property (strong, nonatomic) IBOutlet UISwitch *cameraToggleSwitchLand;
@property (strong, nonatomic) IBOutlet UIView *viewForRecordingLand;
@property (strong, nonatomic) IBOutlet UIButton *imageCaptureButtonLand;
@property (strong, nonatomic) IBOutlet UIButton *cameraButtonLand;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageForSwitchLand;


//Audio
@property (weak, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIView *audioRecordView;
@property (strong, nonatomic) IBOutlet UILabel *tapOniconLabel;
@property (weak, nonatomic) IBOutlet UIButton *recordPauseButtonLand;
@property (weak, nonatomic) IBOutlet UIButton *stopButtonLand;
@property (weak, nonatomic) IBOutlet UIButton *playButtonLand;
@property (strong, nonatomic) IBOutlet UIView *audioRecordViewLand;

- (IBAction)recordPauseTapped:(id)sender;
- (IBAction)stopTapped:(id)sender;
- (IBAction)playTapped:(id)sender;


//Video
@property (strong, nonatomic) IBOutlet UIView *videoRecordingView;
@property (nonatomic)int videoPreviewTag;
@property (strong, nonatomic) IBOutlet UIButton *startVideo;
@property (strong, nonatomic) IBOutlet UIButton *stopVideo;
@property (strong, nonatomic) IBOutlet UIImageView *switchCameraImage;
@property (strong, nonatomic) IBOutlet UIImageView *switchVideoImage;
@property (strong, nonatomic) IBOutlet UILabel *videoTime;


@property (strong, nonatomic) IBOutlet UIView *videoRecordingViewLand;
@property (strong, nonatomic) IBOutlet UIButton *startVideoLand;
@property (strong, nonatomic) IBOutlet UIButton *stopVideoLand;
@property (strong, nonatomic) IBOutlet UIImageView *switchCameraImageLand;
@property (strong, nonatomic) IBOutlet UIImageView *switchVideoImageLand;
@property (strong, nonatomic) IBOutlet UILabel *videoTimeLand;

- (IBAction)startRecording:(id)sender;

- (IBAction)stopRecording:(id)sender;



//Text
@property (strong,nonatomic) IBOutlet UITextView *noteTextView;
@property (strong, nonatomic) IBOutlet UIImageView *textViewBgImage;
@property (strong, nonatomic) IBOutlet UIButton *saveText;
@property (strong, nonatomic) IBOutlet UIButton *cancleText;

@property (strong,nonatomic) IBOutlet UITextView *noteTextViewLand;
@property (strong, nonatomic) IBOutlet UIImageView *textViewBgImageLand;
@property (strong, nonatomic) IBOutlet UIButton *saveTextLand;
@property (strong, nonatomic) IBOutlet UIButton *cancleTextLand;

@property (nonatomic,retain)UILabel *placeHolderTitle;
@property (nonatomic,retain)NSString *savedDescription;
- (IBAction)saveText:(id)sender;
- (IBAction)cancleText:(id)sender;


@end
