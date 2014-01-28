

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "NVPolylineAnnotation.h"


@interface NVPolylineAnnotationView : MKAnnotationView
{
	MKMapView * _mapView;
	UIView * _internalView;
}

@property (nonatomic) CGPoint centerOffset;

- (id)initWithAnnotation:(NVPolylineAnnotation *)annotation
				 mapView:(MKMapView *)mapView;

@end
