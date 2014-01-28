
#import "NVPolylineAnnotation.h"


@implementation NVPolylineAnnotation

@synthesize points = _points; 

-(id) initWithPoints:(NSArray*) points mapView:(MKMapView *)mapView
{
	self = [super init];	
	_points = [[NSArray alloc] initWithArray:points];
	_mapView = [mapView retain];
		
	return self;
}

-(CLLocationCoordinate2D) coordinate
{
	return [_mapView centerCoordinate];
}

-(void) dealloc
{	
	[super dealloc];
	[_mapView release];
	[_points release];
}

@end
