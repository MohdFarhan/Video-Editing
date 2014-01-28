//
//  ViewController.h
//  VideoInImageView
//
//  Created by Farhan Khan on 08/08/13.
//  Copyright (c) 2013 Triffort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "LinearInterpView.h"
@class AVPlayer;

@interface ViewController : UIViewController{
    AVPlayer* mediaPlayer1;
    IBOutlet UIImageView *playerView;
       BOOL isPlaying,isRecording;
  IBOutlet LinearInterpView *drawingView,*movieView;
    UIImage *videoImage;
    
    NSString *videoFile;
      CMTime  nextPresentationTimeStamp;
    AVAssetWriter *videoWriter;
    AVAssetWriterInputPixelBufferAdaptor*adaptor;
    AVAssetWriterInput* writerInput;
    int i;
}
@property (readwrite, retain) AVPlayer* mediaPlayer1;
-(IBAction)playpauseVideo:(id)sender;
-(IBAction)prelaypauseVideo:(id)sender;

-(IBAction)stoprecording:(id)sender;



@end
