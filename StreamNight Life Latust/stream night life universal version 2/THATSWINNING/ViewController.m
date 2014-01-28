////  ViewController.m
//  THATSWINNING
//  Created by Mohit on 18/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "ViewController.h"
#import "campusEvents.h"
#import "AdminLogin.h"
#import "selectAccount.h"
#import "about.h"
#import "applicationManager.h"
#import "normalAccount.h"
#import "login_scr.h"
#import "CampusHappeningViewController.h"
#import "NightNecessities.h"
#import "NightTrackingViewController.h"
#import "NecessitiesList.h"
#import "FindARideViewController.h"
#import "EmergencyViewController.h"
#import "AppDelegate.h"
#import "checkViewController.h"

@interface ViewController () <UIActionSheetDelegate>

@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation ViewController
@synthesize carousel;
@synthesize wrap;
@synthesize items;

- (void)setUp
{
    //set up data
    wrap = YES;
   self.items = [[NSMutableArray array]init];
    for (int i = 0; i < 4; i++)
    {
        [self.items addObject:@(i)];
    }
   
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
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

-(void)dealloc
{
    [tableService release];
    [campus release];
    [arraycampus release];
    [bottomview release];
    
    [super dealloc];
}

-(IBAction)movetoAdmin:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([strlocation isEqualToString:@""])
    {
        UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please select location first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [pop show];
        [pop release];
    }
    else
    {
        if([defaults objectForKey:@"admin"])
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                applicationManager *appmgr=[[applicationManager alloc]initWithNibName:@"applicationManager" bundle:nil];
                [self.navigationController pushViewController:appmgr animated:YES];
                [appmgr release];
            }
            else {
                applicationManager *appmgr=[[applicationManager alloc]initWithNibName:@"applicationManager_iPad" bundle:nil];
                [self.navigationController pushViewController:appmgr animated:YES];
                [appmgr release];
            }

        }
        else
        {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                
               AdminLogin *dl3=[[[AdminLogin alloc]initWithNibName:@"AdminLogin" bundle:nil]retain];
                [self.navigationController pushViewController:dl3 animated:YES];
             
               [dl3 release];


            }
            else {
             
               
              AdminLogin *dl3=[[[AdminLogin alloc]initWithNibName:@"AdminLogin_iPad" bundle:nil]retain];
                [self.navigationController pushViewController:dl3 animated:YES];
                [dl3 release];
               
                

            }
            

        }
    }
}

-(IBAction)movetodeal_location:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //  NSLog(@"%@",[defaults objectForKey:@"login_name"]);
    
    if( [[defaults objectForKey:@"Slogin_name"] isEqualToString:@"Student"])
    {
      //  NSLog(@"%@",strlocation);
        if([strlocation isEqualToString:@""])
        {
            UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please select location first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [pop show];
            [pop release];
        }
        else
        {

        }
    }
    else
    {
        UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please sign in as Student" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [pop show];
        [pop release];
    }
}

-(IBAction)movetoNight:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // NSLog(@"%@",[defaults objectForKey:@"Slogin_name"]);
    if( [[defaults objectForKey:@"Slogin_name"] isEqualToString:@"Student"])
    {
//    NSLog(@"%@",strlocation);
//    if([strlocation isEqualToString:@""])
//    {
//        UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Select Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [pop show];
//        [pop release];
//    }
//    else
//    {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            NightTrackingViewController *dl2=[[NightTrackingViewController alloc]initWithNibName:@"NightTrackingViewController" bundle:nil];
            [self.navigationController pushViewController:dl2 animated:YES];
            [dl2 release];
        }
        else {
            NightTrackingViewController *dl2=[[NightTrackingViewController alloc]initWithNibName:@"NightTrackingViewController_iPad" bundle:nil];
            [self.navigationController pushViewController:dl2 animated:YES];
            [dl2 release];
        }

//    }
    }
    else
    {
        UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please sign in as Student" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [pop show];
        [pop release];
    }
}

-(IBAction)movetoEvent:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if( [[defaults objectForKey:@"Slogin_name"] isEqualToString:@"Student"])
    {
      //  NSLog(@"strlocation%@",strlocation);
        if([strlocation isEqualToString:@""])
        {
            UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please select location first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [pop show];
            [pop release];
        }
        else
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                CampusHappeningViewController *campusEvent = [[CampusHappeningViewController alloc] initWithNibName:@"CampusHappeningViewController" bundle:nil];
                [self.navigationController pushViewController:campusEvent animated:YES];
                //[campusEvent release];
            }
            else {
                CampusHappeningViewController *campusEvent = [[CampusHappeningViewController alloc] initWithNibName:@"CampusHappeningViewController_iPad" bundle:nil];
                [self.navigationController pushViewController:campusEvent animated:YES];
               // [campusEvent release];
            }


//            campusEvents *dl1=[[campusEvents alloc]init];
//            [self.navigationController pushViewController:dl1 animated:YES];
//            [dl1 release];
        }
    }
    else
    {
        UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please sign in as Student" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [pop show];
        [pop release];
    }
}

-(IBAction)movetoNightNecessaties:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if( [[defaults objectForKey:@"Slogin_name"] isEqualToString:@"Student"])
    {
       // NSLog(@"strlocation%@",strlocation);
        if([strlocation isEqualToString:@""])
        {
            UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please select location first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [pop show];
            [pop release];
        }
        else
        {
            NightNecessities *nightNecessities;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                nightNecessities = [[NightNecessities alloc] initWithNibName:@"NightNecessities" bundle:nil];

            }
            else {
                nightNecessities = [[NightNecessities alloc] initWithNibName:@"NightNecessities_iPad" bundle:nil];

            }
            [self.navigationController pushViewController:nightNecessities animated:YES];
            [nightNecessities release];
        }
    }
    else
    {
        UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please sign in as Student" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [pop show];
        [pop release];
    }
}

-(IBAction)moveToSignUp {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(![appDelegate isConnected]){
        UIAlertView *alrtView=[[UIAlertView alloc]initWithTitle:@"Internet Connection fails" message:@"You can't signup" delegate:Nil cancelButtonTitle:Nil otherButtonTitles:@"Ok", nil];
        [alrtView show];
        return;
    }

    @try
    {
        if([strlocation isEqualToString:@""])
        {
            UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please select location first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [pop show];
            [pop release];
        }
        else
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                normalAccount *dl2=[[normalAccount alloc]initWithNibName:@"normalAccount" bundle:nil];
                [self.navigationController pushViewController:dl2 animated:YES];
                [dl2 release];
            }
            else {
                normalAccount *dl2=[[normalAccount alloc]initWithNibName:@"normalAccount_iPad" bundle:nil];
                [self.navigationController pushViewController:dl2 animated:YES];
                [dl2 release];
            }
            
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception);
    }

}

-(IBAction)movetoSignIn:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(![appDelegate isConnected]){
        UIAlertView *alrtView=[[UIAlertView alloc]initWithTitle:@"Internet Connection fails" message:@"You can't signin" delegate:Nil cancelButtonTitle:Nil otherButtonTitles:@"Ok", nil];
        [alrtView show];
        return;
    }

    if([strlocation isEqualToString:@""])
    {
        UIAlertView *pop=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please select location first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [pop show];
        [pop release];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"Slogin_name"] !=NULL) {

            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:nil forKey:@"Slogin_name"];
            [defaults setObject:nil forKey:@"studentID"];
            [defaults synchronize];
            [b3 setTitle:@"Sign In" forState:UIControlStateNormal];

        }
        else {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                login_scr *popo=[[login_scr alloc]initWithNibName:@"login_scr" bundle:nil];
                popo.str=@"User Login";
                [self.navigationController pushViewController:popo animated:YES];
                [popo release];
            }
            else {
                login_scr *popo=[[login_scr alloc]initWithNibName:@"login_scr_iPad" bundle:nil];
                popo.str=@"User Login";
                [self.navigationController pushViewController:popo animated:YES];
                [popo release];
            }
            
        }

    }
}

-(void)viewDidAppear:(BOOL)animated
{
  
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *RightBut=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(moveToAbout:)];
    self.navigationItem.rightBarButtonItem=RightBut;
    
//    UIBarButtonItem *LeftBut=[[UIBarButtonItem alloc]initWithTitle:@"Campus" style:UIBarButtonItemStyleBordered  target:self action:@selector(showCampusView)];
//    self.navigationItem.leftBarButtonItem=LeftBut;
    [self loadHomeSreen];
    CGRect rect = tableService.frame;
    rect.size.height = 0;
    tableService.frame = rect;
    CGRect rect1 = campus.frame;
    rect1.size.height = 0;
    campus.frame = rect1;
   
    NSLog(@"Speed=%f",carousel.scrollSpeed);
    
}



-(IBAction)moveToAbout:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        about *ab=[[about alloc]initWithNibName:@"about" bundle:nil];
        [self.navigationController pushViewController:ab animated:YES];
        [ab release];
    }
    else {
        about *ab=[[about alloc]initWithNibName:@"about_iPad" bundle:nil];
        [self.navigationController pushViewController:ab animated:YES];
        [ab release];
    }

}

-(void)viewDidLoad
{
    [super viewDidLoad];
     carousel.backgroundColor=[UIColor clearColor];
    
    

 
   carousel.type = iCarouselTypeCoverFlow;
   
//    if ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0 ) {
//        // Create resizable images
//        UIImage *gradientImageP = [[UIImage imageNamed:@"header"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//        UIImage *gradientImageL = [[UIImage imageNamed:@"header-Landscape"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//        [[UINavigationBar appearance] setBackgroundImage:gradientImageP
//                                           forBarMetrics:UIBarMetricsDefault];
//        [[UINavigationBar appearance] setBackgroundImage:gradientImageL
//                                           forBarMetrics:UIBarMetricsLandscapePhone];
//        [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
//        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0 green: 0 blue:0  alpha:1]];
//    }
    
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0,-5, 320, 54)];
//    img.image = [UIImage imageNamed:@"banner.png"];
//    self.navigationController.navigationBar.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"banner.png"]];
    
    //campus.hidden=YES;
    
    campus.userInteractionEnabled=YES;
    
    arraycampus=[[NSMutableArray alloc]initWithObjects:@"Eau Claire, Wisconsin",@"Menomonie, Wisconsin",@"River Falls, Wisconsin",@"Milwaukee, Wisconsin", @"Madison, Wisconsin", nil];
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    [self updatetable];
    //Bottom-----------------------------------------------------------
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
    bottomimg.image = [UIImage imageNamed:@"bottom-bg.png"];
    [bottomview addSubview:bottomimg];
    [bottomimg release];
    
    b1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b1 addTarget:self action:@selector(movetoAdmin:) forControlEvents:UIControlEventTouchUpInside];
    b1.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
    b1.titleLabel.numberOfLines=2;
    [b1 setTitle:@"Admin" forState:UIControlStateNormal];
    b1.frame = CGRectMake(0,07,105,40);
    [bottomview addSubview:b1];
    
    b2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b2 addTarget:self action:@selector(moveToSignUp) forControlEvents:UIControlEventTouchUpInside];
    b2.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
    b2.titleLabel.numberOfLines=2;
    [b2 setTitle:@"Sign Up" forState:UIControlStateNormal];
    b2.selected=YES;
    b2.frame = CGRectMake(115,07,75,40);
    [bottomview addSubview:b2];
    
    b3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b3 addTarget:self action:@selector(movetoSignIn:) forControlEvents:UIControlEventTouchUpInside];
    b3.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
    b3.titleLabel.numberOfLines=2;
    b3.frame = CGRectMake(220,07,75,40);
    [bottomview addSubview:b3];
       
        
    }
    else {
        campus_TableView.layer.cornerRadius = 10.0;
    }
    
    [b1 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
    [b2 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
    [b3 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"Slogin_name"] !=NULL) {
        [b3 setTitle:@"Sign Out" forState:UIControlStateNormal];
    }
    else {
        [b3 setTitle:@"Sign In" forState:UIControlStateNormal];
    }

    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *key = [userdefault objectForKey:@"WelcomeNote"];
    if (!key) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Smart move downloading. Select your campus, sign up, and then browse and share the ways to have fun. By clicking ok you agree to our terms and conditions on our site www.streamnightlife.com. Enjoy! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 11;
        [alert show];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImage *backgroundImage = [UIImage imageNamed:@"topBanner_iPad.png"];
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 44)];
        [bgView setImage:backgroundImage];
        
        [self.navigationController.navigationBar insertSubview:bgView atIndex:1];
        [bgView release];

    }
    else {
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
       // NSLog(@"%f",version);
        UIImage *backgroundImage = [UIImage imageNamed:@"banner.png"];
        if (version >= 5.0) {
            [[UINavigationBar appearance] setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        }
        else
        {
            [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:backgroundImage] autorelease] atIndex:1];
        }
    }
    
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 11) {
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        [userdefault setObject:@"ok" forKey:@"WelcomeNote"];
        [userdefault synchronize];
    }
}

-(IBAction)onClickLinkButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.streamnightlife.com"]];
}
-(void)viewWillAppear:(BOOL)animated {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"Slogin_name"] !=NULL) {
        [b3 setTitle:@"Sign Out" forState:UIControlStateNormal];
    }
    else {
        [b3 setTitle:@"Sign In" forState:UIControlStateNormal];
    }
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"welcome" ofType:@"png"];
    if (pathStr != nil) {
        
    }

}


-(void)loadHomeSreen {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"CampusLocation"] !=NULL) {
        locationLabel.text = [defaults objectForKey:@"CampusLocation"];
        strlocation = [defaults objectForKey:@"CampusLocation"];
    }
    
   // NSLog(@"strlocation:%@",strlocation);
    
    NSString *str= [defaults objectForKey:@"studentID"];
 //   NSLog(@"Student Id=%@",str);
    
  //  NSLog(@"Login name= %@",[defaults objectForKey:@"Slogin_name"]);
    
    // strlocation=[[NSString alloc]init];
    
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
    green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    
}

-(IBAction)showcampus:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        if(campusbtn.selected==NO)
        {
            campusbtn.selected = YES;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:.3];
            CGRect rect = tableService.frame;
            rect.size.height = 235;
            tableService.frame = rect;
            CGRect rect1 = campus.frame;
            rect1.size.height = 275;
            campus.frame = rect1;
            //campus.frame =self.view.bounds;
            [UIView commitAnimations];
            
        }
        else
        {
            campusbtn.selected = NO;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:0.3];
            CGRect rect = tableService.frame;
            rect.size.height = 0;
            tableService.frame = rect;
            CGRect rect1 = campus.frame;
            rect1.size.height = 0;
            campus.frame = rect1;
           // campus.frame =self.view.bounds;
            [UIView commitAnimations];
            //[self performSelector:@selector(changeStateOfCampus) withObject:nil afterDelay:1.0];
            
        }
        
    }
    else {
        UIButton *btn = (UIButton *)sender;
        if (btn.selected) {
            btn.selected = NO;
            CGRect rect = campus_TableView.frame;
            rect.size.height = 0;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            campus_TableView.frame = rect;
           // campus_TableView.frame =self.view.bounds;
            [UIView commitAnimations];
            
            
            
        }
        else {
            btn.selected = YES;
            CGRect rect = campus_TableView.frame;
            rect.size.height = 300;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            campus_TableView.frame = rect;
            // campus_TableView.frame =self.view.bounds;
            [UIView commitAnimations];
        }
    }
}


-(void)updatetable
{
  tableService = [[UITableView alloc] initWithFrame:CGRectMake(15,30,170,235) style:UITableViewStylePlain];
  
    tableService.delegate = self;
    tableService.dataSource = self;
    tableService.separatorStyle=NO;
    tableService.scrollEnabled=NO;
    tableService.backgroundColor = [UIColor clearColor];
    [campus addSubview:tableService];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 45;

    }
    else {
        return 60;
        
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraycampus count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
	}
	else
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
	}
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        lbl=[[[UILabel alloc]init] autorelease];
        lbl.frame=CGRectMake(05,0,tableView.frame.size.width, 30);
        lbl.numberOfLines=2;
        lbl.font=[UIFont boldSystemFontOfSize:12.0];
        lbl.text=[arraycampus objectAtIndex:indexPath.row];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(00,44,tableView.frame.size.width,01)];
        UIImage *imgFile = [UIImage imageNamed:@"divider.png"];
        [imageView1 setImage:imgFile];
        [cell addSubview:imageView1];
        [imageView1 release];

    }
    else {
        lbl=[[[UILabel alloc]init] autorelease];
        lbl.frame=CGRectMake(0,0,tableView.frame.size.width, 60);
        lbl.numberOfLines=2;
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font=[UIFont boldSystemFontOfSize:18.0];
        lbl.text=[arraycampus objectAtIndex:indexPath.row];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(00,59,tableView.frame.size.width,01)];
        UIImage *imgFile = [UIImage imageNamed:@"divider.png"];
        [imageView1 setImage:imgFile];
        [cell addSubview:imageView1];
        [imageView1 release];

    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        strlocation=[arraycampus objectAtIndex:indexPath.row];
      //  NSLog(@"%@",strlocation);
        locationLabel.text = strlocation;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:strlocation forKey:@"CampusLocation"];
        [defaults synchronize];
        [self showcampus:campusbtn] ;
   
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



//   if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//   }
//   else {
//   }

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
    return self.items.count;
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
     
    //create new view if no view is available for recycling
    
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
     UIImage *image =  [[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",index+2] ]resizedImage:CGSizeMake(210,250) interpolationQuality:kCGInterpolationHigh];
              
        [(FXImageView *)view setImage:image];

    }
    else {
        UIImage *image =  [[UIImage imageNamed:[NSString stringWithFormat:@"iPad%d.png",index+2] ]resizedImage:CGSizeMake(600,700) interpolationQuality:kCGInterpolationHigh];
        
        [(FXImageView *)view setImage:image];

    }

  
      return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return self.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
                      
          view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 210, 280.0f)];
         UIImage *image =  [[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",index+2] ]resizedImage:CGSizeMake(210,250) interpolationQuality:kCGInterpolationHigh];
      //  UIImage *image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",index+2]];
        ((UIImageView *)view).image = image;

        view.contentMode = UIViewContentModeCenter;
       
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        label.tag = 1;
       // [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = (index == 0)? @"[": @"]";
    
    return view;
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
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
            return wrap;
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
    ++index;
   
    if(!index){
        CGRect rect=self.carousel.frame;
        oldRect=rect;
        
        rect.origin.x=-2*self.carousel.frame.size.width;
       
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.carousel.frame=rect;        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backToCarosel)];
        [UIView commitAnimations];

                       }
    else  if(index==1){
       
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [self movetoEvent:nil];
        [UIView commitAnimations];
        
    }
//    else  if(index==2){
//        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        [self onButtonClick:@"Student Tips"];
//        [UIView commitAnimations];
//        
//    }
//    else  if(index==3){
//        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        [self onButtonClick:@"Places To Go"];
//        [UIView commitAnimations];
//        
//    }
    else  if(index==2){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [self onClickFindRide_Button:nil];
        [UIView commitAnimations];
        
    }
//    else  if(index==3){
//        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        [self onClickFindRide_Button:nil];
//        [UIView commitAnimations];
//        
//    }
    else  if(index==3){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [self onClickEmergency_Button:nil];
        [UIView commitAnimations];
        
    }
//    else  if(index==4){
//        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        [self onClickEmergency_Button:nil];
//        [UIView commitAnimations];
//        
//    }
    else  if(index==4){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [self movetoNight:nil];
        [UIView commitAnimations];
        
    }
    else  if(index==5){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [self movetoNight:nil];
        [UIView commitAnimations];
        
    }

    //NSLog(@"Tapped view number: %@", item);
}
-(void)backToCarosel{
   
   
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
     self.navigationItem.leftBarButtonItem=Nil;
    self.carousel.frame=oldRect;
   
    [UIView commitAnimations];

    
}


-(void)onButtonClick:(NSString*)text {
   
    NecessitiesList *necessitiesList;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        necessitiesList = [[NecessitiesList alloc] initWithNibName:@"NecessitiesList" bundle:nil];
        
    }
    else {
        necessitiesList = [[NecessitiesList alloc] initWithNibName:@"NecessitiesList_iPad" bundle:nil];
        
    }
    necessitiesList.campusLocationString = locationLabel.text;
    necessitiesList.titleString = text;
    [self.navigationController pushViewController:necessitiesList animated:YES];
    
}

-(IBAction)onClickFindRide_Button:(id)sender {
    
    FindARideViewController *findRideViewController;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        findRideViewController = [[FindARideViewController alloc] initWithNibName:@"FindARideViewController" bundle:nil];
    }
    else {
        findRideViewController = [[FindARideViewController alloc] initWithNibName:@"FindARideViewController_iPad" bundle:nil];
    }
    
    [self.navigationController pushViewController:findRideViewController animated:YES];
}

-(IBAction)onClickEmergency_Button:(id)sender {
    EmergencyViewController *emergencyViewController;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        emergencyViewController = [[EmergencyViewController alloc] initWithNibName:@"EmergencyViewController" bundle:nil];
        
    }
    else {
        emergencyViewController = [[EmergencyViewController alloc] initWithNibName:@"EmergencyViewController_iPad" bundle:nil];
        
    }
    [self.navigationController pushViewController:emergencyViewController animated:YES];
}

@end
