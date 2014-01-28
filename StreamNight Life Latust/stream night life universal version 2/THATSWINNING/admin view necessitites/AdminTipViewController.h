//
//  AdminViewTipViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 03/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminTipViewController : UIViewController {
    IBOutlet UIButton *delete_Button;
    IBOutlet UIButton *report_Button;
    IBOutlet UIButton *approve_disapporve_Button;

}
@property(nonatomic,retain)NSString *tip_id;
@property(nonatomic,retain)NSString *status;
@property(nonatomic,retain)NSString *titleString;
@property(nonatomic,retain)IBOutlet UILabel *title_Label;
@property(nonatomic,retain)IBOutlet UILabel *Category_Label;
@property(nonatomic,retain)IBOutlet UITextView *description_TextView;
@property(nonatomic,retain)NSString *necessitiescategory;
@property(nonatomic,retain)IBOutlet UILabel *location_Label;

-(IBAction)onClickApprove_Button:(id)sender;
-(IBAction)onClickReport_Button:(id)sender;
-(IBAction)onClickDelete_Button:(id)sender;
@end
