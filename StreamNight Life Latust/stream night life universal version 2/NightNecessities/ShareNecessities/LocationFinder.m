
#import "LocationFinder.h"
#import <AddressBook/AddressBook.h>
#import "AppDelegate.h"

@implementation LocationFinder
@synthesize locationManager;

-(void)updateCurrentLocation{
    
    isCall =FALSE;

    latLabel = [[UILabel alloc]init];
    longLabel = [[UILabel alloc]init];

    self.locationManager = [[CLLocationManager alloc] init];   
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 10 m
    [self.locationManager startUpdatingLocation];
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //delegate.currentLocation_label.text = @"Street_City_State_Country";
   
     geoCoder = [[CLGeocoder alloc] init];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    latLabel.text = [NSString stringWithFormat:@"%g",newLocation.coordinate.latitude];
    longLabel.text = [NSString stringWithFormat:@"%g",newLocation.coordinate.longitude];
  
    if (delegate.isCurrentLocation==1) {
        delegate.latitude_label.text = [NSString stringWithFormat:@"%g",newLocation.coordinate.latitude];
        delegate.longitude_label.text =[NSString stringWithFormat:@"%g",newLocation.coordinate.longitude];
        
        delegate.dropOff_lati.text = [NSString stringWithFormat:@"%g",newLocation.coordinate.latitude];
        delegate.dropOff_longi.text =[NSString stringWithFormat:@"%g",newLocation.coordinate.longitude];
    }
    [delegate showMap];
    delegate.currentLocation_label.text = [delegate getAddressFromLatLon:newLocation.coordinate.latitude withLongitude:newLocation.coordinate.longitude];
    
//    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//            for (CLPlacemark * placemark in placemarks) {
//                
//                NSString *street_str = @"";
//            
//                if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStreetKey]] isEqualToString:@"(null)"]) {
//            
//                    street_str = @"Street";
//                }
//                else{
//                    
//                    street_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStreetKey]];
//                }
//                
//                NSString *city_str = @"";
//                
//                if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCityKey]] isEqualToString:@"(null)"]) {
//                    
//                    city_str = @"City";
//                }
//                else{
//                    
//                    city_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCityKey]];
//                }
//
//                NSString *state_str = @"";
//                
//                if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStateKey]] isEqualToString:@"(null)"]) {
//                    
//                    state_str = @"State";
//                }
//                else{
//                    
//                    state_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStateKey]];
//                }
//                
//                NSString *country_str = @"";
//                
//                if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCountryKey]] isEqualToString:@"(null)"]) {
//                    
//                    country_str = @"Country";
//                }
//                else{
//                    country_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCountryKey]];
//                }
//                
//                NSString *Zip_str = @"";
//                
//                if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressZIPKey]] isEqualToString:@"(null)"]) {
//                    
//                    Zip_str = @"Zip";
//                }
//                else{
//                    
//                    Zip_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressZIPKey]];
//                }
//
//            NSString *currentLocation_str = [NSString stringWithFormat:@"%@_%@_%@_%@_%@",street_str,city_str,state_str,country_str,Zip_str];
//            delegate.currentLocation_label.text = currentLocation_str;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCurrentLocation" object:nil];
//        }   
//    }];
//   
//    
//    if ([delegate.currentLocation_label.text isEqualToString:@"(null)"]) {
//     delegate.currentLocation_label.text = @"Street_City_State_Country_Zip";
//    }
// 
//     NSLog(@"%@", delegate.currentLocation_label.text);
    
}

-(void)stopUpdateLocation{
    
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate=nil;
}

- (void) locationManager: (CLLocationManager *) manager didFailWithError : (NSError *) error{
    
    NSString *msg = @"Error obtaining location";
    delegate.currentLocation_label.text = @"Street_City_State_Country_Zip";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
    [alert show];
    
}

@end
