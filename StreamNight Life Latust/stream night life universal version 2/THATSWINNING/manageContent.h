//
//  manageContent.h
//  THATSWINNING
//
//  Created by Mohit on 22/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
int sim;
int pug;
NSMutableArray *userID,*userName;
NSMutableArray *userTable;
NSMutableArray *showBusiArray,*showBusiArray1,*showBusiArray2,*showbee3,*showbee4,*showbee5,*showbee6;
NSMutableArray *compArray;

@interface manageContent : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    int pup;
    IBOutlet UIImageView *bag,*bag1,*bag2;
    
    IBOutlet UITableView *tablenight,*tablenight1,*showBusiTable;
    UILabel *lbl;
    NSMutableArray *loc,*comp;
    UIButton *closeButton,*scrollbtn;
    NSMutableData* responseData;
    NSMutableArray *done;
    NSMutableArray *status;
}

-(IBAction)touch2:(id)sender;


@end
