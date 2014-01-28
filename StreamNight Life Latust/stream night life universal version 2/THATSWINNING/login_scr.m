//  login_scr.m
//  THATSWINNING
//  Created by Mohit on 22/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "login_scr.h"
#import "ViewController.h"

@interface login_scr ()
@end

@implementation login_scr
@synthesize str;

-(void)dealloc
{
//    [responseData release];
    [str release];
    [ar release];
    [ar1 release];
    [lbl release];
    [name release];
    [pass release];
    [top release];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	if (textField == name)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y -= 100;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
    else if(textField == pass)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y -= 100;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
	if (textField == name)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y += 100;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
    else if (textField == pass)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y += 100;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    


}

-(IBAction)check:(id)sender
{
    if([str isEqualToString:@"User Login"])
    {
        [self moveToUserManager:0];
    }

}


-(IBAction)moveToUserManager:(id)sender
{
    [name resignFirstResponder];
    [pass resignFirstResponder];
    
    if( [name.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if( [pass.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [self GettingServisec1];
        if([[ar1 objectAtIndex:0] isEqualToString:@"Success"])
        {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"Student" forKey:@"Slogin_name"];
            [defaults setObject:[studentID objectAtIndex:0] forKey:@"studentID"];
            [defaults synchronize];

            name.text=nil;
            pass.text=nil;
            
            [self.navigationController popViewControllerAnimated:YES];

        }
        else if([[ar1 objectAtIndex:0] isEqualToString:@"No User Found"])
        {
            UIAlertView *selectvalue=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No User Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [selectvalue show];
            [selectvalue release];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)GettingServisec
{
    NSString *strName=name.text;
    NSString *strPass=pass.text;
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=B_Login&uname=%@&password=%@",strName,strPass];
   // NSLog(@"%@",strurl);
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    NSLog(@"%@",recievedData);
	//[responseString release];
	
    NSArray *Serviceid1 = [self getArrayFromJSONDictionary:recievedData forKey:@"message"];
    //NSArray *Serviceid2 = [self getArrayFromJSONDictionary:recievedData forKey:@"ID"];

    ar = [[NSMutableArray alloc]initWithArray:Serviceid1];
}

-(void)GettingServisec1
{
    NSString *strName=name.text;
    NSString *strPass=pass.text;
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=S_Login&uname=%@&password=%@",strName,strPass];
   // NSLog(@"%@",strurl);
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
//	NSLog(@"%@",recievedData);
    
    NSArray *Serviceid1 = [self getArrayFromJSONDictionary:recievedData forKey:@"message"];
    NSArray *Serviceid12 = [self getArrayFromJSONDictionary:recievedData forKey:@"ID"];

    ar1 = [[NSMutableArray alloc]initWithArray:Serviceid1];
    studentID=[[NSMutableArray alloc]initWithArray:Serviceid12];
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
