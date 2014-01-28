//
//  LinearInterpView.h
//  FreehandDrawingTut
//
//  Created by A Khan on 11/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinearInterpView : UIView
-(NSMutableArray*)pathPoint;
-(void)pathFromPoints:(NSMutableArray*)pointsArray withXEnhancement:(float)xMultiple withYEnhancement:(float)yMultiple ;
@property(nonatomic,retain)LinearInterpView *freshView;
-(void)removePathForNewView;
- (void)touchesBeganForNewViewAtPoint:(CGPoint)point;
- (void)touchesMovedForNewViewToPoint:(CGPoint)point;
- (void)touchesEndForNewView;
@end
