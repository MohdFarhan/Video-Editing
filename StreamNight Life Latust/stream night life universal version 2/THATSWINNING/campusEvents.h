//  campusEvents.h
//  THATSWINNING
//  Created by Mohit on 19/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "iAd/ADBannerView.h"

extern NSString *strlocation;
int todayCheck;
int eventIndex;




@interface campusEvents : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UIView *bottomview;
    UIButton *b1,*b2;
    IBOutlet UITableView *tableService;
    UILabel *lbl,*lbl1,*lbl2;
    UILabel *headerlbl;
    NSMutableArray *title;
    NSMutableData* responseData;
    UILabel *campusLocation_Label;
    
    IBOutlet UIView *iadView;
    

    IBOutlet UILabel *title_Label;
    
    
    NSMutableArray *eventLoc,*eventdate;
    NSMutableArray *eventId,*eventDesc,*eventduration,*eventTitle,*eventImageArray,*eventdayArray;
    
    NSMutableArray *today1,*tomm,*other,*mon;
    
    NSMutableArray *todayDesc,*todayTitle,*todayDuration,*todayImg,*todayDate,*todayLoc,*todayday;
    
    NSMutableArray *tommDesc,*tommTitle,*tommDuration,*tommImg,*tommDate,*tommLoc;
    
    NSMutableArray *monDesc,*monTitle,*monDuration,*monImg,*monDate,*monLoc;
    
    NSMutableArray *otherDesc,*otherTitle,*otherDuration,*otherImg,*otherDate,*otherLoc;
    

}




@property (nonatomic, retain) NSString *eventCategary;
-(IBAction)movetoupload:(id)sender;

@end
