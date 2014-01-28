
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

//#import "RegexKitLite.h"

@interface MapDirection : UIView<MKMapViewDelegate>
{
    MKMapView* mapView;
    NSArray* routes;
    BOOL isUpdatingRoutes;
}

-(void) showRouteFrom: (CLLocation *) f to:(CLLocation *) t;

@end