#import "LinearInterpView.h"

@implementation LinearInterpView
{
    UIBezierPath *path; // (3)
}
@synthesize freshView;
- (id)initWithCoder:(NSCoder *)aDecoder // (1)
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO]; // (2)
        //[self setBackgroundColor:[UIColor whiteColor]];
        path = [UIBezierPath bezierPath];
        [path setLineWidth:2.0];
        [self performSelector:@selector(setupVideoPlayer) withObject:nil afterDelay:0.1];
    }
    return self;
}
- (void)setupVideoPlayer {
    
       UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget : self action : @selector (handleSingleTap:)];
    [singleTap setNumberOfTapsRequired:2];
      [self addGestureRecognizer : singleTap];
    
  
    
}
-(void)removePathForNewView{
    
    [path removeAllPoints];
}
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    [path removeAllPoints];
    [self.freshView removePathForNewView];

}

- (void)drawRect:(CGRect)rect // (4)
{
    [[UIColor blackColor] setStroke];
    [path stroke];
}
- (void)touchesBeganForNewViewAtPoint:(CGPoint)point
{
    [path moveToPoint:point];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [path moveToPoint:p];
    float xMultiple=self.freshView.frame.size.width/self.frame.size.width,yMultiple=self.freshView.frame.size.height/self.frame.size.height;
    CGPoint newPoint=CGPointMake(p.x*xMultiple, p.y*yMultiple);
    [self.freshView touchesBeganForNewViewAtPoint:newPoint];
}
- (void)touchesMovedForNewViewToPoint:(CGPoint)point{
    [path addLineToPoint:point]; // (4)
   // [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [path addLineToPoint:p]; // (4)
   [self setNeedsDisplay];
    float xMultiple=self.freshView.frame.size.width/self.frame.size.width,yMultiple=self.freshView.frame.size.height/self.frame.size.height;
    CGPoint newPoint=CGPointMake(p.x*xMultiple, p.y*yMultiple);
    [self.freshView touchesMovedForNewViewToPoint:newPoint];
    
}
- (void)touchesEndForNewView{
  [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
   
    [self.freshView touchesEndForNewView ];
        
    
   // NSLog(@"%@",bezierPathPoints);


}
void MyCGPathApplierFunc (void *info, const CGPathElement *element) {
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    
    switch(type) {
        case kCGPathElementMoveToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddLineToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            break;
            
        case kCGPathElementAddCurveToPoint: // contains 3 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
            break;
            
        case kCGPathElementCloseSubpath: // contains no point
            break;
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
-(NSMutableArray*)pathPoint{
    CGPathRef  yourCGPath = path.CGPath;
    NSMutableArray *bezierPathPoints = [NSMutableArray array];
    
    CGPathApply(yourCGPath, (__bridge void *)(bezierPathPoints), MyCGPathApplierFunc);
    return bezierPathPoints;
}
-(void)pathFromPoints:(NSMutableArray*)pointsArray withXEnhancement:(float)xMultiple withYEnhancement:(float)yMultiple{
    [path removeAllPoints];

    for(NSValue *point in pointsArray){
       
        CGPoint point1=[point CGPointValue];
        point1.x*=xMultiple;
        point1.y*=yMultiple;
        
    }
}
-(void)drawPathForNewView{
    
}
@end
