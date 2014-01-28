//
//  TravelStatsViewController.h
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 21/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TravelStatsViewController : UIViewController {
    double minspeed;
    double maxspeed;
    float avgspeed;
    int noofstopage;
    
}
@property(nonatomic,retain) NSArray *speed_Array;
@property(nonatomic,retain) NSArray *distance_Array;
@property(nonatomic,retain) NSArray *date_Array;
@property(nonatomic,retain) NSArray *runningStatus_Array;
@property(nonatomic,retain)IBOutlet UILabel *maxSpeed_Label;
@property(nonatomic,retain)IBOutlet UILabel *minSpeed_Label;
@property(nonatomic,retain)IBOutlet UILabel *avgSpeed_Label;
@property(nonatomic,retain)IBOutlet UILabel *noofStopage_Label;
@property(nonatomic,retain)IBOutlet UILabel *trackingTime_Label;




@end
