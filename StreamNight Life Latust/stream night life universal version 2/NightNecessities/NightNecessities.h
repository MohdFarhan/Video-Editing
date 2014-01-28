//
//  NightNecessities.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/ADBannerView.h"
#import "iCarousel.h"
@interface NightNecessities : UIViewController<iCarouselDataSource, iCarouselDelegate> {
    IBOutlet UILabel *campusLocation_Label;

    
}
@property (nonatomic, strong) IBOutlet iCarousel *carousel;
-(IBAction)onButtonClick:(id)sender;
-(IBAction)onClickFindRide_Button:(id)sender;
-(IBAction)onClickEmergency_Button:(id)sender;


@end
