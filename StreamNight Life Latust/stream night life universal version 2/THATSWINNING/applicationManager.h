//
//  applicationManager.h
//  THATSWINNING
//
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"

@interface applicationManager : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    int phase;
    
    IBOutlet UIImageView *campus;
    IBOutlet UIButton *campusbtn;
    
    NSMutableArray *arraycampus;
    UITableView *tableService;
    
    NSMutableData* responseData;
    UILabel *lbl;

    NSMutableArray *ar;
    UIView *bottomview;
    IBOutlet UIButton *b1,*b2,*b3;
    UITextField *text1;
    IBOutlet UILabel *locationLabel;
    IBOutlet UITableView *campus_TableView;

}

-(IBAction)moveToSettings:(id)sender;
-(IBAction)movetoSignOut:(id)sender;
-(IBAction)movetoHome:(id)sender;
-(IBAction)movetoreviewdeal:(id)sender;
-(IBAction)movetomanage:(id)sender;
-(IBAction)movetoreviewEvent:(id)sender;
-(IBAction)showcampus:(id)sender;

@end
