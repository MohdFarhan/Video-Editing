//  Settings.m
//  THATSWINNING
//  Created by Guramrit on 23/02/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "Settings.h"
#import "applicationManager.h"

@interface Settings ()
@end

@implementation Settings

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

-(IBAction)moveToSettings:(id)sender
{
//    applicationManager *set=[[applicationManager alloc]init];
//    [self.navigationController pushViewController:set animated:NO];
//    [set release];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton=YES;
}

-(IBAction)ChangeUsername:(id)sender
{
    str=@"Username";
    UIAlertView *message1 = [[UIAlertView alloc] initWithTitle:@"Enter the new Username" message:@"        " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
	text1.placeholder=@" ";
	
	text2=[[UITextField alloc]initWithFrame:CGRectMake(12.0, 45.0, 260.0, 26.0)];
	[text2 setBackgroundColor:[UIColor whiteColor]];
    text2.textAlignment=UITextAlignmentCenter;
    text2.autocorrectionType=UITextAutocorrectionTypeNo;
	text2.delegate=self;
	[message1 addSubview:text2 ];
	[message1 show];
}

-(IBAction)ChangePassword:(id)sender
{
    str=@"password";
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enter the new password" message:@"        " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
	text1.placeholder=@" ";
	
	text1=[[UITextField alloc]initWithFrame:CGRectMake(12.0, 45.0, 260.0, 26.0)];
	[text1 setBackgroundColor:[UIColor whiteColor]];
    text1.textAlignment=UITextAlignmentCenter;
    text1.autocorrectionType=UITextAutocorrectionTypeNo;
	text1.delegate=self;
	[message addSubview:text1];
	[message show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([str isEqualToString:@"Username"])
    {
        if(buttonIndex==0)
        {
            if( [text2.text length]<=0 )
            {
                UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please enter username" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alt show];
                [alt release];
            }
            else
            {
                [self GettingServisec1];
                [self done2:0];
            }
        }
    }
    else
    {
        if(buttonIndex==0)
        {
            if( [text1.text length]<=0 )
            {
                UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter Username" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alt show];
                [alt release];
            }
            else
            {
                [self GettingServisec];
                [self done1:0];
            }
        }
    }
}

//=====-----------------password==================
-(void)GettingServisec//Password======
{
    [ar removeAllObjects];
    NSString *strloc = [text1.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strS=[defaults objectForKey:@"BID"];
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=ChangePassword&uid=%@&password=%@",strS,strloc];
    // NSLog(@"%@",strurl);
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
    // NSLog(@"%@",recievedData);
	
    NSArray *ar2 =[self getArrayFromJSONDictionary:recievedData forKey:@"message"];
    ar = [[NSMutableArray alloc]initWithArray:ar2];
}

-(IBAction)done1:(id)sender//password
{
    //    NSLog(@"%d",phase);
    if([[ar objectAtIndex:0] isEqualToString:@"Success"])
    {
        phase=0;
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Successfully Changed password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alt show];
        [alt release];
    }
}

//-----------------Username=============================

-(void)GettingServisec1//USername
{
    [ar1 removeAllObjects];
    NSString *strloc = [text2.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strP=[defaults objectForKey:@"BID"];
    
    //http://www.thatswinning.com/traker/?action=ChangeUserName&uid=%@&uname=%@
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=ChangeUserName&uid=%@&uname=%@",strP,strloc];
    // NSLog(@"%@",strurl);
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
    // NSLog(@"%@",recievedData);
	
    NSArray *ar2 =[self getArrayFromJSONDictionary:recievedData forKey:@"message"];
    ar1 = [[NSMutableArray alloc]initWithArray:ar2];
}



-(IBAction)done2:(id)sender//username
{
    //    NSLog(@"%d",phase);
    if([[ar1 objectAtIndex:0] isEqualToString:@"Success"])
    {
        phase=0;
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Successfully changed username" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alt show];
        [alt release];
    }
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

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
