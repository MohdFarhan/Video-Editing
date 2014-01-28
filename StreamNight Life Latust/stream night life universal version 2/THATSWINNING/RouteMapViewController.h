//
//  MapViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 13/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>
#import "CSMapRouteLayerView.h"
#import "CSMapAnnotation.h"
#import "CSImageAnnotationView.h"


@interface RouteMapViewController : UIViewController<MKMapViewDelegate,UIActionSheetDelegate,UIDocumentInteractionControllerDelegate,UIPopoverControllerDelegate> {
    
    IBOutlet MKMapView* _mapView;
    NSMutableArray *lat_Array;
    NSMutableArray *lon_Array;
    NSMutableArray *address_Array;
    NSMutableArray *date_Array;
    NSMutableArray *status_Array;
    NSMutableArray *speed_Array;
    UIPopoverController *popOverController;
    int n;
}
@property (nonatomic, retain) CSMapRouteLayerView* routeView;
@property(nonatomic,retain) MKMapView *mapView;
@property(nonatomic,retain)NSString *trackingtime;

-(IBAction)onClickHome_Button:(id)sender;
-(IBAction)onClickShareMap_Button:(id)sender;
-(IBAction)onClickTravelStats_Button:(id)sender;


@end
