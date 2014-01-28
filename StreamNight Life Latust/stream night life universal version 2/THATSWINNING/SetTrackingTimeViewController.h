//
//  SetTrackingTimeViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 13/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SetTrackingTimeViewController : UIViewController<UITextFieldDelegate> {
    IBOutlet UITextField *startTracking_TextField;
    IBOutlet UITextField *endTracking_TextField;
    IBOutlet UISwitch *tracking_Switch;
    IBOutlet UIDatePicker *date_Picker;
    UIActionSheet *actionSheet;
    AppDelegate *appDelegate;
    
}
-(IBAction)switchTracking:(id)sender;
@end
