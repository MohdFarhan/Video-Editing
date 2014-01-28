//
//  normalAccount.h
//  THATSWINNING
//
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
NSMutableArray *studentID;

@interface normalAccount : UIViewController<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>
{
    NSMutableData* responseData;
    NSMutableArray *ar;
    IBOutlet UITextField *name,*school,*username,*password;
    UIView *bottomview;
    IBOutlet UIButton *campusbtn;
    IBOutlet UITableView *campus_TableView;
UITableView *tableService;
      NSMutableArray *arraycampus;
    IBOutlet UIImageView *campus,*btnImageView;

}

-(NSMutableArray *) getArrayFromJSONDictionary:(NSDictionary *)parent
                                        forKey:(NSString *)key;

-(IBAction)showcampus:(id)sender;

@end
