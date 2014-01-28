//
//  normalAccount.m
//  THATSWINNING
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "normalAccount.h"
#import "ViewController.h"

@interface normalAccount ()
@end

@implementation normalAccount

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
	if (textField == school)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y -= 100;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
    else if (textField == username)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y -= 100;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}

    else if (textField == password)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y -= 140;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == school)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y += 100;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
    else if (textField == username)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y += 100;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
    else if (textField == password)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [self.view frame];
		rect.origin.y += 140;
		[self.view setFrame:rect];
		[UIView commitAnimations];
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewDidLoad
{
    [super viewDidLoad];


       
    arraycampus=[[NSMutableArray alloc]initWithObjects:@"Eau Claire, Wisconsin",@"Menomonie, Wisconsin",@"River Falls, Wisconsin",@"Milwaukee, Wisconsin", @"Madison, Wisconsin", nil];
    
    
    
    
  //  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self updatetable];
              
        
   // }
//    else {
//        campus_TableView.layer.cornerRadius = 10.0;
//    }
//    
//    [b1 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
//    [b2 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
//    [b3 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if ([defaults objectForKey:@"Slogin_name"] !=NULL) {
//        [b3 setTitle:@"Sign Out" forState:UIControlStateNormal];
//    }
//    else {
//        [b3 setTitle:@"Sign In" forState:UIControlStateNormal];
//    }
//    
//    
//    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//    NSString *key = [userdefault objectForKey:@"WelcomeNote"];
//    if (!key) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Smart move downloading. Select your campus, sign up, and then browse and share the ways to have fun. By clicking ok you agree to our terms and conditions on our site www.streamnightlife.com. Enjoy! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        alert.tag = 11;
//        [alert show];
//    }
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        UIImage *backgroundImage = [UIImage imageNamed:@"topBanner_iPad.png"];
//        
//        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 44)];
//        [bgView setImage:backgroundImage];
//        
//        [self.navigationController.navigationBar insertSubview:bgView atIndex:1];
//        [bgView release];
//        
//    }
//    else {
//        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
//        // NSLog(@"%f",version);
//        UIImage *backgroundImage = [UIImage imageNamed:@"banner.png"];
//        if (version >= 5.0) {
//            [[UINavigationBar appearance] setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
//        }
//        else
//        {
//            [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:backgroundImage] autorelease] atIndex:1];
//        }
//    }


}
-(void)updatetable
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
      
              tableService = [[UITableView alloc] initWithFrame:CGRectMake(15,30,400,550) style:UITableViewStylePlain];
              
          }
    else{
    tableService = [[UITableView alloc] initWithFrame:CGRectMake(15,30,170,235) style:UITableViewStylePlain];
    }
    tableService.delegate = self;
    tableService.dataSource = self;
    tableService.separatorStyle=NO;
    tableService.scrollEnabled=NO;
    tableService.userInteractionEnabled=YES;
    tableService.backgroundColor = [UIColor clearColor];
    [campus addSubview:tableService];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 40;
        
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
       UILabel *lbl=[[[UILabel alloc]init] autorelease];
        lbl.frame=CGRectMake(05,0,tableView.frame.size.width, 30);
        lbl.numberOfLines=2;
        lbl.font=[UIFont boldSystemFontOfSize:12.0];
        lbl.text=[arraycampus objectAtIndex:indexPath.row];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(00,39,tableView.frame.size.width,01)];
        UIImage *imgFile = [UIImage imageNamed:@"divider.png"];
        [imageView1 setImage:imgFile];
        [cell addSubview:imageView1];
        [imageView1 release];
        
    }
    else {
       UILabel *lbl=[[[UILabel alloc]init] autorelease];
        lbl.frame=CGRectMake(0,20,tableView.frame.size.width, 60);
        lbl.numberOfLines=2;
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font=[UIFont boldSystemFontOfSize:18.0];
        lbl.text=[arraycampus objectAtIndex:indexPath.row];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10,59,tableView.frame.size.width,01)];
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
    
    school.text = strlocation;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:strlocation forKey:@"CampusLocation"];
    [defaults synchronize];
    [self showcampus:campusbtn] ;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.1];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) 
                      campus.frame=CGRectMake(39,1000,251,264);
    else
        campus.frame=CGRectMake(160,2000,400,550);
     [UIView commitAnimations];
    
}
-(void)GettingServisec
{
    NSString *strName       = [name.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *strSchool     = [school.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *strusername   = [username.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *strPass       = [password.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strID       = [defaults objectForKey:@"DatabaseID"] ;
    if(!strID)
        strID=@"0";
    
    strID       = [[defaults objectForKey:@"DatabaseID"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=S_Registration&name=%@&school=%@&uname=%@&pass=%@&notificationid=%@",strName,strSchool,strusername,strPass,strID];
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
    NSArray *Serviceid12 = [self getArrayFromJSONDictionary:recievedData forKey:@"InsertedID"];
    
    ar = [[NSMutableArray alloc]initWithArray:Serviceid1];
    studentID=[[NSMutableArray alloc]initWithArray:Serviceid12];
    
    //[recievedData release];
/*
 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
 [defaults setObject:[recievedData objectForKey:@"notificationid" ] forKey:@"DatabaseID"];
 
 [defaults synchronize];
 http://www.thatswinning.com/traker/?action=S_Registration&name=xxx&school=triffort&uname=x1&pass=123&notificationid=c515d4a32faa1df6e339aba1887e09e2
 */

    
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
   // NSLog(@"Warning object for key %@ is of type %@",key, [[obj class] description]);
    NSArray *ret = [NSArray arrayWithObject:obj];
    return ret;
}

-(IBAction)signup:(id)sender
{
    [name resignFirstResponder];
    [school resignFirstResponder];
    [username resignFirstResponder];
    [password resignFirstResponder];
    
  //  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
   
    if( [name.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if( [school.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill school" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if( [username.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill username" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if( [password.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [self GettingServisec];
      //  NSLog(@"%@",[ar objectAtIndex:0]);
        if([[ar objectAtIndex:0] isEqualToString:@"Success"])
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"Student" forKey:@"Slogin_name"];
            [defaults setObject:[studentID objectAtIndex:0] forKey:@"studentID"];
            [defaults synchronize];

            
            name.text=nil;
            school.text=nil;
            username.text=nil;
            password.text=nil;

            UIAlertView *selectvalue=[[UIAlertView alloc]initWithTitle:@"Success" message:@"You have successfully registered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [selectvalue show];
            [selectvalue release];
          
        }
        else if([[ar objectAtIndex:0] isEqualToString:@"Username already exists"])
        {
            UIAlertView *selectvalue=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Username Already Exists" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [selectvalue show];
            [selectvalue release];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
//    if (buttonIndex==alertView.cancelButtonIndex)
//    {
//        ViewController *deal=[[ViewController alloc]init];
//        [self.navigationController pushViewController:deal animated:YES];
//        [deal release];
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)showcampus:(id)sender
{
    //*name,*school,*username,*password;
    if([name isFirstResponder]){
        [name resignFirstResponder];
    }
    else  if([username isFirstResponder]){
        [username resignFirstResponder];
    }
    else  if([password isFirstResponder]){
        [password resignFirstResponder];
    }
   
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:0.1];
            
            campus.frame=CGRectMake(39,180,251,264);

            [UIView commitAnimations];
    
    }
    else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:0.1];
        
        campus.frame=CGRectMake(160,400,500,450);
      
        [UIView commitAnimations];
            }
}

@end
