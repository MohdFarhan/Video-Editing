//
//  UIWebView+WebCategory.m
//  Stream Night Life
//
//  Created by Farhan Khan on 12/16/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "UIWebView+WebCategory.h"

@implementation UIWebView (WebCategory)
-(void)removeShadows
{
    for(UIView *view in [self subviews] ) {
        if( [view isKindOfClass:[UIScrollView class]] ) {
            for( UIView *innerView in [view subviews] ) {
                if( [innerView isKindOfClass:[UIImageView class]] ) {
                    innerView.hidden = YES;
                }
            }
        }
    }
}
@end
