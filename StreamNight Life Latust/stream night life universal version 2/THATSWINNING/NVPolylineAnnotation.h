
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface NVPolylineAnnotation : NSObject<MKAnnotation>
{
	NSMutableArray* _points; 
	MKMapView* _mapView;

}

-(id) initWithPoints:(NSArray*) points mapView:(MKMapView *)mapView;

@property (nonatomic, retain) NSArray* points;

@end
