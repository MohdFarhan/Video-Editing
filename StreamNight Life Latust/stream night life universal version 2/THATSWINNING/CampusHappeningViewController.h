//
//  CapusHappeningViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 20/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "FXImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Alpha.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
@interface CampusHappeningViewController : UIViewController<iCarouselDataSource, iCarouselDelegate>{
    UIView *bottomview;
    IBOutlet UIButton *b1,*b2;
    IBOutlet UILabel *campusLocation_Label;
}
@property (nonatomic, strong) IBOutlet iCarousel *carousel;
- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform;
-(IBAction)goToEvent:(id)sender;
@end
