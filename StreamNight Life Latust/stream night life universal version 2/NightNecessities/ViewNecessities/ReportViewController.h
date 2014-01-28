//
//  ReportViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 07/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain) IBOutlet UITableView *report_Table;
@property(nonatomic,retain) IBOutlet UILabel *title_Label;
@property(nonatomic,retain) IBOutlet UITextField *report_TestField;
@property(nonatomic,retain) NSMutableArray *report_Array;
@property(nonatomic,retain)NSString *necessitiescategory;
@property(nonatomic,retain)NSString *idstr;
@property BOOL adminFlag;
-(void)getReports:(id)sender;
-(void)postReport:(id)sender;
@end
