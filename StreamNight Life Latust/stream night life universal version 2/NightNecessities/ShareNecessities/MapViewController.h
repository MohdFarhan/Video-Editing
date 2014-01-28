//
//  MapViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 30/05/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate>
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) IBOutlet UIImageView *pinView;
@property(nonatomic,retain) IBOutlet UIView *textFieldView;
@property(nonatomic,retain)CLLocation *location;
@property(nonatomic,retain) NSString *placetitle;

@end
