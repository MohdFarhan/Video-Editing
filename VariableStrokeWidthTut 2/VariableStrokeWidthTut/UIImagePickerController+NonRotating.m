//
//  UIImagePickerController+NonRotating.m
//  FrameIt Free
//
//  Created by Nadeem Akram on 25/03/13.
//  Copyright (c) 2013 Mia OY. All rights reserved.
//

#import "UIImagePickerController+NonRotating.h"

@implementation UIImagePickerController (NonRotating)

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;

}
@end
