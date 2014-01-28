//
//  reviewEvents.h
//  THATSWINNING
//
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"

int beta;
NSMutableArray *ELoc,*EPrice;
NSMutableArray *EId,*EDesc,*EDuration,*Etitle;
extern NSString *strlocation;

@interface reviewEvents : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tablenight;
    UILabel *lbl;
    NSMutableArray *loc;
    IBOutlet UIImageView *bag;
    NSMutableData* responseData;
    NSMutableArray *status_Array;
    NSMutableArray *imageURL_Array;
    NSMutableArray *phyLocation_Array;
    NSMutableArray *date_Array;
    NSMutableArray *time_Array;
    NSMutableArray *description_Array;
    NSMutableArray *locationArray;
    NSMutableArray* category_Array;
    NSMutableArray *id_Array;
    NSMutableArray *title_Array;
    NSMutableArray *day_Array;


}
@end
