//
//  ViewPlaceViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewPlaceViewController : UIViewController <UIActionSheetDelegate,UIDocumentInteractionControllerDelegate>{

    
}
@property(nonatomic,retain)NSString *urlString;
@property(nonatomic,retain)IBOutlet UILabel *title_Label;
@property(nonatomic,retain)IBOutlet UIImageView *imageView;
@property(nonatomic,retain)IBOutlet UILabel *Category_Label;
@property(nonatomic,retain)IBOutlet UILabel *location_Label;
@property(nonatomic,retain)IBOutlet UITextView *description_TextView;
@property(nonatomic,retain)IBOutlet UILabel *open_Label;
@property(nonatomic,retain)NSString *titleString;
@property(nonatomic,retain)NSString *address;
@property(nonatomic,retain)NSString *necessitiescategory;
@property(nonatomic,retain)NSString *idstr;

-(IBAction)onClickHome_Button:(id)sender;
-(IBAction)onClickReport_Button:(id)sender;
-(IBAction)onClickSharePlace_Button:(id)sender;
-(IBAction)onClickDirection_Button:(id)sender;

@end


