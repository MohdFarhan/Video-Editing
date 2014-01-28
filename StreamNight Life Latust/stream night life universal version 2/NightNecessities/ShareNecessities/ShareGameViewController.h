//
//  ShareGameViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareGameViewController : UIViewController <UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    IBOutlet UILabel *title_Label;
    IBOutlet UITextView *description_TextView;
    IBOutlet UIImageView *imageView;
    IBOutlet UITextField *gameName_textField;
    IBOutlet UITextField *Category_textField;
    IBOutlet UIScrollView *scrollView;
    NSArray *category_Array;
    UIPickerView *categoryPicker;

}
@property(nonatomic,retain)NSString *titleString;
-(IBAction)onClickUploadImage_Button:(id)sender;
-(IBAction)onClickShareGame_Button:(id)sender;

@end
