//
//  login_scr.h
//  THATSWINNING
//  Created by Mohit on 22/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import <UIKit/UIKit.h>
#import "JSON.h"

extern int busiId;

@interface login_scr : UIViewController<UITextFieldDelegate>
{
    NSMutableData* responseData;
    NSString *str;
    NSMutableArray *ar,*ar1;

    IBOutlet UILabel *lbl;
    IBOutlet UITextField *name,*pass;
    IBOutlet UIImageView *top;
    NSMutableArray *studentID;

}

-(NSMutableArray *) getArrayFromJSONDictionary:(NSDictionary *)parent
                                        forKey:(NSString *)key;
@property (retain,nonatomic) NSString *str;
@end
