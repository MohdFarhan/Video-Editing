//
//  UIImagePickerController+NonRotating.h
//  FrameIt Free
//
//  Created by Nadeem Akram on 25/03/13.
//  Copyright (c) 2013 Mia OY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (NonRotating)

- (BOOL)shouldAutorotate;
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;
@end
