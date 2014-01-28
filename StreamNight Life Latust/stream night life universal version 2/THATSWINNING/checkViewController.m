//
//  checkViewController.m
//  Stream Night Life
//
//  Created by Farhan Khan on 1/16/14.
//  Copyright (c) 2014 Smoketech. All rights reserved.
//

#import "checkViewController.h"


#import "applicationManager.h"
#import "ViewController.h"

@interface checkViewController ()
@end

@implementation checkViewController

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
    [ar release];
    [bid release];
    [super dealloc];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	if (textField == name)
	{
		[UIView beginAnimations:nil context:NULL];
		//[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y -= 100;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
    else if (textField == pass)
	{
		[UIView beginAnimations:nil context:NULL];
		//[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y -= 100;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField
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

-(IBAction)movetoManager:(id)sender
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
        [self GettingServisec];
        //  NSLog(@"%@",[bid objectAtIndex:0]);
        if([bid count])
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[bid objectAtIndex:0] forKey:@"BID"];
            [defaults synchronize];
        }
        if([[ar objectAtIndex:0] isEqualToString:@"Success"])
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"admin" forKey:@"admin"];
            [defaults synchronize];
            
            
            name.text=nil;
            pass.text=nil;
            
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
            UIAlertView *selectvalue=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Username/Password Incorrect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [selectvalue show];
            [selectvalue release];
        }
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)GettingServisec
{
    NSString *strName=name.text;
    NSString *strPass=pass.text;
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=A_Login&uname=%@&password=%@",strName,strPass];
    // NSLog(@"%@",strurl);
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
	//NSLog(@"%@",recievedData);
    
    NSArray *Serviceid3 = [self getArrayFromJSONDictionary:recievedData forKey:@"message"];
    NSArray *Serviceid2 = [self getArrayFromJSONDictionary:recievedData forKey:@"ID"];
    
    ar = [[NSMutableArray alloc]initWithArray:Serviceid3];
    bid = [[NSMutableArray alloc]initWithArray:Serviceid2];
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
    // [self performSelector:@selector(come) withObject:nil afterDelay:0.1];
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
    //    ViewController *vew=[[ViewController alloc]init];
    //    [self.navigationController pushViewController:vew animated:NO];
    //    [vew release];
}

-(void)didReceiveMemoryWarning
{
    NSLog(@"Memory warning");
    [super didReceiveMemoryWarning];
}

@end
