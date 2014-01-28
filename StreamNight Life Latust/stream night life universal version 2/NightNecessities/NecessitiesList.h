//
//  NecessitiesList.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NecessitiesList : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    UIView *bottomview;
    UIButton *b1,*b2;
    NSMutableArray *dataArray;
    IBOutlet UILabel *title_Label;
    IBOutlet UIButton *organize_Button;
    IBOutlet UILabel *organizeType_Label;
    IBOutlet UITableView *tableView;
    UITableView *organizeTable;
    NSArray *organizeArray;
    NSMutableArray *indexArray;

}
@property(nonatomic,retain)NSString *campusLocationString;
@property(nonatomic,retain) NSMutableArray *dataArray;
@property(nonatomic,retain)NSString *titleString;
@property(nonatomic,retain)NSArray *id_Array;
@property(nonatomic,retain)NSArray *sid_Array;
@property(nonatomic,retain)NSArray *title_Array;
@property(nonatomic,retain)NSArray *category_Array;
@property(nonatomic,retain)NSArray *description_Array;
@property(nonatomic,retain)NSArray *hour_operation_Array;
@property(nonatomic,retain)NSArray *address_Array;
@property(nonatomic,retain)NSArray *imageURL_Array;
@property(nonatomic,retain)NSArray *location_Array;

@end
