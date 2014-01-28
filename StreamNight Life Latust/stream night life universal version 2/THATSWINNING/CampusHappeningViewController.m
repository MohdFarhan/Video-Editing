//
//  CapusHappeningViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 20/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "CampusHappeningViewController.h"
#import "campusEvents.h"
#import "upload.h"
#import "JSON.h"


@interface CampusHappeningViewController ()<UIActionSheetDelegate>
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation CampusHappeningViewController
@synthesize carousel;
@synthesize wrap;
@synthesize items;

- (void)setUp
{
    //set up data
    wrap = YES;
    self.items = [[NSMutableArray array]init];
    for (int i = 0; i < 5; i++)
    {
        [self.items addObject:@(i)];
    }
    
}
-(void)dealloc
{
   [bottomview release];
    [campusLocation_Label release];
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUp];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL  isNotFirstTime = [defaults boolForKey:@"isCampusNotFirstTime"];
    if(!isNotFirstTime){
        [[NSUserDefaults standardUserDefaults]  setBool:YES forKey:@"isCampusNotFirstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alrtView=[[UIAlertView alloc]initWithTitle:@"Welcome!" message:@"Here are all the things going on around your campus! Each section will have relevant events! Down at the bottom there is an upload events tab which is for you to add anything you know is going on around campus! Share all you would like! " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrtView show];
        [alrtView release];
        
    }
    campusLocation_Label.text = [defaults objectForKey:@"CampusLocation"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {


    //--------------------------Bottom----------------------------------------------
    CGFloat sc1=[UIScreen mainScreen].bounds.size.height;
    if([UIScreen mainScreen].scale==2.0f && sc1==568.0f)
    {
        bottomview = [[UIView alloc] initWithFrame:CGRectMake(0,455,320,70)];
    }
    else
    {
        bottomview = [[UIView alloc] initWithFrame:CGRectMake(0,366,320,70)];
    }
    bottomview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomview];
    
    UIImageView *bottomimg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,50)];
    bottomimg.image = [UIImage imageNamed:@"bottom-nav.png"];
   // [bottomview addSubview:bottomimg];
    [bottomimg release];
    
    b2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
      [b2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(uploadEvent) forControlEvents:UIControlEventTouchUpInside];
        
    b2.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 300, 40)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:@"Upload Event or Deal"];
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.font=[UIFont boldSystemFontOfSize:20.0];
   
       
    [b2 setImage:[UIImage imageNamed:@"iphone.png"] forState:UIControlStateNormal];
    [b2 setTitle:@"Upload Event" forState:UIControlStateNormal];
        
  
    //b2.frame = CGRectMake(320/2-75,07,150,40);
    b2.frame = CGRectMake(0,0,320,50);
    [bottomview addSubview:b2];
        [bottomview addSubview:titleLabel];
         [titleLabel release];
    }
    else {
        
    }
   // [b2 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];

    
    // Do any additional setup after loading the view from its nib.
    
    carousel.backgroundColor=[UIColor clearColor];
    carousel.type = iCarouselTypeCoverFlow;
}

-(IBAction)uploadEvent {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        upload *uploadevent = [[upload alloc] initWithNibName:@"upload" bundle:nil];
        [self.navigationController pushViewController:uploadevent animated:YES];
        [uploadevent release];
    }
    else {
        upload *uploadevent = [[upload alloc] initWithNibName:@"upload_iPad" bundle:nil];
        [self.navigationController pushViewController:uploadevent animated:YES];
        [uploadevent release];
    }

    
//    CKViewController *ckViewController = [[CKViewController alloc] init] ;
//     [self.navigationController pushViewController:ckViewController animated:NO];
//    //[self.view addSubview:ckViewController.view];
}

-(void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(come) withObject:nil afterDelay:0.1];

}

-(void)come
{
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,58,30);
    button1.titleLabel.font= [UIFont boldSystemFontOfSize:14];
    [button1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed: @"back1.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
    [button1 release];
}

-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)goToEvent:(id)sender {
    
    campusEvents *dl1;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        dl1=[[campusEvents alloc]initWithNibName:@"campusEvents" bundle:nil];
    }
    else {
        dl1=[[campusEvents alloc]initWithNibName:@"campusEvents_iPad" bundle:nil];
    }
    if ([sender tag]== 1) {
        dl1.eventCategary = @"Sport Events";
    }
    else if([sender tag]== 2) {
        dl1.eventCategary = @"Entertainment";

    }
    else if([sender tag]== 3) {
        dl1.eventCategary = @"Community Events";

    }
    else if([sender tag]== 4) {
        dl1.eventCategary = @"Randoms";

    }

    [self.navigationController pushViewController:dl1 animated:YES];
    [dl1 release];
}
-(void)goToEventWithTage:(int)tag {
    
    campusEvents *dl1;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        dl1=[[campusEvents alloc]initWithNibName:@"campusEvents" bundle:nil];
    }
    else {
        dl1=[[campusEvents alloc]initWithNibName:@"campusEvents_iPad" bundle:nil];
    }
    if ( tag== 1) {
        dl1.eventCategary = @"Sport Events";
    }
    else if( tag== 2) {
        dl1.eventCategary = @"Deals And Specials";
        
    }
    else if( tag== 3) {
        dl1.eventCategary = @"Entertainment";
        
    }
    else if(tag== 4) {
        dl1.eventCategary = @"Community Events";
        
    }
    else if(tag== 5) {
        dl1.eventCategary = @"Randoms";
        
    }
    
    [self.navigationController pushViewController:dl1 animated:YES];
    [dl1 release];
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor grayColor];
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString length] != 6)
        return  [UIColor grayColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UIActionSheet methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0)
    {
        //map button index to carousel type
        iCarouselType type = buttonIndex;
        
        //carousel can smoothly animate between types
        [UIView beginAnimations:nil context:nil];
        carousel.type = type;
        [UIView commitAnimations];
        
        //update title
        // navItem.title = [actionSheet buttonTitleAtIndex:buttonIndex];
    }
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    NSLog(@"Count=%d",self.items.count);
    return [self.items count];
}
- (UIImage *) NewImage: (UIImage *) Image fillSize: (CGSize) viewsize

{
	UIGraphicsBeginImageContext(viewsize);
    
    [Image drawInRect:CGRectMake(0, 0, viewsize.width, viewsize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    UIImage *image ;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            switch (index) {
                case 0:
                    image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",6]];
                    break;
                case 1:
                    image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",7]];
                    break;
                case 2:
                    image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",8]];
                    break;
                case 3:
                    image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",9]];
                    break;
                    
                    
                default:
                    image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",10]];
                    break;
            }

             }
             else {
                 switch (index) {
                     case 0:
                         image =[UIImage imageNamed:[NSString stringWithFormat:@"iPad%d.png",6]];
                         break;
                     case 1:
                         image =[UIImage imageNamed:[NSString stringWithFormat:@"iPad%d.png",7]];
                         break;
                     case 2:
                         image =[UIImage imageNamed:[NSString stringWithFormat:@"iPad%d.png",8]];
                         break;
                     case 3:
                         image =[UIImage imageNamed:[NSString stringWithFormat:@"iPad%d.png",9]];
                         break;
                         
                         
                     default:
                         image =[UIImage imageNamed:[NSString stringWithFormat:@"iPad%d.png",10]];
                         break;
                 }
 
             }


//    //create new view if no view is available for recycling
//    if (view == nil)
//    {
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//            view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 210.0f, 280.0f)];
//        }
//        else {
//            view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 700.0f, 700.0f)];
//        }
//        
//        
//        
//        
//        //[view addSubview:label];
//      NSLog(@"%d no view",index+7);
//    }
//    else
//    {
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//            view.frame = CGRectMake(0, 0, 210.0f, 280.0f);
//        }
//        else {
//            view.frame = CGRectMake(0, 0, 700.0f, 700.0f);
//        }
//        //get a reference to the label in the recycled view
//        label = (UILabel *)[view viewWithTag:1];
//        // NSLog(@"%d no view",index+7);
//    }
//   
//
//   
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//         ((UIImageView *)view).image = [self NewImage:image fillSize:view.frame.size];
//    }
//    else {
//          ((UIImageView *)view).image = [self NewImage:image fillSize:CGSizeMake(600,700)];
//    }
//  
//    view.contentMode = UIViewContentModeCenter;
//    label = [[UILabel alloc] initWithFrame:view.bounds];
//    label.backgroundColor = [UIColor clearColor];
//    label.textAlignment = UITextAlignmentCenter;
//    label.font = [label.font fontWithSize:50];
//    label.tag = 1;
//    //set item label
//    //remember to always set any properties of your carousel item
//    //views outside of the `if (view == nil) {...}` check otherwise
//    //you'll get weird issues with carousel item content appearing
//    //in the wrong place in the carousel
//    label.text = [items[index] stringValue];
//    //create new view if no view is available for recycling
    
    if (view == nil)
    {
        
        
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 210.0f, 280.0f)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            imageView.frame = CGRectMake(0, 0, 210.0f, 280.0f);
        }
        else {
            imageView.frame = CGRectMake(0, 0, 700.0f,700.0f);
        }
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.5f;
        imageView.reflectionAlpha = 0.25f;
        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 1.0f);
        imageView.shadowBlur = 5.0f;
        imageView.cornerRadius = 25.0f;
        
        view = imageView;
        
        
        
        //[view addSubview:label];
        //  NSLog(@"%d view",index+1);
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            view.frame = CGRectMake(0, 0, 210.0f, 280.0f);
        }
        else {
            view.frame = CGRectMake(0, 0, 700.0f,700);
        }
        
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        UIImage *image1 =  [image resizedImage:CGSizeMake(210,250) interpolationQuality:kCGInterpolationHigh];
        [(FXImageView*)view setImage:image1];
       
        
    }
    else {
        UIImage *image1 =  [image resizedImage:CGSizeMake(600,700) interpolationQuality:kCGInterpolationHigh];
        
        [(FXImageView*)view setImage:image1];

        
        
    }

    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180.0f, 200.0f)];
        }
        else {
            view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 600.0f, 600.0f)];
        }
        
        
        
        
        //[view addSubview:label];
          NSLog(@"%d view",index+7);
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            view.frame = CGRectMake(0, 0, 180,200);
        }
        else {
            view.frame = CGRectMake(0, 0, 600.0f, 600.0f);
        }
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
        //  NSLog(@"%d no view",index+1);
    }
      UIImage *image ;
    switch (index) {
        case 0:
            image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",7]];
            break;
        case 1:
            image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",8]];
            break;
        case 2:
            image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",9]];
            break;
        case 3:
            image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",10]];
            break;

     
        default:
             image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",11]];
            break;
    }
    ((UIImageView *)view).image = [self NewImage:image fillSize:view.frame.size];
    view.contentMode = UIViewContentModeCenter;
    label = [[UILabel alloc] initWithFrame:view.bounds];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [label.font fontWithSize:50];
    label.tag = 1;
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [items[index] stringValue];

    
    return view;
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 16.0f, 0.0f, 0.0f, 1.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}
- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel{
}
- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            //return wrap;
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
           
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                return value * 1.35f;
            }
            else {
               return value * 0.86f;
            }
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (self.items)[index];
    
    switch (index) {
        case 0:
            [self goToEventWithTage:1];
            break;
        case 1:
             [self goToEventWithTage:2];
            break;
        case 2:
             [self goToEventWithTage:3];
            break;
        case 3:
             [self goToEventWithTage:4];
            break;
        case 4:
            [self goToEventWithTage:5];
            break;
        default:
            break;
    }
    
       NSLog(@"Tapped view number: %@", item);
}

@end
