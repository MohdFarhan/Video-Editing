//
//  NightNecessitiesApprovalControllerViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 20/05/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NightNecessitiesApprovalControllerViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITableView *tipTable;
@property(nonatomic,retain) IBOutlet UITableView *gameTable;
@property(nonatomic,retain) IBOutlet UITableView *placeTable;

@property(nonatomic,retain)NSArray *tid_Array;
@property(nonatomic,retain)NSArray *tsid_Array;
@property(nonatomic,retain)NSArray *ttitle_Array;
@property(nonatomic,retain)NSArray *tcategory_Array;
@property(nonatomic,retain)NSArray *tdescription_Array;
@property(nonatomic,retain)NSArray *tstatus_Array;
@property(nonatomic,retain)NSArray *tlocation_Array;



@property(nonatomic,retain)NSArray *gid_Array;
@property(nonatomic,retain)NSArray *gsid_Array;
@property(nonatomic,retain)NSArray *gtitle_Array;
@property(nonatomic,retain)NSArray *gcategory_Array;
@property(nonatomic,retain)NSArray *gdescription_Array;
@property(nonatomic,retain)NSArray *gimageURL_Array;
@property(nonatomic,retain)NSArray *gstatus_Array;


@property(nonatomic,retain)NSArray *pid_Array;
@property(nonatomic,retain)NSArray *psid_Array;
@property(nonatomic,retain)NSArray *ptitle_Array;
@property(nonatomic,retain)NSArray *pcategory_Array;
@property(nonatomic,retain)NSArray *pdescription_Array;
@property(nonatomic,retain)NSArray *pimageURL_Array;
@property(nonatomic,retain)NSArray *phour_operation_Array;
@property(nonatomic,retain)NSArray *paddress_Array;
@property(nonatomic,retain)NSArray *pstatus_Array;
@property(nonatomic,retain)NSArray *plocation_Array;
@end
