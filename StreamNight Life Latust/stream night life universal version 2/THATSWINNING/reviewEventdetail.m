//  reviewEventdetail.m
//  THATSWINNING
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "reviewEventdetail.h"
#import "reviewEvents.h"
#import "DejalActivityView.h"
#import <QuartzCore/QuartzCore.h>
@interface reviewEventdetail ()
@end

@implementation reviewEventdetail

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

    
    [super dealloc];
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.description_TextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.description_TextView.layer.borderWidth = 2.0;
    self.description_TextView.layer.cornerRadius = 10.0;
    
//    NSString *str=[NSString stringWithFormat:@"Date: %@",[EPrice objectAtIndex:beta]];
//    NSString *str1=[NSString stringWithFormat:@"Duration: %@",[EDuration objectAtIndex:beta]];

}

-(void)viewDidAppear:(BOOL)animated {
    if ([self.status isEqualToString:@"0"]) {
        approve_disapporve_Button.selected = NO;
    }
    else if([self.status isEqualToString:@"1"]) {
        approve_disapporve_Button.selected = YES;
    }
    [DejalBezelActivityView activityViewForView:self.imageView];
    [self performSelectorInBackground:@selector(loadImage) withObject:nil];
    
}
-(void)loadImage {
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURl]]];
    
    if (image) {
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURl]]];

    }
    [DejalBezelActivityView removeViewAnimated:YES];
    
}

//-------json----------------------------

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

-(IBAction)delete:(id)sender
{
  //  NSLog(@"%@",[EId objectAtIndex:beta]);
    
//    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=DeleteEvent&id=%@",[EId objectAtIndex:beta]];
//  //  NSLog(@"%@",strurl);
//    NSURL *url = [[NSURL alloc]initWithString:strurl];
//    responseData = [NSData dataWithContentsOfURL:url];
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//	
//	NSError *error;
//	SBJSON *json = [[SBJSON new] autorelease];
//	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
//	[responseString release];
//
//    
//    NSArray *Serviceid1 = [self getArrayFromJSONDictionary:recievedData forKey:@"message"];
//    
//    ar1 = [[NSMutableArray alloc]initWithArray:Serviceid1];
//    [self touch2:0];
}

-(IBAction)touch2:(id)sender
{
//    if([[ar1 objectAtIndex:0] isEqualToString:@"Deleted"])
//    {
//        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Success" message:@"You have successfully deleted event" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alt show];
//        [alt release];
//    }
}

-(IBAction)GettingServisec1
{
//   // NSLog(@"%@",[EId objectAtIndex:beta]);
//    NSString *statusflag = @"1";
//    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=EditEventStatus&id=%@&status=%@",[EId objectAtIndex:beta],statusflag];
//    //NSLog(@"%@",strurl);
//    NSURL *url = [[NSURL alloc]initWithString:strurl];
//    responseData = [NSData dataWithContentsOfURL:url];
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//	
//	NSError *error;
//	SBJSON *json = [[SBJSON new] autorelease];
//	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
//	[responseString release];
//	
//    NSArray *Serviceid1 = [self getArrayFromJSONDictionary:recievedData forKey:@"message"];
//    
//    ar = [[NSMutableArray alloc]initWithArray:Serviceid1];
//    [self touch1:0];
}

-(IBAction)touch1:(id)sender
{
//    if([[ar objectAtIndex:0] isEqualToString:@"Approved"])
//    {
//        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Success" message:@"You have successfully approved event" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alt show];
//        [alt release];
//    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self performSelector:@selector(come) withObject:nil afterDelay:0.1];
}

-(void)come
{
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,58,30);
    button1.titleLabel.font= [UIFont boldSystemFontOfSize:14];
    [button1 addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed: @"back1.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 release];
}

-(IBAction)done:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(IBAction)onClickApprove_Button:(id)sender {

    
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        NSString *statusflag = @"0";
        NSString *strurl;
        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=EditEventStatus&id=%@&status=%@",self.idstr,statusflag];
        
        NSURL *url = [[NSURL alloc]initWithString:strurl];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
        NSDictionary *recievedData = [json objectWithString:responseString error:&error];
        if ([[recievedData objectForKey:@"message"] isEqualToString:@"Update Successful"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disapproved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            btn.selected = YES;
        }
        [responseString release];
        btn.selected = NO;
        
    }
    else {
        NSString *statusflag = @"1";
        NSString *strurl;
        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=EditEventStatus&id=%@&status=%@",self.idstr,statusflag];
        
        NSURL *url = [[NSURL alloc]initWithString:strurl];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
        NSDictionary *recievedData = [json objectWithString:responseString error:&error];
        if ([[recievedData objectForKey:@"message"] isEqualToString:@"Update Successful"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Approved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            btn.selected = YES;
        }
        [responseString release];
    }

}
-(IBAction)onClickDelete_Button:(id)sender {
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=DeleteEvent&id=%@",self.idstr];
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    if ([[recievedData objectForKey:@"message"] isEqualToString:@"Deleted"]) {

        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Success" message:@"You have successfully deleted event" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alt show];
        [alt release];
        [self.navigationController popViewControllerAnimated:YES];

    }
    else {
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to delete the event" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       [alt show];
       [alt release];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
