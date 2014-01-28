//  AppDelegate.m
//  THATSWINNING
//  Created by Mohit on 18/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "AppDelegate.h"
#import "ViewController.h"
#import "DejalActivityView.h"
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import "NightTrackingViewController.h"

#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "JSON.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFHTTPRequestOperation.h"
#import "SBJsonWriter.h"

@implementation AppDelegate
@synthesize walkRouteTimer1,locationManager;

-(void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

-(void)applicationDidEnterBackground:(UIApplication *)application
{
     
  if(isCallCheckTractingOn){
      NSDate *currDate=[NSDate date];
      NSTimeInterval interval = [self.baseDate timeIntervalSinceDate:currDate];
      
      updateTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                          target:self
                                                        selector:@selector(startTracking)
                                                        userInfo:nil
                                                         repeats:NO];
      
      backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
          NSLog(@"Background handler called. Not running background tasks anymore.");
          [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
          backgroundTask = UIBackgroundTaskInvalid;
      }];
      
      }
      
   
}


-(void)applicationWillEnterForeground:(UIApplication *)application
{
   // NSLog(@"Foreground");
      [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
	backgroundTask = UIBackgroundTaskInvalid;
[self checkTracking];
    
}

-(BOOL)isConnected
{
	NSString	*string = @"https://www.google.co.in/";
	NSURL		*url = [[NSURL alloc] initWithString:string];
	NSError		*error;
	NSString	*text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
	if( text == nil )
    {
		NSString	*localString = @"https://www.google.co.in/";
		NSURL		*localUrl = [[NSURL alloc] initWithString:localString];
		NSError		*localError;
		NSString	*localText = [NSString stringWithContentsOfURL:localUrl encoding:NSASCIIStringEncoding error:&localError];
		if (localText == nil)
        {
			return NO;
		}
		else
        {
			return YES;
		}
	}
	else
    {
		return YES;
	}
	return NO;
}



-(NSArray *) getArrayFromJSONDictionary:(NSDictionary *)parent forKey:(NSString *)key
{
    id obj = [parent objectForKey:key];
    if([obj isKindOfClass:[NSArray class]])
    {
        return obj;
    }
    if([obj length]==0)
    {
        return [[[NSArray alloc] init] autorelease];
    }
    NSArray *ret = [NSArray arrayWithObject:obj];
    return ret;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(![defaults objectForKey:@"DatabaseID"]){
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:      [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
      
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=DeviceToken&token=%@",token];
   
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
    
	SBJSON *json = [[SBJSON new] autorelease];
    
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    
	[responseString release];   
   
    
    [defaults setObject:[recievedData objectForKey:@"notificationid" ] forKey:@"DatabaseID"];
   
    [defaults synchronize];
        
    }
    
}



- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
       NSLog(@"Push notifications are not supported in the iOS Simulator.");
      } else {
           // show some alert or otherwise handle the failure to register.
           NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
            }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    
}


- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif
{
    
   }





-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];

    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Coin"ofType:@"caf"]] error:nil];
    preMinute =-1.0;
    self.TimeArray = [[NSMutableArray alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self checkTracking];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLastPhotoThumbnail) name:ALAssetsLibraryChangedNotification object:nil];
    
    strlocation=[[NSString alloc]init];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    

    @try
    {
        BOOL a=[self isConnected];
        if(a==YES)
        {
            self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];

            }
            else {
                self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];

            }
            
            self.NavContr1oller=[[UINavigationController alloc]initWithRootViewController:self.viewController];
            self.NavContr1oller.navigationItem.hidesBackButton = TRUE;



            self.window.rootViewController = self.viewController;
            self.window.rootViewController=self.NavContr1oller;
            
            [self.window addSubview:[self.NavContr1oller view]];
            [self.window makeKeyAndVisible];
            return YES;

        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"No Connection" message:@"Some Functions Might Be Missing"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
            return YES;
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception);
    }
}
-(void)callCheckTracking:(NSTimeInterval)timeinterval {
   
    timeIntervale=timeinterval;
    //[self startTracking];
    isCallCheckTractingOn=YES;
   [NSTimer scheduledTimerWithTimeInterval:timeinterval target:self selector:@selector(startTracking) userInfo:nil repeats:NO];
}
-(void)checkTracking {
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *startTime = [defaults objectForKey:@"startTime"];
    NSString *endTime = [defaults objectForKey:@"endTime"];
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *trackingSwitch = [defaults objectForKey:@"trackingswitch"];
    

    if ([startTime length] > 0 && endTime > 0 && [trackingSwitch length] > 0 ) {
        
        static NSDateFormatter *dateFormatter;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
            
        }
        NSDate *startdate = [dateFormatter dateFromString:startTime];
        NSDate *endDate = [dateFormatter dateFromString:endTime];
        NSDate *currentDate = [NSDate date];
        
        if (([startdate compare:currentDate] == NSOrderedAscending || [startdate compare:currentDate] == NSOrderedSame) && ([endDate compare:currentDate] == NSOrderedDescending || [endDate compare:currentDate] == NSOrderedSame) && [trackingSwitch isEqualToString:@"on"]) {
            [self startTracking];
        }
        else if(([startdate compare:currentDate] == NSOrderedDescending) && [trackingSwitch isEqualToString:@"on"]) {
            
            
            [self callCheckTracking:[startdate timeIntervalSinceDate:currentDate]];
           
        }

        else  {
            [self stopTracking];
            
        }
    }
    
   }
-(void) startTracking {
    isCallCheckTractingOn=YES;
   // [self.locationManager stopUpdatingLocation];
    [self.locationManager startUpdatingLocation];
}
-(void)stopLocationTracking{
    isCallCheckTractingOn=NO;
    [self.locationManager stopUpdatingLocation];
}
-(void)isTimeOver{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *startTime = [defaults objectForKey:@"startTime"];
    NSString *endTime = [defaults objectForKey:@"endTime"];
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *trackingSwitch = [defaults objectForKey:@"trackingswitch"];
      
    if ([startTime length] > 0 && endTime > 0 && [trackingSwitch length] > 0 ) {
        
        static NSDateFormatter *dateFormatter;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
            
        }
       
        NSDate *endDate = [dateFormatter dateFromString:endTime];
        NSDate *currentDate = [NSDate date];
        NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
        currentDate = [dateFormatter dateFromString:currentDateStr];
        
                
        if (([endDate compare:currentDate] == NSOrderedAscending) && [trackingSwitch isEqualToString:@"on"]) {
            [self stopTracking];
               }
        else
            [self performSelector:@selector(isTimeOver) withObject:nil afterDelay:30.0];
    }
    
        

}

-(void)stopTracking{
    isCallCheckTractingOn=NO;
    [self.locationManager stopUpdatingLocation];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"startTime"];
    [defaults removeObjectForKey:@"endTime"];
    [defaults removeObjectForKey:@"trackingswitch"];
    [defaults synchronize];
    NightTrackingViewController *controller = [self.NavContr1oller.viewControllers lastObject];
    
    if ([controller isKindOfClass:[NightTrackingViewController class]]) {
        [controller checkTrackingStatus];
    }
    
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
   
  
   
    NSDate *date = [NSDate date];
    if (self.preDate == nil) {
        self.preDate = date;
    }
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *startTime = [defaults objectForKey:@"startTime"];
    NSString *endTime = [defaults objectForKey:@"endTime"];
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *trackingSwitch = [defaults objectForKey:@"trackingswitch"];
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[[NSDateFormatter alloc] init]retain];
        [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
        
    }
       
    if ([startTime length] > 0 && endTime > 0 && [trackingSwitch length] > 0 ) {
        
        NSDate *startdate = [dateFormatter dateFromString:startTime];
        NSDate *endDate = [dateFormatter dateFromString:endTime];
        NSDate *currentDate = [NSDate date];
        NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
        currentDate = [dateFormatter dateFromString:currentDateStr];
        
        NSTimeInterval distanceBetweenDates = [date timeIntervalSinceDate:self.preDate];
        NSTimeInterval time = 5.0;
    
        if (([startdate compare:currentDate] == NSOrderedAscending || [startdate compare:currentDate] == NSOrderedSame) && ([endDate compare:currentDate] == NSOrderedDescending || [endDate compare:currentDate] == NSOrderedSame) && [trackingSwitch isEqualToString:@"on"]) {
 
            if (distanceBetweenDates >= time || self.preDate == date) {
                CLLocationDistance distance;
                if (self.preLocation == nil) {
                             distance = [newLocation distanceFromLocation:newLocation];
            
                }
                else {
                    distance = [newLocation distanceFromLocation:self.preLocation];
                    
                }
                NSLog(@"dist %f",distance);
               // if ( self.preLocation == nil) {
                    if (self.preLocation == nil) {
                        self.preLocation = [[CLLocation alloc] init];
                        self.preLocation = newLocation;
                    }
                    
                    //  NSLog(@"(%f,%f)",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
                    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:newLocation,@"new",date,@"date",oldLocation,@"old", nil];
                    //[NSThread detachNewThreadSelector:@selector(nightTrackingWebService:) toTarget:self withObject:dict];
                    //[self performSelector:@selector(nightTrackingWebService:) withObject:dict ];
                    dispatch_queue_t myBackgroundQ = dispatch_queue_create("com.romanHouse.backgroundDelay", NULL);
                    
                    // Could also get a global queue; in this case, don't release it below.
                    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
                    dispatch_after(delay, myBackgroundQ, ^(void){
                        [self nightTrackingWebService:dict];
                       
                    });
                    dispatch_release(myBackgroundQ);
                    [dict release];
                    isCallCheckTractingOn=YES;
                    self.preLocation = newLocation;
                     
                    
//                }
//                  else
//                       NSLog(@"out2");
                self.preDate = date;
            }
          }
        else if([endDate compare:currentDate] == NSOrderedAscending  && [trackingSwitch isEqualToString:@"on"]){           
                [self stopTracking];
                NSLog(@"close4");         
        }
    }
      

[self performSelector:@selector(isTimeOver) withObject:nil afterDelay:30.0];
     
   }




-(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude
{
    CLGeocoder *geoCoder = [[[CLGeocoder alloc] init] autorelease];
    CLLocation *newLocation = [[[CLLocation alloc]initWithLatitude:pdblLatitude longitude:pdblLongitude] autorelease];
    
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            
            NSString *street_str = @"";
            
            if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStreetKey]] isEqualToString:@"(null)"]) {
                
                street_str = @"Street";
            }
            else{
                
                street_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStreetKey]];
            }
            
            NSString *city_str = @"";
            
            
            if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCityKey]] isEqualToString:@"(null)"]) {
                
                city_str = @"City";
            }
            else{
                
                city_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCityKey]];
            }
            
            NSString *state_str = @"";
            
            if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStateKey]] isEqualToString:@"(null)"]) {
                
                state_str = @"State";
            }
            else{
                
                state_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStateKey]];
            }
            
            NSString *country_str = @"";
            
            if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCountryKey]] isEqualToString:@"(null)"]) {
                
                country_str = @"Country";
            }
            else{
                
                country_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCountryKey]];
            }

            
            self.placeAddress = [NSString stringWithFormat:@"%@_%@_%@_%@(%f,%f)",street_str,city_str,state_str,country_str,pdblLatitude,pdblLongitude];



        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationNotification" object:nil];

        }
    }];
    

    return nil;
}
-(void)nightTrackingWebService:(NSDictionary *)dict
{
    CLLocation *newLocation = [dict objectForKey:@"new"];
    CLLocation *oldLocation = [dict objectForKey:@"old"];
    NSDate *date = [dict objectForKey:@"date"];
    double pdblLatitude = newLocation.coordinate.latitude;
    double pdblLongitude = newLocation.coordinate.longitude;
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];

    }
    NSString *datestr = [dateFormatter stringFromDate:date];
    //datestr = [datestr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *idstr = [defaults objectForKey:@"studentID"];
    NSString *startTime = [defaults objectForKey:@"startTime"];
    NSString *endTime = [defaults objectForKey:@"endTime"];
    
    NSString *tracking_time = [self getDatefromDateTimeString:startTime endTime:endTime];
    //tracking_time =   [tracking_time stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    float speed = newLocation.speed;
    if (speed == -1.0) {
        speed = 0.0;
    }
    NSString *speedStr = [NSString stringWithFormat:@"%f",speed];
    
    NSString  *runningStatus =@"1" ;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = kCFCalendarUnitMinute;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger minute = [components minute];
    if (preMinute == -1.0 ) {
        preMinute = minute;
    }
     NSLog(@"timeDiff=%f",minute-preMinute);
    if (preMinute != minute) {
        [self.TimeArray addObject:newLocation];
      
        if ([self.TimeArray count] == 5) {
            CLLocation *firstLocation = [self.TimeArray objectAtIndex:0];
            CLLocation *secondLocation = [self.TimeArray objectAtIndex:4];
            CLLocationDistance distance = [firstLocation distanceFromLocation:secondLocation];
            
            if (distance > 25) {
                runningStatus = @"1";
            }
            else {
                runningStatus = @"0";
            }
            [self.TimeArray removeObjectAtIndex:0];
        } 
        preMinute = minute;
    }
    CLLocationDistance distance = [oldLocation distanceFromLocation:newLocation];
    NSString *addressstr = [NSString stringWithFormat:@"%f",distance];
    
    if (startTime && endTime) {
       

        //        NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=Add_loc&uid=%@&lat=%f&long=%f&locname=%@&cdate=%@&tracking_time=%@&tracking_speed=%@&tracking_status=%@",idstr,pdblLatitude,pdblLongitude,addressstr,datestr,tracking_time,speedStr,runningStatus];
        
        //        NSString *str = idstr;
        //         NSString *str1 = pdblLatitude;
        //         NSString *str2 = pdblLongitude;
        //         NSString *str3 = idstr; NSString *str7 = idstr;
        //         NSString *str4 = idstr;
        //         NSString *str5 = idstr;
        //         NSString *str6 = idstr;
        //         NSString *str8 = idstr;
        
        
        NSString *latStr = [NSString stringWithFormat:@"%f",pdblLatitude];
        NSString *lonStr = [NSString stringWithFormat:@"%f",pdblLongitude];
               NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:idstr,@"u_id",latStr,@"lat",lonStr,@"long12",addressstr,@"location_name",datestr,@"date",tracking_time,@"tracking_time",speedStr,@"tracking_speed",runningStatus,@"tracking_status", nil];
        
        //        NSFileManager *fileManager = [NSFileManager defaultManager];
        //        if ( ![fileManager fileExistsAtPath:self.TrackingFilePath] )
        //        {
        //            NSMutableArray *ar = [[NSMutableArray alloc] init];
        //            [ar writeToFile:self.TrackingFilePath atomically:YES];
        //        }
        NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:dict, nil];
        //        if (!arr) {
        //            arr = [[NSMutableArray alloc] init];
        //        }
        // NSURL *url = [[NSURL alloc]initWithString:strurl];
        //        [arr addObject:dict];
        // [self stopTracking:arr];
        
        NSMutableArray *jsonDic = [[NSMutableArray alloc] initWithArray:arr];
        
        NSString *urlStr = @"traker/Add_loc.php";
        
        
        //SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
        
        
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
        
        AFHTTPClient *httpClient = [[[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.thatswinning.com"]] autorelease];
        
        [httpClient setParameterEncoding:AFFormURLParameterEncoding];
        
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                                path:urlStr
                                                          parameters:nil];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:jsonData];
        
        [request setHTTPBody:body];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *responseDict = [responseString JSONValue];
          //  NSLog(@"Success: %@", responseDict);
                      // NSLog(@"(%@,%@)",latStr,lonStr);
            
        }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             NSLog(@"Error: %@", error);
                                             
                                         }];
        
        [operation start];
        
    }
    //[self stopTracking];
    
    //[arr writeToFile:self.TrackingFilePath atomically:YES];
    
    //        responseData = [NSData dataWithContentsOfURL:url];  [{"u_id":1,"lat":"102365","long12":"62.2365","location_name":"testing","date":"2013-08-19","tracking_time":"00:00:00","tracking_speed":"2","tracking_status":"1"}
    //        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //        [responseString release];
    
    
}

-(NSString *)getDatefromDateTimeString:(NSString *)startTime endTime:(NSString *)endTime {
    NSString *datestr1 = [startTime substringToIndex:10];
    NSString *timestr1 = [startTime substringFromIndex:11];
    
    NSString *timestr2 = [endTime substringFromIndex:11];
    NSString *str = [NSString stringWithFormat:@"%@ (%@ - %@)",datestr1,timestr1,timestr2];
    return str;
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

-(void)applicationWillResignActive:(UIApplication *)application
{
   
}
/*
-(void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}


- (void)applicationWillTerminate:(UIApplication *)application
{
}
*/
@end
