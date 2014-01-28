//
//  Settings.h
//  THATSWINNING
//
//  Created by Guramrit on 23/02/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"

@interface Settings : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *text1,*text2;
    NSMutableData* responseData;
    NSMutableArray *ar,*ar1;;
    NSString *str;
    int phase;
}
@end
