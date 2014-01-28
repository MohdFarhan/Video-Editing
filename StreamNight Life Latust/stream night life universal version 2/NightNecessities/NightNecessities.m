//
//  NightNecessities.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "NightNecessities.h"
#import "NecessitiesList.h"
#import "FindARideViewController.h"
#import "EmergencyViewController.h"
#import "iAd/iAd.h"

@interface NightNecessities() <ADBannerViewDelegate,UIActionSheetDelegate>
@property(nonatomic,retain) ADBannerView *adBannerView;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *items;

@property BOOL currentOrientation;

@end

@implementation NightNecessities
@synthesize carousel;
@synthesize wrap;
@synthesize items;

- (void)setUp
{
    //set up data
    wrap = YES;
    self.items = [[NSMutableArray array]init];
    for (int i = 0; i < 3; i++)
    {
        [self.items addObject:@(i)];
    }
    
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    CGRect bannerFrame = CGRectZero;
    CGSize iPadBasic = CGSizeMake(0.0, 66.0);
    CGSize iPhoneBasic = CGSizeMake(0.0, 32.0);
    CGSize deviceSize = self.view.bounds.size;
    
    if([self currentDevice]) { // iPad
        //        if (_currentOrientation == 0) {
        //            bannerFrame = CGRectMake(0.0, deviceSize.width - iPadBasic.height, deviceSize.height , deviceSize.width);
        //        } else {
        bannerFrame = CGRectMake(0.0, deviceSize.height - iPadBasic.height, deviceSize.width, iPadBasic.height);
        //        }
    } else { // iPhone
        //        if (_currentOrientation) { // iphone portrait
        //            bannerFrame = CGRectMake(0.0, self.view.frame.size.height - 50, 0.0, 0.0);
        //        } else {
        bannerFrame = CGRectMake(0.0, self.view.frame.size.height - iPhoneBasic.height- 17, self.view.bounds.size.width, iPhoneBasic.height);
        //        }
    }
    [_adBannerView setFrame:bannerFrame];
    _adBannerView.hidden = NO;
    
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    _adBannerView.hidden = YES;
}

-(void)currentOrientation:(NSNotification *)notification {
    if ([[notification object] orientation] != 3 && [[notification object] orientation] != 4 && [[notification object] orientation] != 5 && [[notification object] orientation] != 6) {
        _currentOrientation = 1; // Portrait mode
    } else if ([[notification object] orientation] != 5 && [[notification object] orientation] != 6) {
        _currentOrientation = 0; // landscape mode
    }
}

-(BOOL)currentDevice {
    if ([[UIDevice currentDevice] userInterfaceIdiom]) {
        return 1; // iPad device
    } else {
        return 0; // iPhone device
    }
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUp];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL  isNotFirstTime = [defaults boolForKey:@"isNightNecessitiesNotFirstTime"];
    if(!isNotFirstTime){
        [[NSUserDefaults standardUserDefaults]  setBool:YES forKey:@"isNightNecessitiesNotFirstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alrtView=[[UIAlertView alloc]initWithTitle:@"Welcome!" message:@"Here you'll find some handy information about life on campus. Tips, games, and places all shared by students! In each section down at the bottom there is a sharing button. Click and share everything you know about life at your school!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrtView show];
        
    }
    

    campusLocation_Label.text = [defaults objectForKey:@"CampusLocation"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(currentOrientation:)
                                                 name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    

carousel.backgroundColor=[UIColor clearColor];
 carousel.type = iCarouselTypeCoverFlow2;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(createBackButton) withObject:nil afterDelay:0.1];
    
    _adBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    [_adBannerView setDelegate:self];
    [_adBannerView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin)];
    _adBannerView.hidden = YES;
    [self.view addSubview:_adBannerView];

    
}
-(void)createBackButton
{
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,58,30);
    button1.titleLabel.font= [UIFont boldSystemFontOfSize:14];
    [button1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed: @"back1.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
}

-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onButtonClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NecessitiesList *necessitiesList;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        necessitiesList = [[NecessitiesList alloc] initWithNibName:@"NecessitiesList" bundle:nil];

    }
    else {
        necessitiesList = [[NecessitiesList alloc] initWithNibName:@"NecessitiesList_iPad" bundle:nil];

    }
    necessitiesList.campusLocationString = campusLocation_Label.text;
    necessitiesList.titleString = btn.titleLabel.text;
    [self.navigationController pushViewController:necessitiesList animated:YES];
    
}

-(IBAction)onClickFindRide_Button:(id)sender {
    
    FindARideViewController *findRideViewController;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        findRideViewController = [[FindARideViewController alloc] initWithNibName:@"FindARideViewController" bundle:nil];
    }
    else {
        findRideViewController = [[FindARideViewController alloc] initWithNibName:@"FindARideViewController_iPad" bundle:nil];
    }
    
    [self.navigationController pushViewController:findRideViewController animated:YES];
}

-(IBAction)onClickEmergency_Button:(id)sender {
    EmergencyViewController *emergencyViewController;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        emergencyViewController = [[EmergencyViewController alloc] initWithNibName:@"EmergencyViewController" bundle:nil];

    }
    else {
        emergencyViewController = [[EmergencyViewController alloc] initWithNibName:@"EmergencyViewController_iPad" bundle:nil];

    }
    [self.navigationController pushViewController:emergencyViewController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UIActionSheet methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0)
    {
        //map button index to carousel type
        iCarouselType type = buttonIndex;
        
        //carousel can smoothly animate between types
        [UIView beginAnimations:nil context:nil];
        carousel.type = type;
        [UIView commitAnimations];
        
        //update title
        // navItem.title = [actionSheet buttonTitleAtIndex:buttonIndex];
    }
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    NSLog(@"Count=%d",self.items.count);
    return [self.items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 210.0f, 300.0f)];
        //        switch (index) {
        //            case 0:
        //                <#statements#>
        //                break;
        //
        //            default:
        //                break;
        //        }
        UIImage *image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",index+4]];
        ((UIImageView *)view).image = image;
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        //[view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [items[index] stringValue];
    
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 210, 300.0f)];
        UIImage *image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",index+4]];
        ((UIImageView *)view).image = image;
        
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        label.tag = 1;
        // [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = (index == 0)? @"[": @"]";
    
    return view;
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}
- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel{
}
- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (self.items)[index];
    ++index;
    
    if(!index){
       
        [self onButtonClick:nil];
    }
    else  if(index==1){
        
       
        [self onClickFindRide_Button:nil];
    }
    else  {
        
        [self onClickEmergency_Button:nil];
    }
       NSLog(@"Tapped view number: %@", item);
}


@end
