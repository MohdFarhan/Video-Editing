//
//  AddComplaintViewController.h
//  THATSWINNING
//
//  Created by Guramrit on 02/03/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"

@interface AddComplaintViewController : UIViewController<UITextViewDelegate>
{
    IBOutlet UITextView *txt;
    NSMutableArray *ar;
    IBOutlet UIImageView *Img;
    IBOutlet UIButton *AddBut;
}

-(IBAction)AddComp:(id)sender;

@end
