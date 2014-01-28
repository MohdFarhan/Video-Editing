//
//  MapViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 13/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "RouteMapViewController.h"
#import "SBJSON.h"
#import <CoreLocation/CoreLocation.h>
#import "CSMapRouteLayerView.h"
#import "CSMapAnnotation.h"
#import "CSImageAnnotationView.h"
#import <QuartzCore/QuartzCore.h>
#import "TravelStatsViewController.h"
#import <AddressBook/AddressBook.h>

MKCoordinateRegion region;

@interface RouteMapViewController ()

@end

@implementation RouteMapViewController
@synthesize routeView = _routeView;
@synthesize mapView   = _mapView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getlatLongFromServer];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self performSelector:@selector(come) withObject:nil afterDelay:0.1];
}

-(void)come
{
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,58,30);
    button1.titleLabel.font= [UIFont boldSystemFontOfSize:14];
    [button1 addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed: @"back1.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
}

-(IBAction)done:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getlatLongFromServer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *idstr = [defaults objectForKey:@"studentID"];
    
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=GetLocAcodDate&tracking_time=%@&uid=%@",self.trackingtime,idstr];
    strurl =   [strurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    NSURL *url = [[NSURL alloc]initWithString:strurl];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSError *error;
    SBJSON *json = [SBJSON new];
    NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    if ([[recievedData objectForKey:@"Latitude"] isKindOfClass:[NSArray class]]) {
        lat_Array = [[NSMutableArray alloc] initWithArray:[recievedData objectForKey:@"Latitude"]];
        lon_Array = [[NSMutableArray alloc] initWithArray:[recievedData objectForKey:@"Longitude"]];
        address_Array = [[NSMutableArray alloc] initWithArray:[recievedData objectForKey:@"LocationName"]];
        date_Array = [[NSMutableArray alloc] initWithArray:[recievedData objectForKey:@"Date"]];
        speed_Array = [[NSMutableArray alloc] initWithArray:[recievedData objectForKey:@"TrackingSpeed"]];
        status_Array = [[NSMutableArray alloc] initWithArray:[recievedData objectForKey:@"TrackingStatus"]];



    }
    else {
        lat_Array = [[NSMutableArray alloc] initWithObjects:[recievedData objectForKey:@"Latitude"], nil];
        lon_Array = [[NSMutableArray alloc] initWithObjects:[recievedData objectForKey:@"Longitude"], nil];
        address_Array = [[NSMutableArray alloc] initWithObjects:[recievedData objectForKey:@"LocationName"], nil];
        date_Array = [[NSMutableArray alloc] initWithObjects:[recievedData objectForKey:@"Date"], nil];
        speed_Array = [[NSMutableArray alloc] initWithObjects:[recievedData objectForKey:@"TrackingSpeed"], nil];
        status_Array = [[NSMutableArray alloc] initWithObjects:[recievedData objectForKey:@"TrackingStatus"], nil];

    }
    
    NSMutableArray* points = [[NSMutableArray alloc] initWithCapacity:lat_Array.count];
    
    CLLocationDegrees latitude0  = [[lat_Array objectAtIndex:0] doubleValue];;
    CLLocationDegrees longitude0 = [[lon_Array objectAtIndex:0] doubleValue];;
    CLLocationDegrees latitudeNth  = [[lat_Array objectAtIndex:lat_Array.count-1] doubleValue];
    CLLocationDegrees longitudeNth = [[lon_Array objectAtIndex:lon_Array.count-1] doubleValue];;
    
    n=lat_Array.count-1;
    int k=1;
	for(int idx = 0; idx < lat_Array.count && idx < lon_Array.count; idx++)
	{
		// break the string down even further to latitude and longitude fields.

	
		CLLocationDegrees latitude  = [[lat_Array objectAtIndex:idx] doubleValue];
		CLLocationDegrees longitude = [[lon_Array objectAtIndex:idx] doubleValue];
		
		CLLocation* currentLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude] ;
		[points addObject:currentLocation];


        
            if ([[status_Array objectAtIndex:idx] isEqualToString:@"0"] && idx &&(idx < lat_Array.count-1 && idx < lon_Array.count-1)) {
                
                if(latitude0 != latitude  && longitude0 != longitude && latitudeNth != latitude  && longitudeNth != longitude ){
                [self addAnnotationWithLocation:currentLocation withtime:[NSString stringWithFormat:@"stoppage (%@)",[date_Array objectAtIndex:idx]] type:-1 recNo:k++];
                    latitude0 = latitude;
                    longitude0 = longitude;
                }
                
            }
	}

    
	// CREATE THE ANNOTATIONS AND ADD THEM TO THE MAP
	
	
	// create the start annotation and add it to the array
    
    [self addAnnotationWithLocation:[points objectAtIndex:0] withtime:[NSString stringWithFormat:@"Source (%@)",[date_Array objectAtIndex:0] ] type:0 recNo:0];
   
    [self addAnnotationWithLocation:[points objectAtIndex:points.count - 1] withtime:[NSString stringWithFormat:@"Destination (%@)",[date_Array objectAtIndex:points.count - 1]] type:1 recNo:0];
    
    
//	CSMapAnnotation*annotation1 = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:0] coordinate] annotationType:CSMapAnnotationTypeStart title:[NSString stringWithFormat:@"%@",[address_Array objectAtIndex:0] ] subtitle:[NSString stringWithFormat:@"Source (%@)",[date_Array objectAtIndex:0] ]] autorelease] ;
//	[_mapView addAnnotation:annotation1];
//    
//	// create the end annotation and add it to the array
//	CSMapAnnotation*annotation2 = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:points.count - 1] coordinate]
//											   annotationType:CSMapAnnotationTypeEnd
//														title:[NSString stringWithFormat:@"%@",[address_Array objectAtIndex:address_Array.count - 1]]  subtitle:[NSString stringWithFormat:@"Destination (%@)",[date_Array objectAtIndex:points.count - 1]] ] autorelease];
//	[_mapView addAnnotation:annotation2];
    
    



//    // create the image annotation
//	annotation2 = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:points.count / 2] coordinate]
//											   annotationType:CSMapAnnotationTypeImage
//														title:@"Cleveland Circle"] autorelease];
//	[annotation2 setUserData:@"cc.jpg"];
//	[annotation2 setUrl:[NSURL URLWithString:@"http://en.m.wikipedia.org/wiki/Cleveland_Circle"]];
//	
//	[_mapView addAnnotation:annotation2];

    
	_routeView = [[CSMapRouteLayerView alloc] initWithRoute:points mapView:_mapView];


    
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	// turn off the view of the route as the map is chaning regions. This prevents
	// the line from being displayed at an incorrect positoin on the map during the
	// transition.
	_routeView.hidden = YES;
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	// re-enable and re-poosition the route display.
	_routeView.hidden = NO;
	[_routeView setNeedsDisplay];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKAnnotationView* annotationView = nil;
	
	// determine the type of annotation, and produce the correct type of annotation view for it.
	CSMapAnnotation* csAnnotation = (CSMapAnnotation*)annotation;
	if(csAnnotation.annotationType == CSMapAnnotationTypeStart ||
	   csAnnotation.annotationType == CSMapAnnotationTypeEnd ||
	   csAnnotation.annotationType == CSMapAnnotationTypeImage)
	{
		NSString* identifier = @"Pin";
		MKPinAnnotationView* pin = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
		
		if(nil == pin)
		{
			pin = [[MKPinAnnotationView alloc] initWithAnnotation:csAnnotation reuseIdentifier:identifier];
		}
        if (csAnnotation.annotationType == CSMapAnnotationTypeImage) {
            pin.image = [UIImage imageNamed:@"pin3.png"];
        }
        else {
            [pin setPinColor:(csAnnotation.annotationType == CSMapAnnotationTypeEnd) ? MKPinAnnotationColorRed : MKPinAnnotationColorGreen];
        }
		
		annotationView = pin;
        [annotationView setEnabled:YES];
        [annotationView setCanShowCallout:YES];
	}
	else {
        MKPinAnnotationView *pinView;
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if (pinView == nil) pinView = [[MKPinAnnotationView alloc]
                                       initWithAnnotation:annotation reuseIdentifier:defaultPinID] ;
        
        pinView.image =[UIImage imageNamed:@"arrest.png"] ;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = NO;

	}
	
	return annotationView;
	
}
-(IBAction)onClickHome_Button:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)onClickShareMap_Button:(id)sender {

        
    UIActionSheet *actonSheet = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Social Network",@"Instagram", nil];
    [actonSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        UIImage *postImage = [self captureView:self.mapView];
        NSString *postText = @"Map";
        
        NSArray *activityItems = @[postText, postImage];
        
        UIActivityViewController *activityController =
        [[UIActivityViewController alloc]
         initWithActivityItems:activityItems applicationActivities:nil];
        
        [self presentViewController:activityController
                           animated:YES completion:^(void){
                               // [activityController release];
                           }];

        
    }
    else if(buttonIndex == 1){
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,     NSUserDomainMask, YES);
        NSString *savePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"Image.png"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:savePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
        }
        UIImage *postImage = [self captureView:self.mapView];
        [UIImageJPEGRepresentation(postImage, 1.0) writeToFile:savePath atomically:YES];
        
        NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
        
        if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
            //imageToUpload is a file path with .ig file extension
            UIDocumentInteractionController *documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
            documentInteractionController.UTI = @"com.instagram.exclusivegram";
            documentInteractionController.delegate = self;
            
            // documentInteractionController.annotation = [NSDictionary dictionaryWithObject:@"Insert Caption here" forKey:@"InstagramCaption"];
            [documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Instagram not found !" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
            [alert show];
            
        }
    }
}


- (UIImage *)captureView:(UIView *)view {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [view.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(IBAction)onClickTravelStats_Button:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    TravelStatsViewController *travelStatsViewController = [[TravelStatsViewController alloc] initWithNibName:@"TravelStatsViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:travelStatsViewController];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:navController animated:YES completion:nil];
    }
    else {
        if (!popOverController) {
            popOverController = [[UIPopoverController alloc] initWithContentViewController:navController];
            popOverController.popoverContentSize = CGSizeMake(320, 480);
            popOverController.delegate = self;
        }
        else{
            [popOverController setContentViewController:navController];
        }
        
        CGRect popoverRect;
        
        popoverRect.size.width = 0;
        popoverRect.origin.x  = btn.frame.origin.x+(btn.frame.size.width/2);
        popoverRect.origin.y  = btn.frame.origin.y;
        popoverRect.size.height = 0;
        [popOverController presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
    travelStatsViewController.runningStatus_Array = [[NSArray alloc]initWithArray:status_Array];
    travelStatsViewController.speed_Array = [[NSArray alloc]initWithArray:speed_Array];
    travelStatsViewController.distance_Array = [[NSArray alloc]initWithArray:address_Array];
    travelStatsViewController.trackingTime_Label.text = self.trackingtime;
    travelStatsViewController.date_Array = [[NSArray alloc]initWithArray:date_Array];
    

    
}
-(NSString *)addAnnotationWithLocation:(CLLocation*)location withtime:(NSString *)time type:(int)i recNo:(int)recNo
{
    CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];

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
            
            
            NSString * placeAddress = [NSString stringWithFormat:@"%@, %@, %@",street_str,city_str,state_str];
           
//            if(recNo){
//                placeAddress = [NSString stringWithFormat:@"%d, %@",recNo,placeAddress];
//                NSLog(@"%@",placeAddress);
//            }
            CSMapAnnotation*annotation;
           
            if (i == -1) {
                annotation = [[CSMapAnnotation alloc] initWithCoordinate:newLocation.coordinate annotationType:CSMapAnnotationTypeImage title:[NSString stringWithFormat:@"%@",placeAddress]  subtitle:time ];
            }
            else if(i == 0) {
                annotation = [[CSMapAnnotation alloc] initWithCoordinate:newLocation.coordinate annotationType:CSMapAnnotationTypeStart title:[NSString stringWithFormat:@"%@",placeAddress]  subtitle:time ];
            }
            else {
                annotation = [[CSMapAnnotation alloc] initWithCoordinate:newLocation.coordinate annotationType:CSMapAnnotationTypeEnd title:[NSString stringWithFormat:@"%@",placeAddress]  subtitle:time ];
            }
     
            [self.mapView addAnnotation:annotation];
            
            
        
        }
    }];
    
    
    
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
