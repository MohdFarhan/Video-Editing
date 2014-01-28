//
//  upload.h
//  THATSWINNING
//
//  Created by Guramrit on 24/02/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import <CoreGraphics/CoreGraphics.h>

extern NSString *strlocation;

@interface upload : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *selectDate,*SelectedhourArray;

    UIView *bottomview;
    IBOutlet UIButton *b1;
    NSMutableData* responseData;
    NSMutableArray *ar;
    NSMutableArray *option;
    NSString *strname;
    UIImage *image;
    NSMutableArray *puppy;
    IBOutlet UIImageView *uploadImageView;
    
    IBOutlet UIToolbar *tool;
    IBOutlet UITextView *desctxt;
    IBOutlet UITextField *locationTxt,*datetxt,*durationTxt,*titleTxt,*categaryTxt;
    IBOutlet UIDatePicker *datePicker,*timePicker;
    IBOutlet UIImageView *pp;
    IBOutlet UIPickerView *pick;
    IBOutlet UIScrollView *Scroll;
    BOOL Datepicker,pickervew;
    NSArray *categaryArray, *locationArray;
    int pickerIndex;
    UIPickerView *Picker1;
    UIPickerView *Picker2;
    IBOutlet UISwitch *reccuring_Swith;
    IBOutlet UILabel *reocurrngDay_Label;
    UIPopoverController *popOverController;
    NSString *whichControl;
}
-(IBAction)reoccurring_Switch:(id)sender;
-(IBAction)get2:(id)sender;
-(IBAction)upload:(id)sender;
-(IBAction)Done1;
-(IBAction)dateButtonClick:(id)sender;
-(IBAction)timeButtonClick:(id)sender;
-(IBAction)locationButtonClick:(id)sender;
-(IBAction)categoryButtonClick:(id)sender;
@end
