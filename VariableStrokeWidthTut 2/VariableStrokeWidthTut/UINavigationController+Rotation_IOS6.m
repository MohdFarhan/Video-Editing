//
//  UINavigationController+Rotation_IOS6.m
//  MyTravels
//
//  Created by Rahul kumar Jain on 01/01/13.
//  Copyright (c) 2013 Triffort Technologies. All rights reserved.
//

#import "UINavigationController+Rotation_IOS6.h"

@implementation UINavigationController (Rotation_IOS6)

-(BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{
    //return [self.topViewController supportedInterfaceOrientations];
    return [self.topViewController supportedInterfaceOrientations];
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
