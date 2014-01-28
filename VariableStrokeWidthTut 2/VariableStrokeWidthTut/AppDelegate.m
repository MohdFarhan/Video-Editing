//
//  AppDelegate.m
//  VariableStrokeWidthTut
//
//  Created by A Khan on 14/03/2013.
//  Copyright (c) 2013 AK. All rights reserved.
//

#import "AppDelegate.h"
#import "LinearInterpView.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//   self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//   self.window.backgroundColor = [UIColor whiteColor];
//   UIViewController *vc = [[UIViewController alloc] init];
//   self.window.rootViewController = vc;
//    vc.view = [[videoPlayerView alloc] initWithFrame:self.window.bounds];
//    vc.view.frame = self.window.bounds;
//    vc.view.backgroundColor = [UIColor clearColor];
//    UIView *drawingView=[[FinalAlgView alloc]initWithFrame:vc.view.frame];
//    drawingView.backgroundColor=[UIColor clearColor];
//    [vc.view addSubview:drawingView];
//    [self.window makeKeyAndVisible];
    
//   vc.view = [[FinalAlgView alloc] initWithFrame:self.window.bounds];
//   vc.view.frame = self.window.bounds;
//   vc.view.backgroundColor = [UIColor whiteColor];
//   [self.window makeKeyAndVisible];

    
    
    
 self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 //Override point for customization after application launch.
self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
self.window.rootViewController = self.viewController;
[self.window makeKeyAndVisible];
    return YES;
}

@end