//
//  ViewGameViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminGameViewController : UIViewController {
    
    IBOutlet UIButton *delete_Button;
    IBOutlet UIButton *report_Button;
    IBOutlet UIButton *approve_disapporve_Button;
    
    
}
@property(nonatomic,retain)NSString *game_id;
@property(nonatomic,retain)NSString *status;
@property(nonatomic,retain)IBOutlet UILabel *title_Label;
@property(nonatomic,retain)IBOutlet UIImageView *imageView;
@property(nonatomic,retain)IBOutlet UITextView *instruction_TextView;
@property(nonatomic,retain)IBOutlet UILabel *Category_Label;
@property(nonatomic,retain)NSString *titleString;
@property(nonatomic,retain)NSString *necessitiescategory;
@property(nonatomic,retain)NSString *urlString;


-(IBAction)onClickApprove_Button:(id)sender;
-(IBAction)onClickReport_Button:(id)sender;
-(IBAction)onClickDelete_Button:(id)sender;

@end

