//
//  checkViewController.h
//  Stream Night Life
//
//  Created by Farhan Khan on 1/16/14.
//  Copyright (c) 2014 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "JSON.h"

@interface checkViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableData* responseData;
    NSMutableArray *ar;
    IBOutlet UITextField *name,*pass;
    NSMutableArray *bid;
}

-(NSMutableArray *) getArrayFromJSONDictionary:(NSDictionary *)parent
                                        forKey:(NSString *)key;



@end
