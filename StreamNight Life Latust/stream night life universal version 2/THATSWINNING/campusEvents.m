//  campusEvents.m
//  THATSWINNING
//  Created by Mohit on 19/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "campusEvents.h"
#import "ViewController.h"
#import "showEvent.h"
#import "upload.h"
#import "iAd/iAd.h"

@interface campusEvents () <ADBannerViewDelegate>
@property(nonatomic,retain) ADBannerView *adBannerView;
@property BOOL currentOrientation;

@end

@implementation campusEvents
static  NSDateFormatter *dateFormat;



//- (int)getBannerHeight:(UIDeviceOrientation)orientation {
//    if (UIInterfaceOrientationIsLandscape(orientation)) {
//        return 32;
//    } else {
//        return 50;
//    }
//}
//
//- (int)getBannerHeight {
//    return [self getBannerHeight:[UIDevice currentDevice].orientation];
//}
//
//- (void)createAdBannerView { 
//    Class classAdBannerView = NSClassFromString(@"ADBannerView");
//    if (classAdBannerView != nil) {
//        self.adBannerView = [[[classAdBannerView alloc] initWithFrame:CGRectZero] autorelease];
//        [_adBannerView setRequiredContentSizeIdentifiers:[NSSet setWithObjects: ADBannerContentSizeIdentifier320x50, ADBannerContentSizeIdentifier480x32, nil]];
//        if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
//            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifier480x32];
//        } else {
//            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifier320x50];
//        }
//        [_adBannerView setFrame:CGRectOffset([_adBannerView frame], 0, -[self getBannerHeight])];
//        [_adBannerView setDelegate:self];
//        
//        [iadView addSubview:_adBannerView];
//    }
//}
//
//- (void)fixupAdView:(UIInterfaceOrientation)toInterfaceOrientation {
//    if (_adBannerView != nil) {
//        if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
//            [_adBannerView setRequiredContentSizeIdentifiers:ADBannerContentSizeIdentifierLandscape];
//        } else {
//            [_adBannerView setRequiredContentSizeIdentifiers:ADBannerContentSizeIdentifierPortrait];
//        }
//        [UIView beginAnimations:@"fixupViews" context:nil];
//        if (_adBannerViewIsVisible) {
//            CGRect adBannerViewFrame = [_adBannerView frame];
//            adBannerViewFrame.origin.x = 0;
//            adBannerViewFrame.origin.y = self.view.frame.size.height- 50;
//            [_adBannerView setFrame:adBannerViewFrame];
//            CGRect contentViewFrame = _contentView.frame;
//            contentViewFrame.origin.y = [self getBannerHeight:toInterfaceOrientation];
//            contentViewFrame.size.height = self.view.frame.size.height - [self getBannerHeight:toInterfaceOrientation];
//            _contentView.frame = contentViewFrame;
//        } else {
//            CGRect adBannerViewFrame = [_adBannerView frame];
//            adBannerViewFrame.origin.x = 0;
//            adBannerViewFrame.origin.y = -[self getBannerHeight:toInterfaceOrientation];
//            [_adBannerView setFrame:adBannerViewFrame];
//            CGRect contentViewFrame = _contentView.frame;
//            contentViewFrame.origin.y = 0;
//            contentViewFrame.size.height = self.view.frame.size.height;
//            _contentView.frame = contentViewFrame;
//        }
//        [UIView commitAnimations];
//    }
//}
//
//- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
//    if (!_adBannerViewIsVisible) {
//        _adBannerViewIsVisible = YES;
//        [self fixupAdView:[UIDevice currentDevice].orientation];
//    }
//}
//
//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    if (_adBannerViewIsVisible)
//    {
//        _adBannerViewIsVisible = NO;
//        [self fixupAdView:[UIDevice currentDevice].orientation];
//    }
//}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    CGRect bannerFrame = CGRectZero;
    CGSize iPadBasic = CGSizeMake(0.0, 66.0);
    CGSize iPhoneBasic = CGSizeMake(0.0, 32.0);
    CGSize deviceSize = self.view.bounds.size;
    
    if([self currentDevice]) { // iPad
//        if (_currentOrientation == 0) {
//            bannerFrame = CGRectMake(0.0, deviceSize.width - iPadBasic.height, deviceSize.height , deviceSize.width);
//        } else {
            bannerFrame = CGRectMake(0.0, deviceSize.height - iPadBasic.height, deviceSize.width, iPadBasic.height);
//        }
    } else { // iPhone
//        if (_currentOrientation) { // iphone portrait
//            bannerFrame = CGRectMake(0.0, self.view.frame.size.height - 50, 0.0, 0.0);
//        } else {
            bannerFrame = CGRectMake(0.0, self.view.frame.size.height - iPhoneBasic.height- 17, self.view.bounds.size.width, iPhoneBasic.height);
//        }
    }
    [_adBannerView setFrame:bannerFrame];
    _adBannerView.hidden = NO;
    
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    _adBannerView.hidden = YES;
}

-(void)currentOrientation:(NSNotification *)notification {
    if ([[notification object] orientation] != 3 && [[notification object] orientation] != 4 && [[notification object] orientation] != 5 && [[notification object] orientation] != 6) {
        _currentOrientation = 1; // Portrait mode
    } else if ([[notification object] orientation] != 5 && [[notification object] orientation] != 6) {
        _currentOrientation = 0; // landscape mode
    }
}

-(BOOL)currentDevice {
    if ([[UIDevice currentDevice] userInterfaceIdiom]) {
        return 1; // iPad device
    } else {
        return 0; // iPhone device
    }
}
-(void)dealloc
{
    [tableService release];

    [headerlbl release];

    [title release];
    [today1 release];
    [tomm release];
    [other release];
    [mon release];
    
     [todayDesc release];
     [todayTitle release];
     [todayDuration release];
     [todayImg release];
     [todayDate release];
     [todayLoc release];
     [todayday release];
    [tommDesc release];
     [tommTitle release];
    [tommDuration release];
    [tommImg release];
    [tommDate release];
    [tommLoc release];
    [monDesc release];
    [monTitle release];
    [monDuration release];
    [monImg release];
    [monDate release];
    [monLoc release];
    [otherDesc release];
    [otherTitle release];
    [otherDuration release];
    [otherImg release];
    [otherDate release];
    [otherLoc release];
    
    [eventLoc release];
    [eventdate release];
    
    [eventId release];
    [eventDesc release];
    [eventduration release];
    [eventTitle release];
    [eventImageArray release];
    [eventdayArray release];
    [super dealloc];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
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

-(void)GettingServisec
{
    [eventId removeAllObjects];
    [eventDesc removeAllObjects];
    [eventLoc removeAllObjects];
    [eventdate removeAllObjects];
    [eventduration removeAllObjects];
    [eventTitle removeAllObjects];
    [eventImageArray removeAllObjects];
    
    [today1 removeAllObjects];
    [todayDesc removeAllObjects];
    [todayTitle removeAllObjects];
    [todayDuration removeAllObjects];
    [todayImg removeAllObjects];
    [todayDate removeAllObjects];
    
    [tomm removeAllObjects];
    [tommDesc removeAllObjects];
    [tommTitle removeAllObjects];
    [tommDuration removeAllObjects];
    [tommImg removeAllObjects];
    [tommDate removeAllObjects];
    
    [mon removeAllObjects];
    [monDesc removeAllObjects];
    [monTitle removeAllObjects];
    [monDuration removeAllObjects];
    [monImg removeAllObjects];
    [monDate removeAllObjects];
    
    [other removeAllObjects];
    [otherDesc removeAllObjects];
    [otherTitle removeAllObjects];
    [otherDuration removeAllObjects];
    [otherImg removeAllObjects];
    [otherDate removeAllObjects];
    
    NSString *strloc = [strlocation stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *cat = [title_Label.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=ViewApprovedEvents&loc=%@&category=%@",strloc,cat];
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
    
	
    NSArray *ar2 =[self getArrayFromJSONDictionary:recievedData forKey:@"Description"];
    NSArray *Serviceid = [self getArrayFromJSONDictionary:recievedData forKey:@"ID"];
    NSArray *ar1 =[self getArrayFromJSONDictionary:recievedData forKey:@"Location"];
    NSArray *Serviceid1 = [self getArrayFromJSONDictionary:recievedData forKey:@"Date"];
    NSArray *Serviceid2 = [self getArrayFromJSONDictionary:recievedData forKey:@"Duration"];
    NSArray *Serviceid3 = [self getArrayFromJSONDictionary:recievedData forKey:@"EventTitle"];
    NSArray *Serviceid4 = [self getArrayFromJSONDictionary:recievedData forKey:@"Image"];
    NSArray *Serviceid5 = [self getArrayFromJSONDictionary:recievedData forKey:@"Day"];
    
    eventDesc = [[NSMutableArray alloc]initWithArray:ar2];
    eventId = [[NSMutableArray alloc]initWithArray:Serviceid];
    eventLoc = [[NSMutableArray alloc]initWithArray:ar1];
    eventdate = [[NSMutableArray alloc]initWithArray:Serviceid1];
    eventduration=[[NSMutableArray alloc]initWithArray:Serviceid2];
    eventTitle=[[NSMutableArray alloc]initWithArray:Serviceid3];
    eventImageArray=[[NSMutableArray alloc]initWithArray:Serviceid4];
    eventdayArray=[[NSMutableArray alloc]initWithArray:Serviceid5];
    
    
    
    for(int i=0;i<[eventdate count];i++)
    {
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | kCFCalendarUnitWeek | NSWeekdayCalendarUnit fromDate:[NSDate date]];
        NSInteger month = [components month];
        NSInteger week = [components week];
        NSInteger day = [components weekday];
        
        
        NSDate *date12 = [dateFormat dateFromString:[eventdate objectAtIndex:i]];
        
        NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |kCFCalendarUnitWeek | NSWeekdayCalendarUnit fromDate:date12];
        
        NSInteger day1 = [components1 weekday];
        NSInteger month1 = [components1 month];
        NSInteger year1 = [components1 year];
        NSInteger week1 = [components1 week];
        
        
     //   NSLog(@"%d",day1);
      //  NSLog(@"%d",month1);
      //  NSLog(@"%d",year1);
        
        
        NSString *Today_date=[self CurrentDate];
        NSDate *currentDate = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setDay:1];
        NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:currentDate options:0];
        
        NSDateFormatter* theDateFormatter = [[NSDateFormatter alloc] init];
        [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [theDateFormatter setDateFormat:@"EEEE"];
        NSString *todayday =  [theDateFormatter stringFromDate:[NSDate date]];
        
        if ([[eventdayArray objectAtIndex:i] isEqualToString:@"0"]) {
            if([[eventdate objectAtIndex:i] isEqualToString:Today_date])
            {
                [today1 addObject:[eventdate objectAtIndex:i]];
                [todayTitle addObject:[eventTitle objectAtIndex:i]];
                [todayDuration addObject:[eventduration objectAtIndex:i]];
                [todayDesc addObject:[eventDesc objectAtIndex:i]];
                [todayImg addObject:[eventImageArray objectAtIndex:i]];
                [todayDate addObject:[eventdate objectAtIndex:i]];
                [todayLoc addObject:[eventLoc objectAtIndex:i]];
            }
            else if(week == week1)
            {
                if (day < day1) {
                    [tomm addObject:[eventdate objectAtIndex:i]];
                    [tommTitle addObject:[eventTitle objectAtIndex:i]];
                    [tommDuration addObject:[eventduration objectAtIndex:i]];
                    [tommDesc addObject:[eventDesc objectAtIndex:i]];
                    [tommImg addObject:[eventImageArray objectAtIndex:i]];
                    [tommDate addObject:[eventdate objectAtIndex:i]];
                    [tommLoc addObject:[eventLoc objectAtIndex:i]];
                }
                
            }
            else if (month1==month)
            {
              //  NSLog(@"nextMonth detected");
                [mon addObject:[eventdate objectAtIndex:i]];
                [monTitle addObject:[eventTitle objectAtIndex:i]];
                [monDuration addObject:[eventduration objectAtIndex:i]];
                [monDesc addObject:[eventDesc objectAtIndex:i]];
                [monImg addObject:[eventImageArray objectAtIndex:i]];
                [monDate addObject:[eventdate objectAtIndex:i]];
                [monLoc addObject:[eventLoc objectAtIndex:i]];
                
            }
            else
            {
                [other addObject:[eventdate objectAtIndex:i]];
                [otherTitle addObject:[eventTitle objectAtIndex:i]];
                [otherDuration addObject:[eventduration objectAtIndex:i]];
                [otherDesc addObject:[eventDesc objectAtIndex:i]];
                [otherImg addObject:[eventImageArray objectAtIndex:i]];
                [otherDate addObject:[eventdate objectAtIndex:i]];
                [otherLoc addObject:[eventLoc objectAtIndex:i]];
                
            }
            
        }
        else
        {
            static NSDateFormatter *dateFormat;
            if (!dateFormat) {
                dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];

            }
            
            
            NSDate *now = [NSDate date];
            int daysToAdd = day1 - day;  // or 60 :-)
            NSDate *newDate1 = [now addTimeInterval:60*60*24*daysToAdd];
            
            daysToAdd = day1 + (7 - day);  // or 60 :-)
            NSDate *newDate2 = [now addTimeInterval:60*60*24*daysToAdd];
            
            NSDateComponents *components11 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |kCFCalendarUnitWeek | NSWeekdayCalendarUnit fromDate:newDate2];
            
            //                NSInteger day11 = [components11 weekday];
            NSInteger month11 = [components11 month];
            //                NSInteger year11 = [components11 year];
            //                NSInteger week11 = [components11 week];
            
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSString *newDate1String = [dateFormat stringFromDate:newDate2];
             NSString *newDateString = [dateFormat stringFromDate:newDate1];
            NSString *date12String = [dateFormat stringFromDate:date12];
            NSString *todayString = [dateFormat stringFromDate:[NSDate date]];
            
            NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
            [dateFormat1 setDateFormat:@"MM"];
            NSString *monthstr1 = [dateFormat1 stringFromDate:date12];
            NSString *monthstr2 = [dateFormat1 stringFromDate:newDate2];

            
            
//            if([[eventdayArray objectAtIndex:i] isEqualToString:todayday] && [date12String isEqualToString:todayString] ) {
//                NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
//                
//                [today1 addObject:dateString];
//                [todayTitle addObject:[eventTitle objectAtIndex:i]];
//                [todayDuration addObject:[eventduration objectAtIndex:i]];
//                [todayDesc addObject:[eventDesc objectAtIndex:i]];
//                [todayImg addObject:[eventImageArray objectAtIndex:i]];
//                [todayDate addObject:[eventdate objectAtIndex:i]];
//                [todayLoc addObject:[eventLoc objectAtIndex:i]];
//                
//                
//            }
            if([[eventdayArray objectAtIndex:i] isEqualToString:todayday]  ) {
                NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
                
                [today1 addObject:dateString];
                [todayTitle addObject:[eventTitle objectAtIndex:i]];
                [todayDuration addObject:[eventduration objectAtIndex:i]];
                [todayDesc addObject:[eventDesc objectAtIndex:i]];
                [todayImg addObject:[eventImageArray objectAtIndex:i]];
                [todayDate addObject:[eventdate objectAtIndex:i]];
                [todayLoc addObject:[eventLoc objectAtIndex:i]];
                
                
            }

            else if (day < day1 && ([date12 compare:newDate1] == NSOrderedSame || [date12 compare:newDate1] == NSOrderedAscending )) {
                
                
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                NSString *dateString = [dateFormat stringFromDate:newDate1];
                
                [tomm addObject:dateString];
                [tommTitle addObject:[eventTitle objectAtIndex:i]];
                [tommDuration addObject:[eventduration objectAtIndex:i]];
                [tommDesc addObject:[eventDesc objectAtIndex:i]];
                [tommImg addObject:[eventImageArray objectAtIndex:i]];
                [tommDate addObject:[eventdate objectAtIndex:i]];
                [tommLoc addObject:[eventLoc objectAtIndex:i]];
                
                
            }
            else if (month11 == month &&  [monthstr1 isEqualToString:monthstr2])
            {
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                NSString *dateString = [dateFormat stringFromDate:newDate2];
                if (([date12 compare:newDate2] == NSOrderedSame || [date12 compare:newDate2] == NSOrderedAscending ) ) {
                    [mon addObject:dateString];
                }
                else {
                    [mon addObject:[eventdate objectAtIndex:i]];
                }
                [monTitle addObject:[eventTitle objectAtIndex:i]];
                [monDuration addObject:[eventduration objectAtIndex:i]];
                [monDesc addObject:[eventDesc objectAtIndex:i]];
                [monImg addObject:[eventImageArray objectAtIndex:i]];
                [monDate addObject:[eventdate objectAtIndex:i]];
                [monLoc addObject:[eventLoc objectAtIndex:i]];
                
            }
           
            else
            {
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                NSString *dateString = [dateFormat stringFromDate:newDate2];
                
                if (([date12 compare:newDate2] == NSOrderedSame || [date12 compare:newDate2] == NSOrderedAscending ) ) {
                    [other addObject:dateString];
                }
                else {
                    [other addObject:[eventdate objectAtIndex:i]];
                }
                [otherTitle addObject:[eventTitle objectAtIndex:i]];
                [otherDuration addObject:[eventduration objectAtIndex:i]];
                [otherDesc addObject:[eventDesc objectAtIndex:i]];
                [otherImg addObject:[eventImageArray objectAtIndex:i]];
                [otherDate addObject:[eventdate objectAtIndex:i]];
                [otherLoc addObject:[eventLoc objectAtIndex:i]];
                
            }
            
            
        }
        
    }
    
    [tableService reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
    
}

-(NSString *)CurrentDate
{
    NSDate *date=[[NSDate alloc]init];

    NSString *Today=[dateFormat stringFromDate:date];
    return Today;
}

-(NSArray *) getArrayFromJSONDictionary:(NSDictionary *)parent forKey:(NSString *)key
{
    id obj = [parent objectForKey:key];
    if([obj isKindOfClass:[NSArray class]])
    {
        return obj;
    }
    if([obj length]==0)
    {
        return [[[NSArray alloc] init] autorelease];
    }
    NSArray *ret = [NSArray arrayWithObject:obj];
    return ret;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    title_Label.text = self.eventCategary;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    campusLocation_Label.text = [defaults objectForKey:@"CampusLocation"];
    

    today1=[[NSMutableArray alloc]init];
    tomm=[[NSMutableArray alloc]init];
    other=[[NSMutableArray alloc]init];
    mon=[[NSMutableArray alloc]init];
    
    todayTitle=[[NSMutableArray alloc]init];
    todayDuration=[[NSMutableArray alloc]init];
    todayDesc=[[NSMutableArray alloc]init];
    todayImg=[[NSMutableArray alloc]init];
    todayLoc=[[NSMutableArray alloc]init];


    tommTitle=[[NSMutableArray alloc]init];
    tommDuration=[[NSMutableArray alloc]init];
    tommDesc=[[NSMutableArray alloc]init];
    tommImg=[[NSMutableArray alloc]init];
    tommLoc=[[NSMutableArray alloc]init];

    
    monTitle=[[NSMutableArray alloc]init];
    monDuration=[[NSMutableArray alloc]init];
    monDesc=[[NSMutableArray alloc]init];
    monImg=[[NSMutableArray alloc]init];
    monLoc=[[NSMutableArray alloc]init];

    
    otherTitle=[[NSMutableArray alloc]init];
    otherDuration=[[NSMutableArray alloc]init];
    otherDesc=[[NSMutableArray alloc]init];
    otherImg=[[NSMutableArray alloc]init];
    otherLoc=[[NSMutableArray alloc]init];

    
    eventDesc=[[NSMutableArray alloc]init];
    eventId=[[NSMutableArray alloc]init];
    eventdate=[[NSMutableArray alloc]init];
    eventLoc=[[NSMutableArray alloc]init];
    eventduration=[[NSMutableArray alloc]init];
    
    title=[[NSMutableArray alloc]initWithObjects:@"Today",@"Tomorrow",nil];
    [self updatetable];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(currentOrientation:)
                                                 name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    

    
    

}
-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)updatetable
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {

            //tableService = [[UITableView alloc] initWithFrame:CGRectMake(0,45,self.view.frame.size.width,self.view.frame.size.height - 45 - 17 - 35 ) style:UITableViewStyleGrouped];

    }
    else {

            //tableService = [[UITableView alloc] initWithFrame:CGRectMake(0,110,self.view.frame.size.width,self.view.frame.size.height - 110 -17 - 35 ) style:UITableViewStyleGrouped];
    }
    

    tableService.delegate = self;
    tableService.dataSource = self;
    tableService.separatorStyle=NO;
    tableService.backgroundColor =[UIColor clearColor];
    tableService.opaque = NO;
    tableService.backgroundView = nil;
    
    [self.view addSubview:tableService];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int header;
  //  NSLog(@"Section=%d",section);
    if (section==0)
    {
        header=[today1 count];
    }
    else if (section==1)
    {
        header=[tomm count];
    }
    else if (section==2)
    {
        header=[mon count];
    }
    else
    {
        header=[other count];
    }
	return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 45;

    }
    else {
        return 80;

    }
}

-(void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
	static NSString *MyIdentifier = @"MyIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;

        [cell setBackgroundColor:[UIColor clearColor]];
        UIView *vew=[[UIView alloc]init];
        vew.backgroundColor=[UIColor clearColor];
        cell.backgroundView=vew;
	}
	else
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
        [cell setBackgroundColor:[UIColor clearColor]];
        UIView *vew=[[UIView alloc]init];
        vew.backgroundColor=[UIColor clearColor];
        cell.backgroundView=vew;
	}
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        lbl=[[[UILabel alloc]init] autorelease];
        lbl.frame=CGRectMake(10,0,300,30);
        lbl.font=[UIFont boldSystemFontOfSize:15.0];
        
        lbl1=[[[UILabel alloc]init] autorelease];
        lbl1.frame=CGRectMake(320 - 300,25,300,15);
        lbl1.textAlignment = NSTextAlignmentRight;
        lbl1.font=[UIFont boldSystemFontOfSize:12.0];
        
        lbl2=[[[UILabel alloc]init] autorelease];
        lbl2.font=[UIFont boldSystemFontOfSize:12.0];
        lbl2.frame=CGRectMake(10,25,300,15);
    }
    else {
        lbl=[[[UILabel alloc]init] autorelease];
        lbl.frame=CGRectMake(10,0,500,40);
        lbl.font=[UIFont boldSystemFontOfSize:25.0];
        
        lbl2=[[[UILabel alloc]init] autorelease];
        lbl2.font=[UIFont boldSystemFontOfSize:20.0];
        lbl2.frame=CGRectMake(20,45,300,25);
        
        lbl1=[[[UILabel alloc]init] autorelease];
        lbl1.frame=CGRectMake(600,45,200,25);
        lbl1.font=[UIFont boldSystemFontOfSize:20.0];
    }



    
    if ( indexPath.section==0 )
    {

        lbl.text=[ todayTitle objectAtIndex:indexPath.row];
        [lbl setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
        

        NSString *str1234 =[[NSString alloc]initWithFormat:@"Time: %@",[todayDuration objectAtIndex:indexPath.row]];
        lbl1.text=str1234;
        [lbl1 setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl1 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl1];
        

        NSString *str123 =[[NSString alloc]initWithFormat:@"Date: %@",[today1 objectAtIndex:indexPath.row]];
        lbl2.text=str123;
        [lbl2 setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl2];
        

    }
    else if ( indexPath.section==1 )
    {

        lbl.text=[ tommTitle objectAtIndex:indexPath.row];
        [lbl setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
        

        NSString *str1234 =[[NSString alloc]initWithFormat:@"Time: %@",[tommDuration objectAtIndex:indexPath.row]];
        lbl1.text=str1234;
        [lbl1 setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl1 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl1];
        

        NSString *str123 =[[NSString alloc]initWithFormat:@"Date: %@",[tomm objectAtIndex:indexPath.row]];
        lbl2.text=str123;
        [lbl2 setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl2];
        

    }
    else if ( indexPath.section==2 )
    {

        lbl.text=[ monTitle objectAtIndex:indexPath.row];
        [lbl setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
        

        NSString *str1234 =[[NSString alloc]initWithFormat:@"Time: %@",[monDuration objectAtIndex:indexPath.row]];
        lbl1.text=str1234;
        [lbl1 setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl1 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl1];
        

        NSString *str123 =[[NSString alloc]initWithFormat:@"Date: %@",[mon objectAtIndex:indexPath.row]];
        lbl2.text=str123;
        [lbl2 setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl2];
        

    }
    else
    {

        lbl.text=[ otherTitle objectAtIndex:indexPath.row];
        [lbl setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
        

        NSString *str1234 =[[NSString alloc]initWithFormat:@"Time: %@",[otherDuration objectAtIndex:indexPath.row]];
        lbl1.text=str1234;
        [lbl1 setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl1 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl1];
        

        NSString *str123 =[[NSString alloc]initWithFormat:@"Date: %@",[other objectAtIndex:indexPath.row]];
        lbl2.text=str123;
        [lbl2 setTextColor:[self colorWithHexString:@"153e7e"]];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl2];
        

    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,43,tableView.frame.size.width,02)];
        UIImage *imgFile = [UIImage imageNamed:@"divider.png"];
        [imageView1 setImage:imgFile];
        [cell addSubview:imageView1];
        [imageView1 release];
    }
    else {
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,78,tableView.frame.size.width,02)];
        UIImage *imgFile = [UIImage imageNamed:@"divider.png"];
        [imageView1 setImage:imgFile];
        [cell addSubview:imageView1];
        [imageView1 release];
    }

	return cell;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return  30;
    }
    else {
        return  60.0;
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    UIImageView *bottomimg;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        headerView= [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
        bottomimg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,30)];

    }
    else {
        headerView= [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)] autorelease];
        bottomimg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,60)];

    }
    bottomimg.image = [UIImage imageNamed:@"title.png"];
    [headerView addSubview:bottomimg];
    
    headerlbl=[[[UILabel alloc]init] autorelease];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        headerlbl.frame=CGRectMake(10,7,200,15);
        headerlbl.font=[UIFont boldSystemFontOfSize:15];
    }
    else {
        headerlbl.frame=CGRectMake(10,18,200,30);
        headerlbl.font=[UIFont boldSystemFontOfSize:20];
    }

    
    
    if(section==0)
    {
        headerlbl.text=@"Today";
	}
    else if(section==1)
    {
        headerlbl.text=@"This Week";
	}
    else if(section==2)
    {
        headerlbl.text=@"This Month";
	}
    else
    {
        headerlbl.text=@"Others";
    }
    [headerlbl setTextColor:[UIColor whiteColor]];
	[headerlbl setBackgroundColor:[UIColor clearColor]];
 	[bottomimg addSubview:headerlbl];
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    showEvent *mp;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        mp=[[showEvent alloc]initWithNibName:@"showEvent" bundle:nil];

    }
    else {
        mp=[[showEvent alloc]initWithNibName:@"showEvent_iPad" bundle:nil];

    }
    [self.navigationController pushViewController:mp animated:YES];
    
    


    if (indexPath.section == 0) {
        
        mp.time_Label.text = [NSString stringWithFormat:@"Time: %@",[todayDuration objectAtIndex:indexPath.row]];;
        mp.date_Label.text = [NSString stringWithFormat:@"Date: %@",[today1 objectAtIndex:indexPath.row]];
        mp.title_Label.text = [todayTitle objectAtIndex:indexPath.row];
        mp.location_Label.text = [todayLoc objectAtIndex:indexPath.row];
        mp.imageURl = [todayImg objectAtIndex:indexPath.row];
        mp.description_TextView.text = [todayDesc objectAtIndex:indexPath.row];
        

//        show.date.text = [NSString stringWithFormat:@"Date: %@",[today1 objectAtIndex:indexPath.row]];
//        show.time.text = [NSString stringWithFormat:@"Time: %@",[todayDuration objectAtIndex:indexPath.row]];
//        show.desc.text = [NSString stringWithFormat:@"%@",[todayDesc objectAtIndex:indexPath.row]];
//        show.urlString = [todayImg objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1){
        
        mp.time_Label.text = [NSString stringWithFormat:@"Time: %@",[tommDuration objectAtIndex:indexPath.row]];;
        mp.date_Label.text = [NSString stringWithFormat:@"Date: %@",[tomm objectAtIndex:indexPath.row]];
        mp.title_Label.text = [tommTitle objectAtIndex:indexPath.row];
        mp.location_Label.text = [tommLoc objectAtIndex:indexPath.row];
        mp.imageURl = [tommImg objectAtIndex:indexPath.row];
        mp.description_TextView.text = [tommDesc objectAtIndex:indexPath.row];

//        show.date.text = [NSString stringWithFormat:@"Date: %@",[tomm objectAtIndex:indexPath.row]];
//        show.time.text = [NSString stringWithFormat:@"Time: %@",[tommDuration objectAtIndex:indexPath.row]];
//        show.desc.text = [NSString stringWithFormat:@"%@",[tommDesc objectAtIndex:indexPath.row]];
//        
//        show.urlString = [tommImg objectAtIndex:indexPath.row];

    }
    else if (indexPath.section == 2){
        
        mp.time_Label.text = [NSString stringWithFormat:@"Time: %@",[monDuration objectAtIndex:indexPath.row]];;
        mp.date_Label.text = [NSString stringWithFormat:@"Date: %@",[mon objectAtIndex:indexPath.row]];
        mp.title_Label.text = [monTitle objectAtIndex:indexPath.row];
        mp.location_Label.text = [monLoc objectAtIndex:indexPath.row];
        mp.imageURl = [monImg objectAtIndex:indexPath.row];
        mp.description_TextView.text = [monDesc objectAtIndex:indexPath.row];

//        show.date.text = [NSString stringWithFormat:@"Date: %@",[mon objectAtIndex:indexPath.row]];
//        show.time.text = [NSString stringWithFormat:@"Time: %@",[monDuration objectAtIndex:indexPath.row]];
//        show.desc.text = [NSString stringWithFormat:@"%@",[monDesc objectAtIndex:indexPath.row]];
//        show.urlString = [monImg objectAtIndex:indexPath.row];

    }
    else {
        
        mp.time_Label.text = [NSString stringWithFormat:@"Time: %@",[otherDuration objectAtIndex:indexPath.row]];;
        mp.date_Label.text = [NSString stringWithFormat:@"Date: %@",[other objectAtIndex:indexPath.row]];
        mp.title_Label.text = [otherTitle objectAtIndex:indexPath.row];
        mp.location_Label.text = [otherLoc objectAtIndex:indexPath.row];
        mp.imageURl = [otherImg objectAtIndex:indexPath.row];
        mp.description_TextView.text = [otherDesc objectAtIndex:indexPath.row];

//        show.date.text = [NSString stringWithFormat:@"Date: %@",[other objectAtIndex:indexPath.row]];
//        show.time.text = [NSString stringWithFormat:@"Time: %@",[otherDuration objectAtIndex:indexPath.row]];
//        show.desc.text = [NSString stringWithFormat:@"%@",[otherDesc objectAtIndex:indexPath.row]];
//        show.urlString = [otherImg objectAtIndex:indexPath.row];

    }
    mp.category_Label.text = title_Label.text;
    [mp release];
    


}

-(void)removeActivity
{
    [DejalBezelActivityView removeViewAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{

    [DejalBezelActivityView activityViewForView:self.view];
    
    [self performSelector:@selector(come) withObject:nil afterDelay:0.1];
    [NSThread detachNewThreadSelector:@selector(GettingServisec) toTarget:self withObject:nil];
    ///[self createAdBannerView];
    
    _adBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    [_adBannerView setDelegate:self];
    [_adBannerView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin)];
    _adBannerView.hidden = YES;
    [self.view addSubview:_adBannerView];

}

-(void)come
{
    UIButton *button1 = [[[UIButton alloc] init] autorelease];
    button1.frame=CGRectMake(0,0,58,30);
    button1.titleLabel.font= [UIFont boldSystemFontOfSize:14];
    [button1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed: @"back1.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 release];
}



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
