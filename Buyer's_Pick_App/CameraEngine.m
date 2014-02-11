//
//  CameraEngine.m
//  Encoder Demo
//
//  Created by Geraint Davies on 19/02/2013.
//  Copyright (c) 2013 GDCL http://www.gdcl.co.uk/license.htm
//

#import "CameraEngine.h"
#import "VideoEncoder.h"
#import "AssetsLibrary/ALAssetsLibrary.h"

static CameraEngine* theEngine;

@interface CameraEngine  () <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>
{
    AVCaptureSession* _session;
    AVCaptureVideoPreviewLayer* _preview;
    dispatch_queue_t _captureQueue;
    AVCaptureConnection* _audioConnection;
    AVCaptureConnection* _videoConnection;
    
    VideoEncoder* _encoder;
    BOOL _isCapturing;
    BOOL _isPaused;
    BOOL _discont;
    int _currentFile;
    CMTime _timeOffset;
    CMTime _lastVideo;
    CMTime _lastAudio;
    
    int _cx;
    int _cy;
    int _channels;
    Float64 _samplerate;
}
@end


@implementation CameraEngine

@synthesize isCapturing = _isCapturing;
@synthesize isPaused = _isPaused;
@synthesize cameraTag,stillImageOutput;

+ (void) initialize
{
    // test recommended to avoid duplicate init via subclass
    if (self == [CameraEngine class])
    {
        theEngine = [[CameraEngine alloc] init];
        
    }
}




- (void)frontcam {
    NSError *error = nil;
    NSArray *devices = [AVCaptureDevice devices];
    
    [_session removeInput:input];
    NSLog(@"cameraTag = %d",cameraTag);
    if (cameraTag==1) {
        NSLog(@"Device position : %@",[devices objectAtIndex:1]);
        input = [AVCaptureDeviceInput deviceInputWithDevice:[devices objectAtIndex:1] error:&error];
    }
    else if(cameraTag ==0){
        NSLog(@"Device position : %@",[devices objectAtIndex:0]);
        input = [AVCaptureDeviceInput deviceInputWithDevice:[devices objectAtIndex:0] error:&error];
    }
    
    
    if (!error) {
        if ([ _session canAddInput:input])
        {
            [ _session addInput:input];
        }
        
        else {
            NSLog(@"Couldn't add front facing video input");
        }
    }
    
    
}

+ (CameraEngine*) engine
{
    return theEngine;
}
-(void)setCameraTag:(int)_cameraTag
{
    cameraTag = _cameraTag;
    NSLog(@"cameraTag123 = %d",cameraTag);
    //    NSError *error = nil;
    //    NSArray *devices = [AVCaptureDevice devices];
    //    [_session removeInput:input];
    //    NSLog(@"cameraTag = %d",cameraTag);
    //    if (cameraTag==0) {
    //        NSLog(@"Device position : %@",[devices objectAtIndex:1]);
    //        input = [AVCaptureDeviceInput deviceInputWithDevice:[devices objectAtIndex:1] error:&error];
    //        //cameraTag=1;
    //    }
    //    else if(cameraTag ==1){
    //        NSLog(@"Device position : %@",[devices objectAtIndex:0]);
    //        input = [AVCaptureDeviceInput deviceInputWithDevice:[devices objectAtIndex:0] error:&error];
    //       // cameraTag=0;
    //    }
    //
    //
    //    if (!error) {
    //        if ([ _session canAddInput:input])
    //        {
    //            [ _session addInput:input];
    //        }
    //
    //        else {
    //            NSLog(@"Couldn't add front facing video input");
    //        }
    //    }
    //      [_session startRunning];
    [self shutdown];
    _session=nil;
    
    //[self startup];
}


- (void) startup
{
    
    if (_session == nil)
    {
        NSLog(@"Starting up server");
        
        self.isCapturing = NO;
        self.isPaused = NO;
        _currentFile = 0;
        _discont = NO;
        
        // create capture device with video input
        _session = [[AVCaptureSession alloc] init];
        //  AVCaptureDevice* backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSArray *devices = [AVCaptureDevice devices];
        if (cameraTag==0) {
            NSLog(@"Device position : %@",[devices objectAtIndex:1]);
            input = [AVCaptureDeviceInput deviceInputWithDevice:[devices objectAtIndex:0] error:nil];
            //cameraTag=1;
        }
        else if(cameraTag ==1){
            NSLog(@"Device position : %@",[devices objectAtIndex:0]);
            input = [AVCaptureDeviceInput deviceInputWithDevice:[devices objectAtIndex:1] error:nil];
            // cameraTag=0;
        }
        
        
        [_session addInput:input];
        
        stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [stillImageOutput setOutputSettings:outputSettings];
        [_session addOutput:stillImageOutput];
        
        
        // audio input from default mic
        AVCaptureDevice* mic = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        micinput = [AVCaptureDeviceInput deviceInputWithDevice:mic error:nil];
        [_session addInput:micinput];
        
        // create an output for YUV output with self as delegate
        _captureQueue = dispatch_queue_create("uk.co.gdcl.cameraengine.capture", DISPATCH_QUEUE_SERIAL);
        AVCaptureVideoDataOutput* videoout = [[AVCaptureVideoDataOutput alloc] init];
        [videoout setSampleBufferDelegate:self queue:_captureQueue];
        NSDictionary* setcapSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange], kCVPixelBufferPixelFormatTypeKey,
                                        nil];
        videoout.videoSettings = setcapSettings;
        [_session addOutput:videoout];
        
        _videoConnection = [videoout connectionWithMediaType:AVMediaTypeVideo];
        
        
        
        // find the actual dimensions used so we can set up the encoder to the same.
        NSDictionary* actual = videoout.videoSettings;
        _cy = [[actual objectForKey:@"Height"] integerValue];
        _cx = [[actual objectForKey:@"Width"] integerValue];
        
        AVCaptureAudioDataOutput* audioout = [[AVCaptureAudioDataOutput alloc] init];
        [audioout setSampleBufferDelegate:self queue:_captureQueue];
        [_session addOutput:audioout];
        _audioConnection = [audioout connectionWithMediaType:AVMediaTypeAudio];
        // for audio, we want the channels and sample rate, but we can't get those from audioout.audiosettings on ios, so
        // we need to wait for the first sample
        
        // start capture and a preview layer
        [_session startRunning];
        
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        //        if([_preview isOrientationSupported])
        //        {
        //            _preview.orientation = [UIApplication sharedApplication]statusBarOrientation;
        //
        //        }
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
}

-(void)imageCapture
{
    AVCaptureConnection *videoConnection = nil;
    if ([videoConnection isVideoOrientationSupported])
    {
        [videoConnection setVideoOrientation:[UIApplication sharedApplication].statusBarOrientation];
    }
    
    
    for (AVCaptureConnection *connection in stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection)
        {
            break;
        }
    }
    
    NSLog(@"about to request a capture from: %@", stillImageOutput);
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         CFDictionaryRef exifAttachments = CMGetAttachment( imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if (exifAttachments)
         {
             // Do something with the attachments.
             NSLog(@"attachements: %@", exifAttachments);
         } else
         {
             NSLog(@"no attachments");
         }
         
         
         imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
         
         
         
         UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
         
         
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *documentsDirectory = [paths objectAtIndex:0];
         
         
         
         NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
         [dateFormat setDateFormat:@"dd-MM-yyyy hh:mm:ss"];
         NSDate *now = [[NSDate alloc] init];
         
         //          [[NSDate date] timeIntervalSince1970];
         
         int timestamp = [[NSDate date] timeIntervalSince1970];
         NSString*  theDate = [NSString stringWithFormat:@"%@/%d",[dateFormat stringFromDate:now],timestamp];
         
         
         
         
         NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Photos"];
         
         if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
             [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
         
         
         //         NSString *imagepath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@-image.png",documentsDirectory,theDate]];
         NSString *imagepath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%d-image.png",documentsDirectory,timestamp]];
         
         
         BOOL success = [imageData writeToFile:imagepath atomically:NO];
         
         NSLog(@"Successs:::: %@", success ? @"YES" : @"NO");
         NSLog(@"Image path --> %@",imagepath);
         
         
         
         [self DATABASECALLED];
         
         
         
         //         NSString   *insertquery1 = [NSString stringWithFormat:@"SELECT * from  ba_tbl_vendor_master"];
         //         [self displayAll:insertquery1];
         
         GlobalClass *obj = [GlobalClass getInstance];
         
         NSString    *cloud_path= [NSString stringWithFormat:@"VENDOR_%@",obj.VenID];
         
         NSString   *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_content ( id, content_name , vendor_id , industry_id, tags , title , content_size , description , website , created_date , update_date , is_deleted , delete_date, path,type,sync_status, cloud_path ) VALUES ( \"%d\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", timestamp,@"vendor1", obj.VenID ,@"1",@"photo1",@"picture",@"s",@"dsfsadsa",@"dfafaf",theDate,@"1",@"1",@"1",imagepath,@"image",@"0",cloud_path];
         
         [self saveData:insertquery];
         
         
         
         /*
          
          NSString *post = [NSString stringWithFormat:@"email=dasfas"];
          
          
          
          NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
          NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
          NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
          
          [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/fileupload"]]];
          [request setHTTPMethod:@"POST"];
          [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
          [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
          [request setHTTPBody:postData];
          
          NSURLResponse *response;
          NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
          NSString *stringResponse = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
          NSLog(@"response1=%@",stringResponse);
          
          
          //         NSError* error;
          NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:urlData //1
          options:kNilOptions
          error:&error];
          NSString   *str;
          for (NSDictionary *actoAgent in responseDict)
          {
          str= [actoAgent objectForKey:@"response"];
          NSLog(@"res=%@",str);
          
          }
          *************************
          
          NSURL *audiourl = [NSURL URLWithString:str];
          ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:audiourl];
          NSError*err;
          NSData *postData1 = [NSData dataWithContentsOfFile:imagepath options: 0 error:&err];
          NSLog(@"postData=%@",postData1);
          [request1 addData:postData1 withFileName:@"AkshayBuyersPicksAppPhoto.png" andContentType:@"image/png" forKey:@"uploaded_files"];
          [request1 setDelegate:self];
          [request1 startAsynchronous];
          */
         
         
         //         NSString   *fetchdata = [NSString stringWithFormat:@"select  id, path, type  from ba_tbl_content"];
         
         //         NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type, created_date from ba_tbl_content where vendor_id=%@",MobileNo];
         //
         //         [self displayContentData:fetchdata];
         //         NSLog(@"fetchdatadisplayContentData=%@",fetchdata);
         
         
     }];
    
    
    
}

- (void) startCapture
{
    @synchronized(self)
    {
        if (!self.isCapturing)
        {
            NSLog(@"starting capture");
            
            // create the encoder once we have the audio params
            _encoder = nil;
            self.isPaused = NO;
            _discont = NO;
            _timeOffset = CMTimeMake(0, 0);
            self.isCapturing = YES;
        }
    }
}

- (void) stopCapture
{
    @synchronized(self)
    {
        if (self.isCapturing)
        {
            NSString* filename = [NSString stringWithFormat:@"capture%d.mp4", _currentFile];
            NSString* path = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
            url = [NSURL fileURLWithPath:path];
            
            _currentFile++;
            NSLog(@"filePath = %@",path);
            
            // serialize with audio and video capture
            
            self.isCapturing = NO;
            dispatch_async(_captureQueue, ^{
                [_encoder finishWithCompletionHandler:^{
                    self.isCapturing = NO;
                    _encoder = nil;
                    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                    [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error){
                        NSLog(@"save completed");
                        //                        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
                        
                        
                        /////saving
                        
                        VIDEODATA = [NSData dataWithContentsOfURL:url];
                        //                        NSLog(@"VIDEODATA=%@",VIDEODATA);
                        
                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *documentsDirectory = [paths objectAtIndex:0];
                        
                        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                        [dateFormat setDateFormat:@"dd-MM-yyyy hh:mm:ss"];
                        NSDate *now = [[NSDate alloc] init];
                        
                        int timestamp = [[NSDate date] timeIntervalSince1970];
                        NSString*  theDate = [NSString stringWithFormat:@"%@/%d",[dateFormat stringFromDate:now],timestamp];
                        
                        //  NSString*  theDate = [dateFormat stringFromDate:now];
                        
                        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"VideoAlbum"];
                        
                        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
                            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
                        
                        //                        int timestamp = [[NSDate date] timeIntervalSince1970];
                        
                        //         NSString *imagepath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@-image.png",documentsDirectory,theDate]];
                        NSString *imagepath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%dvideo.mp4",documentsDirectory,timestamp]];
                        
                        //                        NSString *videopath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/video.mp4",documentsDirectory]];
                        
                        
                        BOOL success = [VIDEODATA writeToFile:imagepath atomically:YES];
                        
                        NSLog(@"Successs:::: %@", success ? @"YES" : @"NO");
                        NSLog(@"Image path --> %@",imagepath);
                        
                        
                        [self DATABASECALLED];
                        //                        NSString   *insertquery1 = [NSString stringWithFormat:@"SELECT * from  ba_tbl_vendor_master"];
                        //                        [self displayAll:insertquery1];
                        
                        
                        GlobalClass *obj = [GlobalClass getInstance];
                        
                        NSString    *cloud_path= [NSString stringWithFormat:@"VENDOR_%@",obj.VenID];
                        
                        
                        NSString   *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_content ( id, content_name , vendor_id , industry_id, tags , title , content_size , description , website , created_date , update_date , is_deleted , delete_date, path,type,sync_status, cloud_path) VALUES ( \"%d\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",timestamp, @"vendor1", obj.VenID ,@"1", @"photo1",@"picture",@"s",@"dsfsadsa",@"dfafaf",theDate,@"1",@"1",@"1",imagepath,@"video",@"0",cloud_path];
                        
                        //         NSLog(@"")
                        [self saveData:insertquery];
                        
                        
                        /*                      NSURL *audiourl = [NSURL URLWithString:@"http://apps.medialabs24x7.com/buyerspick/uploadtest.php"];
                         ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:audiourl];
                         NSError*err;
                         NSData *postData = [NSData dataWithContentsOfFile:imagepath options: 0 error:&err];
                         //                        NSLog(@"postData=%@",postData);
                         [request addData:postData withFileName:@"BuyersPicksAppVideo.mp4" andContentType:@"video/mp4" forKey:@"uploaded_file"];
                         [request setDelegate:self];
                         [request startAsynchronous];
                         */
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        //                        NSString *post = [NSString stringWithFormat:@"email=dasfas"];
                        //
                        //
                        //
                        //                        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                        //                        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
                        //                        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                        //
                        //                        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/fileupload"]]];
                        //                        [request setHTTPMethod:@"POST"];
                        //                        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                        //                        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
                        //                        [request setHTTPBody:postData];
                        //
                        //                        NSURLResponse *response;
                        //                        NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
                        //                        NSString *stringResponse = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
                        //                        NSLog(@"response1=%@",stringResponse);
                        //
                        //
                        //                        //         NSError* error;
                        //                        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:urlData //1
                        //                                                                                     options:kNilOptions
                        //                                                                                       error:&error];
                        //                        NSString   *str;
                        //                        for (NSDictionary *actoAgent in responseDict)
                        //                        {
                        //                            str= [actoAgent objectForKey:@"response"];
                        //                            NSLog(@"res=%@",str);
                        //
                        //                        }
                        //
                        //
                        //                        NSURL *audiourl = [NSURL URLWithString:str];
                        //                        ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:audiourl];
                        //                        NSError*err;
                        //                        NSData *postData1 = [NSData dataWithContentsOfFile:imagepath options: 0 error:&err];
                        //                        NSLog(@"postData=%@",postData1);
                        //                        [request1 addData:postData1 withFileName:@"AkshayBuyersPicksAppVideo.mp4" andContentType:@"video/mp4" forKey:@"uploaded_files"];
                        //                        [request1 setDelegate:self];
                        //                        [request1 startAsynchronous];
                        
                        
                        
                        
                        
                        
                        
                        //                        NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type, created_date from ba_tbl_content where vendor_id=%@",MobileNo];
                        //                        [self displayContentData:fetchdata];
                        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
                        
                        
                        
                    }];
                }];
            });
        }
    }
}

- (void) pauseCapture
{
    @synchronized(self)
    {
        if (self.isCapturing)
        {
            NSLog(@"Pausing capture");
            self.isPaused = YES;
            _discont = YES;
        }
    }
}

- (void) resumeCapture
{
    @synchronized(self)
    {
        if (self.isPaused)
        {
            NSLog(@"Resuming capture");
            self.isPaused = NO;
        }
    }
}

- (CMSampleBufferRef) adjustTime:(CMSampleBufferRef) sample by:(CMTime) offset
{
    CMItemCount count;
    CMSampleBufferGetSampleTimingInfoArray(sample, 0, nil, &count);
    CMSampleTimingInfo* pInfo = malloc(sizeof(CMSampleTimingInfo) * count);
    CMSampleBufferGetSampleTimingInfoArray(sample, count, pInfo, &count);
    for (CMItemCount i = 0; i < count; i++)
    {
        pInfo[i].decodeTimeStamp = CMTimeSubtract(pInfo[i].decodeTimeStamp, offset);
        pInfo[i].presentationTimeStamp = CMTimeSubtract(pInfo[i].presentationTimeStamp, offset);
    }
    CMSampleBufferRef sout;
    CMSampleBufferCreateCopyWithNewTiming(nil, sample, count, pInfo, &sout);
    free(pInfo);
    return sout;
}

- (void) setAudioFormat:(CMFormatDescriptionRef) fmt
{
    const AudioStreamBasicDescription *asbd = CMAudioFormatDescriptionGetStreamBasicDescription(fmt);
    _samplerate = asbd->mSampleRate;
    _channels = asbd->mChannelsPerFrame;
    
}

- (void) captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    BOOL bVideo = YES;
    
    @synchronized(self)
    {
        if (!self.isCapturing  || self.isPaused)
        {
            return;
        }
        if (connection != _videoConnection)
        {
            bVideo = NO;
        }
        if ((_encoder == nil) && !bVideo)
        {
            CMFormatDescriptionRef fmt = CMSampleBufferGetFormatDescription(sampleBuffer);
            [self setAudioFormat:fmt];
            NSString* filename = [NSString stringWithFormat:@"capture%d.mp4", _currentFile];
            NSString* path = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
            _encoder = [VideoEncoder encoderForPath:path Height:_cy width:_cx channels:_channels samples:_samplerate];
        }
        if (_discont)
        {
            if (bVideo)
            {
                return;
            }
            _discont = NO;
            // calc adjustment
            CMTime pts = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
            CMTime last = bVideo ? _lastVideo : _lastAudio;
            if (last.flags & kCMTimeFlags_Valid)
            {
                if (_timeOffset.flags & kCMTimeFlags_Valid)
                {
                    pts = CMTimeSubtract(pts, _timeOffset);
                }
                CMTime offset = CMTimeSubtract(pts, last);
                NSLog(@"Setting offset from %s", bVideo?"video": "audio");
                NSLog(@"Adding %f to %f (pts %f)", ((double)offset.value)/offset.timescale, ((double)_timeOffset.value)/_timeOffset.timescale, ((double)pts.value/pts.timescale));
                
                // this stops us having to set a scale for _timeOffset before we see the first video time
                if (_timeOffset.value == 0)
                {
                    _timeOffset = offset;
                }
                else
                {
                    _timeOffset = CMTimeAdd(_timeOffset, offset);
                }
            }
            _lastVideo.flags = 0;
            _lastAudio.flags = 0;
        }
        
        // retain so that we can release either this or modified one
        CFRetain(sampleBuffer);
        
        if (_timeOffset.value > 0)
        {
            CFRelease(sampleBuffer);
            sampleBuffer = [self adjustTime:sampleBuffer by:_timeOffset];
        }
        
        // record most recent time so we know the length of the pause
        CMTime pts = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
        CMTime dur = CMSampleBufferGetDuration(sampleBuffer);
        if (dur.value > 0)
        {
            pts = CMTimeAdd(pts, dur);
        }
        if (bVideo)
        {
            _lastVideo = pts;
        }
        else
        {
            _lastAudio = pts;
        }
    }
    
    // pass frame to encoder
    [_encoder encodeFrame:sampleBuffer isVideo:bVideo];
    CFRelease(sampleBuffer);
}

- (void)shutdown
{
    NSLog(@"shutting down server");
    if (_session)
    {
        [_session stopRunning];
        _session = nil;
    }
    [_encoder finishWithCompletionHandler:^{
        NSLog(@"Capture completed");
    }];
}


- (AVCaptureVideoPreviewLayer*) getPreviewLayer
{
    return _preview;
}
#pragma mark Async Hit to Server

- (void)requestFinished:(ASIHTTPRequest *)request {
	
	NSString *receivedString = [request responseString];
    NSLog(@"requestFinished=%@",receivedString);
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Success Message" message:@"Data Uploaded" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alertView show];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	
	NSString *receivedString = [request responseString];
    NSLog(@"requestFailed=%@",receivedString);
    
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Failed Message" message:receivedString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alertView show];
}



@end
