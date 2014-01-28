//
//  EmergencyViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmergencyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UITableView *tableView;
    NSMutableArray *dataArray;
    NSMutableDictionary *rootDict;
    NSMutableDictionary * dataDict;
    NSMutableArray *keyArray;
    
    
}
@property(nonatomic,retain) NSMutableArray *dataArray;
-(IBAction)onClickHome_Button:(id)sender;

@end
