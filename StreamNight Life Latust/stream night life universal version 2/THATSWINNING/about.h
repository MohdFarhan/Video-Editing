//
//  about.h
//  THATSWINNING
//
//  Created by Mohit on 04/02/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface about : UIViewController<UITextViewDelegate>
{
    IBOutlet UIWebView *webView;
}

-(IBAction)AddComp:(id)sender;
-(IBAction)onClickLinkButton:(id)sender;

@end
