//
//  FindARideViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindARideViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate> {
    IBOutlet UITableView *tableView;
    NSMutableDictionary *rootDict;
    NSMutableArray *keyArray;
    IBOutlet UIButton *home_Button;

}
@property(nonatomic,retain) NSMutableArray *dataArray;
-(IBAction)onClickHome_Button:(id)sender;
-(IBAction)onClickCalculatorTip_Button:(id)sender;

@end
