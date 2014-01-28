
#import <Foundation/Foundation.h>
#import <Mapkit/Mapkit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>

@class eventsViewController,AppDelegate;

@interface LocationFinder : NSObject <CLLocationManagerDelegate> {
    
    BOOL isCall;
    
   AppDelegate *delegate;
    
    CLLocationManager *locationManager;
    CLGeocoder *geoCoder;
    
    UILabel *latLabel;
    UILabel *longLabel;
   
    eventsViewController *events;
    
    NSMutableDictionary *mainLocationdictionary;
    NSString *current_location;
}

@property (nonatomic,retain) CLLocationManager *locationManager;

-(void)updateCurrentLocation;    
-(void)stopUpdateLocation;

@end
