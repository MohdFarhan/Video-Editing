//
//  ShareGameViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface SharePlaceViewController : UIViewController <UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,UIPopoverControllerDelegate>{
    IBOutlet UILabel *title_Label;
    IBOutlet UITextView *description_TextView;
    IBOutlet UIImageView *imageView;
    IBOutlet UITextField *placeName_textField;
    IBOutlet UITextField *operationHour_textField;
    IBOutlet UITextField *address_textField;
    IBOutlet UITextField *location_textField;
    IBOutlet UITextField *Category_textField;
    IBOutlet UIScrollView *scrollView;
    NSArray *category_Array;
    NSArray *campusLocation_Array;
    UIPickerView *categoryPicker;
    UIDatePicker *fromDatePicker;
    UIDatePicker *toDatePicker;
    NSDateFormatter *dateFormat;
    AppDelegate *delegate;
}
@property(nonatomic,retain) UIPopoverController *popoverController;
@property(nonatomic,retain)NSString *titleString;
-(IBAction)onClickUploadImage_Button:(id)sender;
-(IBAction)onClickSharePlace_Button:(id)sender;

@end
