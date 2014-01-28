//
//  ViewTipViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTipViewController : UIViewController {
    
    
    
}
@property(nonatomic,retain)NSString *titleString;
@property(nonatomic,retain)IBOutlet UILabel *title_Label;
@property(nonatomic,retain)IBOutlet UILabel *Category_Label;
@property(nonatomic,retain)IBOutlet UITextView *description_TextView;
-(IBAction)onClickHome_Button:(id)sender;
-(IBAction)onClickReport_Button:(id)sender;
-(IBAction)onClickShareGame_Button:(id)sender;
@end
