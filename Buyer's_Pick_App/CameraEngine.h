//
//  CameraEngine.h
//  Encoder Demo
//
//  Created by Geraint Davies on 19/02/2013.
//  Copyright (c) 2013 GDCL http://www.gdcl.co.uk/license.htm
//

#import <Foundation/Foundation.h>
#import "AVFoundation/AVCaptureSession.h"
#import "AVFoundation/AVCaptureOutput.h"
#import "AVFoundation/AVCaptureDevice.h"
#import "AVFoundation/AVCaptureInput.h"
#import "AVFoundation/AVCaptureVideoPreviewLayer.h"
#import "AVFoundation/AVMediaFormat.h"
#import "DatabaseClass.h"
#import <ImageIO/CGImageProperties.h>
#import <ImageIO/ImageIO.h>
#import "ASIFormDataRequest.h"
#import "GlobalClass.h"

@interface CameraEngine : DatabaseClass
{
   
    AVCaptureDevice *device;
    AVCaptureDeviceInput* input;
    AVCaptureDeviceInput* micinput;
    NSData  *VIDEODATA;
    NSURL* url;
    NSData *imageData;
}

+ (CameraEngine*) engine;
- (void) startup;
- (void) shutdown;
- (AVCaptureVideoPreviewLayer*) getPreviewLayer;

- (void) startCapture;
- (void) pauseCapture;
- (void) stopCapture;
- (void) resumeCapture;
- (void) frontcam;
-(void)imageCapture;
@property (nonatomic,retain)AVCaptureStillImageOutput *stillImageOutput;
@property (atomic, readwrite) BOOL isCapturing;
@property (atomic, readwrite) BOOL isPaused;
@property (nonatomic)int cameraTag;
@end
