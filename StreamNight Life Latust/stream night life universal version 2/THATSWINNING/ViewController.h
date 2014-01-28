
//  ViewController.h
//  THATSWINNING
//  Created by Mohit on 18/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DejalActivityView.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "iCarousel.h"
#import "FXImageView.h"
 #import <QuartzCore/QuartzCore.h>
#import "UIImage+Alpha.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
extern NSString *strlocation;

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate,UIAlertViewDelegate,iCarouselDataSource, iCarouselDelegate>
{
    IBOutlet UIImageView *campus;
    IBOutlet UIButton *campusbtn;
    IBOutlet UIButton *signupBtn;
    
    UITableView *tableService;
    NSMutableArray *arraycampus;
    UILabel *lbl;
    UIView *bottomview;
    IBOutlet UIButton *b1,*b2,*b3;
    IBOutlet UILabel *locationLabel;
    AppDelegate *delegate;
    CGRect oldRect;
    IBOutlet UITableView *campus_TableView;
    
        
}
@property (nonatomic, strong) IBOutlet iCarousel *carousel;
-(IBAction)showcampus:(id)sender;
-(IBAction)movetodeal_location:(id)sender;
-(IBAction)movetoAdmin:(id)sender;
- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel;
- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view;
@end
