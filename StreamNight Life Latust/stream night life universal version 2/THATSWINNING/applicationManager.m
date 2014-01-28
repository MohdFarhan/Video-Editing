//  applicationManager.m
//  THATSWINNING
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "applicationManager.h"
#import "reviewEvents.h"
#import "manageContent.h"
#import "AdminLogin.h"
#import "ViewController.h"
#import "Settings.h"
#import "NightNecessitiesApprovalControllerViewController.h"
@interface applicationManager ()
@end

@implementation applicationManager

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

-(void)dealloc
{
    //[responseData release];
    //[ar release];
//    [bottomview release];
//    [b1 release];
//    [b2 release];
//    [b3 release];
//    [text1 release];
    [super dealloc];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

-(IBAction)moveToSettings:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        Settings *set=[[Settings alloc]initWithNibName:@"Settings" bundle:nil];
        [self.navigationController pushViewController:set animated:YES];
        [set release];
    }
    else {
        Settings *set=[[Settings alloc]initWithNibName:@"Settings_iPad" bundle:nil];
        [self.navigationController pushViewController:set animated:YES];
        [set release];
    }

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton=YES;
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
    [b1 addTarget:self action:@selector(movetoHome:) forControlEvents:UIControlEventTouchUpInside];
    b1.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
    b1.titleLabel.numberOfLines=2;

    [b1 setTitle:@"Home" forState:UIControlStateNormal];
    b1.frame = CGRectMake(0,07,105,40);
    [bottomview addSubview:b1];
    
    b2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b2 addTarget:self action:@selector(moveToSettings:) forControlEvents:UIControlEventTouchUpInside];
    b2.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
    b2.titleLabel.numberOfLines=2;

    [b2 setTitle:@"Setting" forState:UIControlStateNormal];
    b2.selected=YES;
    b2.frame = CGRectMake(115,07,75,40);
    [bottomview addSubview:b2];
    if(!b2.highlighted)
    {
        b2.highlighted=YES;
    }
    b3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b3 addTarget:self action:@selector(movetoSignOut:) forControlEvents:UIControlEventTouchUpInside];
    b3.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
    b3.titleLabel.numberOfLines=2;

    [b3 setTitle:@"Sign out" forState:UIControlStateNormal];
    b3.frame = CGRectMake(220,07,75,40);
    [bottomview addSubview:b3];
    }
    else {
        campus_TableView.layer.cornerRadius = 10.0;
    }
    [b1 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
    [b2 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
    [b3 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
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

-(IBAction)movetoSignOut:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"admin"];
    [defaults setObject:nil forKey:@"BID"];
    [defaults synchronize];

   // NSLog(@"%@",[defaults objectForKey:@"admin"]);

    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Successfully Logout" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alt show];
    [alt release];
}

-(IBAction)done1:(id)sender
{
    //NSLog(@"%d",phase);
    if([[ar objectAtIndex:0] isEqualToString:@"Success"])
    {
        phase=0;
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Successfully Change Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alt show];
        [alt release];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"%d",phase);
    if(phase==10)
    {
        if(buttonIndex==alertView.cancelButtonIndex)
        {
            if( [text1.text length]<=0 )
            {
                UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Value" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alt show];
                [alt release];
            }
            else
            {
               // [self GettingServisec];
               // [self done1:0];
            }
        }
    }
    else
    {
        if(buttonIndex==alertView.cancelButtonIndex)
        {
            [self movetoHome:0];
        }
    }
}

-(IBAction)movetoHome:(id)sender
{
//    ViewController *dl5=[[ViewController alloc]init];
//    [self.navigationController pushViewController:dl5 animated:YES];
//    [dl5 release];
    NSArray *viewControllerArray = self.navigationController.viewControllers;
    for (UIViewController *viewController in viewControllerArray) {
        if ([viewController isKindOfClass:[ViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}

-(IBAction)movetoNightNecessitiesApproval:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        NightNecessitiesApprovalControllerViewController *nightNecessitiesApproval=[[NightNecessitiesApprovalControllerViewController alloc]initWithNibName:@"NightNecessitiesApprovalControllerViewController" bundle:nil];
        [self.navigationController pushViewController:nightNecessitiesApproval animated:YES];
        [nightNecessitiesApproval release];
    }
    else
    {
        
        NightNecessitiesApprovalControllerViewController *nightNecessitiesApproval=[[NightNecessitiesApprovalControllerViewController alloc]initWithNibName:@"NightNecessitiesApprovalControllerViewController_iPad" bundle:nil];
        [self.navigationController pushViewController:nightNecessitiesApproval animated:YES];
        [nightNecessitiesApproval release];
    }

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



-(IBAction)movetomanage:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        manageContent *edeal=[[manageContent alloc]initWithNibName:@"manageContent" bundle:nil];
        [self.navigationController pushViewController:edeal animated:YES];
        [edeal release];
    }
    else
    {
        
        manageContent *edeal=[[manageContent alloc]initWithNibName:@"manageContent_iPad" bundle:nil];
        [self.navigationController pushViewController:edeal animated:YES];
        [edeal release];
    }

}

-(IBAction)movetoreviewEvent:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        reviewEvents *edeal=[[reviewEvents alloc]initWithNibName:@"reviewEvents" bundle:nil];
        [self.navigationController pushViewController:edeal animated:YES];
        [edeal release];
    }
    else
    {
        
        reviewEvents *edeal=[[reviewEvents alloc]initWithNibName:@"reviewEvents_iPad" bundle:nil];
        [self.navigationController pushViewController:edeal animated:YES];
        [edeal release];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"CampusLocation"] !=NULL) {
        locationLabel.text = [defaults objectForKey:@"CampusLocation"];
        strlocation = [defaults objectForKey:@"CampusLocation"];
    }
    
    [self performSelector:@selector(come) withObject:nil afterDelay:0.1];
    CGRect rect = tableService.frame;
    rect.size.height = 0;
    tableService.frame = rect;
    CGRect rect1 = campus.frame;
    rect1.size.height = 0;
    campus.frame = rect1;
}

-(void)come
{
//    UIButton *button1 = [[UIButton alloc] init];
//    button1.frame=CGRectMake(0,0,58,30);
//    button1.titleLabel.font= [UIFont boldSystemFontOfSize:14];
//    [button1 addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
//    [button1 setBackgroundImage:[UIImage imageNamed: @"back1.png"] forState:UIControlStateNormal];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
//    [button1 release];
}

-(IBAction)done:(id)sender
{
//    AdminLogin *ad=[[AdminLogin alloc]init];
//    [self.navigationController pushViewController:ad animated:NO];
//    [ad release];

        [self.navigationController popViewControllerAnimated:YES];

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
            [UIView commitAnimations];
            
            
            
        }
        else {
            btn.selected = YES;
            CGRect rect = campus_TableView.frame;
            rect.size.height = 300;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            campus_TableView.frame = rect;
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
    
    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(00,45,tableView.frame.size.width,01)];
    UIImage *imgFile = [UIImage imageNamed:@"divider.png"];
    [imageView1 setImage:imgFile];
    [cell addSubview:imageView1];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        lbl=[[UILabel alloc]init];
        lbl.frame=CGRectMake(05,0,tableView.frame.size.width, 30);
        lbl.numberOfLines=2;
        lbl.font=[UIFont boldSystemFontOfSize:12.0];
        lbl.text=[arraycampus objectAtIndex:indexPath.row];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
        imageView1.frame = CGRectMake(00,44,tableView.frame.size.width,01);
        
        
    }
    else {
        lbl=[[UILabel alloc]init];
        lbl.frame=CGRectMake(0,0,tableView.frame.size.width, 60);
        lbl.numberOfLines=2;
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font=[UIFont boldSystemFontOfSize:18.0];
        lbl.text=[arraycampus objectAtIndex:indexPath.row];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
       imageView1.frame = CGRectMake(00,59,tableView.frame.size.width,01);

        
    }
    
    [imageView1 release];

    
        
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    strlocation=[arraycampus objectAtIndex:indexPath.row];
  //  NSLog(@"%@",strlocation);
    locationLabel.text = strlocation;

    [self showcampus:campusbtn] ;
    
}



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
