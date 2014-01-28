//
//  NightTrackingViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 13/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "PhoneContacts.h"

@interface NightTrackingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate,ABPeoplePickerNavigationControllerDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate> {
   
    IBOutlet UITableView *location_Table;
    NSMutableArray *location_Array;
    IBOutlet UIButton *tracking_Button;
        NSMutableArray *ConN,*pick;
        NSMutableArray *city;
    AppDelegate *delegate;
    UIPopoverController *popOverController;
    
}
@property(nonatomic,retain) CLLocationManager *locationManager1;
@property(nonatomic,retain) NSString *address;
-(IBAction)onClickTrackButton:(id)sender;
-(IBAction)onClickHome_Button:(id)sender;
-(IBAction)onClickSendMyLocation_Button:(id)sender;
-(void)checkTrackingStatus;
@end
