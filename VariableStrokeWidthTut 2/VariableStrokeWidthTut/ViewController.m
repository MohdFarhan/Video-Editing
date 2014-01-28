//
//  ViewController.m
//  VideoInImageView
//
//  Created by Farhan Khan on 08/08/13.
//  Copyright (c) 2013 Triffort. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize mediaPlayer1 = mediaPlayer1;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
NSString *video   =   [[NSBundle mainBundle] pathForResource:@"sample1" ofType:@"mp4"];
    playerView.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    CGSize size=[self VideoSize:video];
   [self AdjustOrientation:size];
  
movieView.frame=CGRectMake(0,0,size.width,size.height);
    drawingView.freshView=movieView;
   [self videoOutputSetting:size];
self.mediaPlayer1 = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:video]];


    isPlaying=isRecording=NO;
    [self performSelector:@selector(currentItemScreenShot) withObject:Nil afterDelay:1.0];
//    NSLog(@"%lf",[[[[self.mediaPlayer1.currentItem asset]tracksWithMediaType:AVMediaTypeVideo]objectAtIndex:0]nominalFrameRate]);

}
-(void)viewDidAppear:(BOOL)animated{
   //[self currentItemScreenShot];
}
- (BOOL)shouldAutorotate {
    
    return NO;
}

// lock rotation according to frame...

//- (NSUInteger)supportedInterfaceOrientations
//{
//    NSString *video   =   [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mp4"];
//    
//    CGSize size=[self VideoSize:video];
//    if(size.width>size.height){
//       
//        return UIInterfaceOrientationMaskLandscapeLeft ;
//    }
//    else
//        return UIInterfaceOrientationMaskPortrait;
//}


//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    
//    return (toInterfaceOrientation == [self preferredInterfaceOrientationForPresentation]);
//}
-(void)AdjustOrientation:(CGSize)size{
    
//  //  NSLog(@"Size:(%f,%f)",playerView.frame.size.width,playerView.frame.size.height);
//    if(size.width>size.height){
//        playerView.transform= CGAffineTransformMakeRotation(0);
//        playerView.transform = CGAffineTransformMakeRotation(3.14159265/2);
//        
//
//    }
    
  //  NSLog(@"Size:(%f,%f)",playerView.frame.size.width,playerView.frame.size.height);

    CGSize scrSize=self.view.frame.size ;
    if(size.width>size.height){
        CGSize newSize=size;
        newSize.width=self.view.frame.size.width;
        newSize.height=size.height*newSize.width/size.width;
        while (newSize.height>scrSize.height) {
            newSize.width-=1;
            newSize.height=size.height*newSize.width/size.width;

        }
        
        playerView.frame=drawingView.frame=CGRectMake(0,0,newSize.width,newSize.height);
       
        playerView.center=drawingView.center=self.view.center;
        NSLog(@"Size:(%f,%f)",playerView.frame.size.width,playerView.frame.size.height);
    }
    else{
        CGSize newSize=size;
        newSize.height=self.view.frame.size.height;
        newSize.width=size.width*newSize.height/size.height;
        while (newSize.width>scrSize.width) {
            newSize.height-=1;
            newSize.width=size.width*newSize.height/size.height;
            
        }
        
        playerView.frame=drawingView.frame=CGRectMake(0,0,newSize.width,newSize.height);
        
        playerView.center=drawingView.center=self.view.center;
        NSLog(@"Size:(%f,%f)",playerView.frame.size.width,playerView.frame.size.height);

    }
}
-(void)videoOutputSetting:(CGSize)size{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *rawImagesFolder = [NSString stringWithFormat:@"TestVideo.mp4"];
    
    videoFile = [[documentsDirectory stringByAppendingPathComponent:rawImagesFolder]retain];
    if([[NSFileManager defaultManager]fileExistsAtPath:videoFile]){
        [[NSFileManager defaultManager]removeItemAtPath:videoFile error:Nil];
    }
  
    NSLog(@"%@",videoFile);
    NSError *error = nil;
    
    videoWriter = [[AVAssetWriter alloc] initWithURL:
                                  [NSURL fileURLWithPath:videoFile] fileType:AVFileTypeQuickTimeMovie
                                                              error:&error];
    if(error) {
        
        NSLog(@"error creating AssetWriter: %@",[error description]);
        
          }
    
  NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:size.width], AVVideoWidthKey,
                                   [NSNumber numberWithInt:size.height], AVVideoHeightKey,
                                   nil];
    
    writerInput = [[AVAssetWriterInput
                                        assetWriterInputWithMediaType:AVMediaTypeVideo
                                        outputSettings:videoSettings] retain];
    
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    [attributes setObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32ARGB] forKey:(NSString*)kCVPixelBufferPixelFormatTypeKey];
    
    [attributes setObject:[NSNumber numberWithUnsignedInt:size.width] forKey:(NSString*)kCVPixelBufferWidthKey];
    
    [attributes setObject:[NSNumber numberWithUnsignedInt:size.height] forKey:(NSString*)kCVPixelBufferHeightKey];
    
    adaptor = [[AVAssetWriterInputPixelBufferAdaptor
                                                     assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput
                                                     sourcePixelBufferAttributes:attributes]retain];
    
    [videoWriter addInput:writerInput];
    
    
    nextPresentationTimeStamp=kCMTimeZero;
    
    // fixes all errors
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:nextPresentationTimeStamp];
    
    
    
        
                
    
    
}
-(void)AddFrameToVideo:(UIImage*)frame{
 
    CVPixelBufferRef pixelBuffer = [ self pixelBufferForUIImage:frame];
    
    if(pixelBuffer){
    A:
        if (adaptor.assetWriterInput.readyForMoreMediaData){
            
            [adaptor appendPixelBuffer:pixelBuffer withPresentationTime:nextPresentationTimeStamp];
            ++i;
            nextPresentationTimeStamp=CMTimeAdd(nextPresentationTimeStamp,CMTimeMake(1,30));
        }
        else{
            
            goto A;
        }
    }
    
    if(pixelBuffer)
        CVBufferRelease(pixelBuffer);
    
    pixelBuffer = NULL;

}
- (CVPixelBufferRef)pixelBufferForUIImage:(UIImage*)image
{
    
    
    CGImageRef imageRef = image.CGImage;
    
    CVPixelBufferRef buffer = NULL;
    
    size_t width = CGImageGetWidth(imageRef);
    
    size_t height = CGImageGetHeight(imageRef);
    
    // Pixel buffer options
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey, nil];
    
    // Create the pixel buffer
    CVReturn result1 = CVPixelBufferCreate(NULL, width, height, kCVPixelFormatType_32ARGB, ( CFDictionaryRef) options, &buffer);
    
    if (result1 == kCVReturnSuccess && buffer) {
        
        CVPixelBufferLockBaseAddress(buffer, 0);
        
        void *bufferPointer = CVPixelBufferGetBaseAddress(buffer);
        
        // Define the color space
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        // Create the bitmap context to draw the image
        CG_EXTERN CGContextRef CGBitmapContextCreate(void *data, size_t width,
                                                     size_t height, size_t bitsPerComponent, size_t bytesPerRow,
                                                     CGColorSpaceRef space, CGBitmapInfo bitmapInfo)
        CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);
        
        CGContextRef context = CGBitmapContextCreate(bufferPointer, width, height, 8, 4 * width, colorSpace, kCGImageAlphaNoneSkipFirst);
        
        CGColorSpaceRelease(colorSpace);
        
        if (context) {
            //            CGContextTranslateCTM(context, width / 2, height / 2);
            //            CGContextRotateCTM(context, M_PI_2);
            //            CGContextTranslateCTM(context, -height / 2, -width / 2);
            //            CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef)), imageRef);
            
            CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
            
            CGContextRelease(context);
            
        }
        
        CVPixelBufferUnlockBaseAddress(buffer, 0);
    }
    return buffer;
}

-(void)videoCompleteAlert{
     UISaveVideoAtPathToSavedPhotosAlbum(videoFile, Nil, Nil, nil);
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Video save alert" message:@"Video has been saved in library" delegate:Nil cancelButtonTitle:Nil otherButtonTitles:@"OK", nil];
    [alt show];
    [alt release];
}
-(void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    [self.mediaPlayer1 pause];
    [self.mediaPlayer1.currentItem seekToTime:kCMTimeZero];
    [self.mediaPlayer1 play];
    
}
-(IBAction)playpauseVideo:(id)sender{
    if(isPlaying){
         [self.mediaPlayer1 pause];
        [self currentItemScreenShot];
        isPlaying=NO;
        [(UIButton*)sender setTitle:@"Play" forState:UIControlStateNormal];
    }
    else{
        isPlaying=YES;
        [self.mediaPlayer1 play];
        [(UIButton*)sender setTitle:@"Pause" forState:UIControlStateNormal];
    }
}
-(CGSize)VideoSize:(NSString*)url{
    
    NSURL *videoURL = [NSURL fileURLWithPath:url isDirectory:YES];
    
    NSDictionary *inputOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    
    AVURLAsset *inputAsset = [[AVURLAsset alloc] initWithURL:videoURL options:inputOptions];
    
   
    BOOL  isRotation=NO;
      CGSize size = [[[inputAsset tracks]objectAtIndex:0] naturalSize];
    if([[[[inputAsset tracks]objectAtIndex:0] mediaType]isEqualToString:@"soun"]){
        size = [[[inputAsset tracks]objectAtIndex:1] naturalSize];
    }
      CGAffineTransform txf = [[[inputAsset tracks]objectAtIndex:0] preferredTransform];
    
      if (size.width == txf.tx && size.height == txf.ty)
          NSLog(@"Right Landscaspe");
      else if (txf.tx == 0 && txf.ty == 0)
          NSLog(@"Left Landscaspe");
      else if (txf.tx == 0 && txf.ty == size.width){
          isRotation=YES;
        size=CGSizeMake(size.height,size.width);
      }
      else{
          isRotation=YES;
          size=CGSizeMake(size.height,size.width);
      }
       
    return size;
    
}

- (void)currentItemScreenShot{
   
    CMTime time = [[self.mediaPlayer1 currentItem] currentTime];
    AVAsset *asset = [[self.mediaPlayer1 currentItem] asset];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    if ([imageGenerator respondsToSelector:@selector(setRequestedTimeToleranceBefore:)] && [imageGenerator respondsToSelector:@selector(setRequestedTimeToleranceAfter:)]) {
        [imageGenerator setRequestedTimeToleranceBefore:kCMTimeZero];
        [imageGenerator setRequestedTimeToleranceAfter:kCMTimeZero];
    }
    CGImageRef imgRef = [imageGenerator copyCGImageAtTime:time
                                               actualTime:NULL
                                                    error:NULL];
    if (imgRef == nil) {
        if ([imageGenerator respondsToSelector:@selector(setRequestedTimeToleranceBefore:)] && [imageGenerator respondsToSelector:@selector(setRequestedTimeToleranceAfter:)]) {
            [imageGenerator setRequestedTimeToleranceBefore:kCMTimePositiveInfinity];
            [imageGenerator setRequestedTimeToleranceAfter:kCMTimePositiveInfinity];
        }
        imgRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    }
    UIImage *image = [[UIImage alloc] initWithCGImage:imgRef];
    CGImageRelease(imgRef);
    [imageGenerator release];
    
    playerView.image=[image autorelease];
    videoImage=image;
    if(isPlaying){
    
    if(CMTimeGetSeconds(self.mediaPlayer1.currentItem.currentTime) >=CMTimeGetSeconds(self.mediaPlayer1.currentItem.duration)){
        [self.mediaPlayer1 pause];
        [self.mediaPlayer1 seekToTime:kCMTimeZero];
        [self.mediaPlayer1 play];
    }
    }
   
    [self performSelector:@selector(currentItemScreenShot) withObject:nil afterDelay:1.0/30];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage*) maskImage:(UIImage *)image1 withMask:(UIImage *)image2 {
    
    CGSize size = image1.size;
    
    UIGraphicsBeginImageContext(size);
    
    CGPoint thumbPoint = CGPointMake(0,0);
    
    [image1 drawAtPoint:thumbPoint];
    
    
    CGPoint starredPoint = CGPointMake(0, 0);
    
    [image2 drawAtPoint:starredPoint];
    
    UIImage *imageC = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return imageC;
}
-(IBAction)stoprecording:(id)sender{
    if(isRecording){
        
        [self.mediaPlayer1 pause];
        [self currentItemScreenShot];
        isPlaying=isRecording=NO;
        [(UIButton*)sender setTitle:@"Wait" forState:UIControlStateNormal];
        
        [writerInput markAsFinished];
      
        [videoWriter finishWritingWithCompletionHandler:^(){
            
            [(UIButton*)sender setTitle:@"Completed" forState:UIControlStateNormal];
            
            CVPixelBufferPoolRelease(adaptor.pixelBufferPool);
            
            [videoWriter release];
            
            [writerInput release];
            
            [adaptor release];
           // [self videoCompleteAlert];
           
        }];
       
       
      
        
    }
    else{
        isPlaying=isRecording=YES;
        [self.mediaPlayer1 play];
        i=0;
        [self saveImages];
        [(UIButton*)sender setTitle:@"Stop Recording" forState:UIControlStateNormal];
        
        
    }
}
- (UIImage *) NewImage: (UIImage *) Image fillSize: (CGSize) viewsize

{
	UIGraphicsBeginImageContext(viewsize);
    
    [Image drawInRect:CGRectMake(0, 0, viewsize.width, viewsize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


-(void)saveImages{
    if(isRecording ){
   
     if(videoImage){
         
        UIGraphicsBeginImageContext(movieView.frame.size);
        [movieView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage  *image1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image1=[self maskImage:videoImage withMask:image1];
         image1=[self NewImage:image1 fillSize:CGSizeMake(1024,1024)];
        [self AddFrameToVideo:image1];
         videoImage=Nil;
        
    }
        
   [self performSelector:@selector(saveImages) withObject:nil afterDelay:1.0/30];
        
    }
}
@end
