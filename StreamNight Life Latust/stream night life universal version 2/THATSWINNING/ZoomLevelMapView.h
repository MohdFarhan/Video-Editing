//
//  ZoomLevelMapView.h
//  DealspotterApp
//
//  Created by Guramrit on 24/01/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <MapKit/MapKit.h>
@interface ZoomLevelMapView : NSObject
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate mapView:(MKMapView *)mapview
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
@end
