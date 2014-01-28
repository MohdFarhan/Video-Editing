
//  AppDelegate.h
//  THATSWINNING
//  Created by Mohit on 18/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import <UIKit/UIKit.h>
#import "JSON.h"
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@class setting;
@class ViewController;
NSString *strlocation;
BOOL isWalking;
int dier,runningtimer1;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    float preMinute,timeIntervale;
    BOOL isCallCheckTractingOn;
    UIBackgroundTaskIdentifier backgroundTask;
     AVAudioPlayer *player;
    NSTimer *updateTimer;
    int i;
  
}
@property(nonatomic,retain) CLLocation *preLocation;
@property(nonatomic,retain)NSDate *preDate;
@property(nonatomic,retain) NSDate *baseDate;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(BOOL)callMain:(id)sender;
-(BOOL)callMain1:(id)sender;
-(void) startTracking;
-(void)stopTracking;
-(void)checkTracking;

-(void)stopLocationTracking;
-(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude;
-(void)callCheckTracking:(NSTimeInterval)timeinterval;
-(BOOL)isConnected;

@property (strong, nonatomic) NSTimer *walkRouteTimer1;
@property (strong, nonatomic) UINavigationController *NavContr1oller;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic,retain) UILabel *centerLocation_Label;
@property (nonatomic,retain) UILabel *dropOff_CenterLocation;
@property CLLocationCoordinate2D coordinate;
@property(nonatomic,retain) NSString *placeAddress;
@property (nonatomic,retain)CLLocationManager *locationManager;
@property (nonatomic,retain) NSMutableArray *TimeArray;

@end
