//
//  reviewEventdetail.h
//  THATSWINNING
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import <UIKit/UIKit.h>

extern int beta;
extern NSMutableArray *ELoc,*EPrice;
extern NSMutableArray *EId,*EDesc,*EDuration,*Etitle;

@interface reviewEventdetail : UIViewController
{
    NSMutableData* responseData;
    
    IBOutlet UIButton *delete_Button;
    IBOutlet UIButton *approve_disapporve_Button;
}
@property(nonatomic,retain)NSString *imageURl;
@property(nonatomic,retain)NSString *idstr;
@property(nonatomic,retain)NSString *status;
@property(nonatomic,retain)IBOutlet UITextView *description_TextView;
@property(nonatomic,retain)IBOutlet UILabel *title_Label;
@property(nonatomic,retain)IBOutlet UILabel *time_Label;
@property(nonatomic,retain)IBOutlet UILabel *date_Label;
@property(nonatomic,retain)IBOutlet UILabel *location_Label;
@property(nonatomic,retain)IBOutlet UILabel *category_Label;
@property(nonatomic,retain)IBOutlet UIImageView *imageView;
@property(nonatomic,retain)IBOutlet UILabel *reoccurring_Label;

-(IBAction)GettingServisec1;
-(IBAction)delete:(id)sender;
-(IBAction)onClickApprove_Button:(id)sender;
-(IBAction)onClickDelete_Button:(id)sender;

@end
