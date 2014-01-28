//  AddComplaintViewController.m
//  THATSWINNING
//  Created by Mohit on 02/03/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "AddComplaintViewController.h"
#import "about.h"
#import "DejalActivityView.h"
#import "Header.h"

@interface AddComplaintViewController ()
@end

@implementation AddComplaintViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (textView == txt)
        {
            txt.frame=CGRectMake(34, 54, 253, 85);
            Img.frame=CGRectMake(26, 48, 268, 99);
            AddBut.frame=CGRectMake(88, 150, 140, 44);
        }
    }
    else {
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (textView == txt)
        {
            txt.frame=CGRectMake(34, 79, 253, 248);
            Img.frame=CGRectMake(26, 73, 268, 261);
            AddBut.frame=CGRectMake(88, 357, 140, 44);
        }
    }
    else {
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)viewDidLoad
{
    ar=[[NSMutableArray alloc]init];
    [super viewDidLoad];
}

-(IBAction)AddComp:(id)sender
{
    
    [txt resignFirstResponder];
    if( [txt.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill Complaint" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Adding..."];
        [self performSelector:@selector(GettingServisec) withObject:nil afterDelay:0.0];
    }
}

-(void)GettingServisec
{
    NSString *strName = [txt.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
   // NSLog(@"%@",strName);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *str= [defaults objectForKey:@"studentID"];
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=Complaint&d_id=%@&msg=%@",str,strName];
  //  NSLog(@"%@",strurl);
 
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
 //   NSLog(@"%@",recievedData);
    
    NSArray *Serviceid2 = [self getArrayFromJSONDictionary:recievedData forKey:@"message"];
    ar = [[NSMutableArray alloc]initWithArray:Serviceid2];
    
    if([[ar objectAtIndex:0] isEqualToString:@"Success"])
    {
        UIAlertView *puff=[[UIAlertView alloc]initWithTitle:@"Success" message:@"You have successfully added Complaint" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [puff show];
        [puff release];
        txt.text=nil;
    }
    else if([[ar objectAtIndex:0] isEqualToString:@"User not exist"])
    {
        UIAlertView *puff=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Login as student to complaint" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [puff show];
        [puff release];
    }
    [DejalBezelActivityView removeViewAnimated:YES];
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
