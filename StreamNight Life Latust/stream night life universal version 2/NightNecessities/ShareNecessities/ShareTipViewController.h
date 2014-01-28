//
//  ShareTipViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareTipViewController  : UIViewController <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>{
    IBOutlet UILabel *title_Label;
    IBOutlet UITextView *description_TextView;
    IBOutlet UITextField *tipName_textField;
    IBOutlet UITextField *Category_textField;
    IBOutlet UIScrollView *scrollView;
    NSArray *category_Array;
    UIPickerView *categoryPicker;
    IBOutlet UITextField *location_textField;
    NSArray *campusLocation_Array;
}
@property(nonatomic,retain)NSString *titleString;
-(IBAction)onClickShareTip_Button:(id)sender;

@end
