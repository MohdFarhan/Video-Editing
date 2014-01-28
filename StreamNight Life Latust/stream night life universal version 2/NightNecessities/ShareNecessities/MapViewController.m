//
//  MapViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 30/05/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"
@interface MapViewController ()

@end

@implementation MapViewController
MKCoordinateRegion region;

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

    self.mapView.showsUserLocation = YES;
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    if (self.location) {
        [self.pinView removeFromSuperview];
        MKPointAnnotation *ann = [[MKPointAnnotation alloc] init]  ;
        region.center.latitude =  self.location.coordinate.latitude ;
        region.center.longitude = self.location.coordinate.longitude ;
        ann.coordinate = region.center ;
        ann.title =  self.placetitle;
        
        [self.mapView addAnnotation:ann];
        [self.mapView setCenterCoordinate:region.center];
        self.textFieldView.hidden = YES;
        
    }

}
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation: (id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *pinView ;
    if(annotation != self.mapView.userLocation) {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if (pinView == nil) pinView = [[MKPinAnnotationView alloc]
                                       initWithAnnotation:annotation reuseIdentifier:defaultPinID] ;
        pinView.pinColor =MKPinAnnotationColorRed ;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [btn addTarget:self action:@selector(onClickButton) forControlEvents:UIControlEventTouchUpInside];
        pinView.rightCalloutAccessoryView = btn;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = NO;
    }
    else {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if (pinView == nil) pinView = [[MKPinAnnotationView alloc]
                                       initWithAnnotation:annotation reuseIdentifier:defaultPinID] ;
        pinView.pinColor =MKPinAnnotationColorGreen ;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = NO;
    }

    return pinView;
}

-(void)onClickButton{
    CLLocationCoordinate2D endingCoord = CLLocationCoordinate2DMake(self.location.coordinate.latitude, self.location.coordinate.longitude);
    MKPlacemark *endLocation = [[MKPlacemark alloc] initWithCoordinate:endingCoord addressDictionary:nil];
    MKMapItem *endingItem = [[MKMapItem alloc] initWithPlacemark:endLocation];
    
    NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];
    [launchOptions setObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
    
    [endingItem openInMapsWithLaunchOptions:launchOptions];
}
//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
//    UIApplication *app = [UIApplication sharedApplication];
//    NSString *str = [NSString stringWithFormat:@"http://maps.google.com/maps?ll=%f,%f",self.location.coordinate.latitude,self.location.coordinate.longitude];
//    [app openURL:[NSURL URLWithString:str]];
//}

-(void)done {
    
    if (!self.location) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.coordinate = self.mapView.centerCoordinate;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MapNotification" object:nil];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
      
}
-(void)mapView:(MKMapView *)mapView1 didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (!self.location) {
        [self.mapView setCenterCoordinate:userLocation.coordinate];
        CGRect rect = self.pinView.frame;
        rect.origin.x = self.mapView.center.x-rect.size.width/2;
        rect.origin.y = self.mapView.center.y-rect.size.height;
        self.pinView.frame = rect;
    }



}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text length]> 0) {
        CLLocationCoordinate2D center = [self geoCodeUsingAddress:textField.text];
        [self.mapView setCenterCoordinate:center animated:YES];
    }
    [textField resignFirstResponder];
    return YES;
}

- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
