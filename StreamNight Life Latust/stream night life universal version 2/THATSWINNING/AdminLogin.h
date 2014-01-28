//
//  AdminLogin.h
//  THATSWINNING
//
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"

@interface AdminLogin : UIViewController<UITextFieldDelegate>
{
    NSMutableData* responseData;
    NSMutableArray *ar;
    IBOutlet UITextField *name,*pass;
    NSMutableArray *bid;
}

-(NSMutableArray *) getArrayFromJSONDictionary:(NSDictionary *)parent
                                 forKey:(NSString *)key;

@end
