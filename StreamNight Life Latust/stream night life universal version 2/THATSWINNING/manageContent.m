//  manageContent.m
//  THATSWINNING
//  Created by Mohit on 22/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "manageContent.h"
#import "compDetail.h"
#import "applicationManager.h"
#import "DejalActivityView.h"

@interface manageContent ()
@end

@implementation manageContent

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
    [bag release];
    [bag1 release];
    [bag2 release];
    [tablenight release];
    
    [tablenight1 release];
    [showBusiTable release];
    [lbl release];
    [loc release];
    
    [comp release];
    [closeButton release];
    [scrollbtn release];
    [done release];
    [status release];
    [super dealloc];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    loc=[[NSMutableArray alloc]initWithObjects:@"User 1",@"User 2",@"User 3",nil];
    comp=[[NSMutableArray alloc]initWithObjects:@"Complaint 1",@"Complaint 2",nil];

    userName=[[NSMutableArray alloc]init];
    userID=[[NSMutableArray alloc]init];
    userTable=[[NSMutableArray alloc]init];
    done=[[NSMutableArray alloc]init];
    showBusiArray=[[NSMutableArray alloc]init];
    showBusiArray1=[[NSMutableArray alloc]init];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self updatetable];
        [self updatetable1];
    }
    else {
        
    }
    

}

-(void)updatetable
{
        tablenight = [[UITableView alloc] initWithFrame:CGRectMake(02,02,238,161) style:UITableViewStylePlain];
        showBusiTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        tablenight.delegate = self;
        tablenight.dataSource = self;
        tablenight.separatorStyle=NO;
        tablenight.backgroundColor = [UIColor clearColor];
        [bag addSubview:tablenight];


}

-(void)updatetable1
{
        tablenight1 = [[UITableView alloc] initWithFrame:CGRectMake(02,02,238,161) style:UITableViewStylePlain];
        tablenight1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        tablenight1.delegate = self;
        tablenight1.dataSource = self;
        tablenight1.separatorStyle=NO;
        tablenight1.backgroundColor = [UIColor clearColor];
        [bag1 addSubview:tablenight1];


}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 40;
    }
    else {
        return 50;

        
    }

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tablenight)
    {
        return [compArray count];
    }
    else if(tableView==tablenight1)
    {
        return [userName count];
    }
    else
    {
        return [showBusiArray count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tablenight)
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
        UIImageView *imageView2  = [[UIImageView alloc] init];
        UIImage *imgFile1 = [UIImage imageNamed:@"go.png"];
        [imageView2 setImage:imgFile1];
        [cell addSubview:imageView2];
        [imageView2 release];
        
        UIImageView *imageView1  = [[UIImageView alloc] init];
        UIImage *imgFile = [UIImage imageNamed:@"divider.png"];
        [imageView1 setImage:imgFile];
        [cell addSubview:imageView1];
        [imageView1 release];
        @try
        {
            cell.textLabel.text = [compArray objectAtIndex:indexPath.row];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                cell.textLabel.font=[UIFont boldSystemFontOfSize:13.0];
                imageView2.frame = CGRectMake(tablenight.frame.size.width - 20,10,15,20);
                imageView1.frame = CGRectMake(0,38,tablenight.frame.size.width,02);
            }
            else {
                cell.textLabel.font=[UIFont boldSystemFontOfSize:15.0];
                imageView2.frame = CGRectMake(tablenight.frame.size.width - 30,15,15,20);
                imageView1.frame = CGRectMake(0,48,tablenight.frame.size.width,02);
            }

        }
        @catch (NSException *exception)
        {
            NSLog(@"%@",exception);
        }
        return cell;
    }
    else if(tableView==tablenight1)
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
        
        
        UIImageView * imageView2 = [[UIImageView alloc] init];
        UIImage *imgFile1;
        if([[status objectAtIndex:indexPath.row] isEqualToString:@"0"])
        {
            imgFile1 = [UIImage imageNamed:@"redImage.png"];
        }
        else
        {
            imgFile1 = [UIImage imageNamed:@"minimize.png"];
        }
        [imageView2 setImage:imgFile1];
        [cell addSubview:imageView2];
        [imageView2 release];
        
        UIImageView * imageView1 = [[UIImageView alloc] init];
        UIImage *imgFile = [UIImage imageNamed:@"divider.png"];
        [imageView1 setImage:imgFile];
        [cell addSubview:imageView1];
        [imageView1 release];
        
        @try
        {
            cell.textLabel.text = [userName objectAtIndex:indexPath.row];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                cell.textLabel.font=[UIFont boldSystemFontOfSize:13.0];
                imageView2.frame = CGRectMake(tablenight1.frame.size.width - 40,5,25,25);
                imageView1.frame = CGRectMake(0,38,tablenight.frame.size.width,02);
            }
            else {
                cell.textLabel.font=[UIFont boldSystemFontOfSize:15.0];
                imageView2.frame = CGRectMake(tablenight1.frame.size.width - 40,12,25,25);
                imageView1.frame = CGRectMake(0,48,tablenight.frame.size.width,02);
            }
            
        }
        @catch (NSException *exception)
        {
            NSLog(@"%@",exception);
        }
        
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tablenight)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            compDetail *mp=[[compDetail alloc]initWithNibName:@"compDetail" bundle:nil];
            pug=indexPath.row;
            [self.navigationController pushViewController:mp animated:YES];
            [mp release];
        }
        else {
            compDetail *mp=[[compDetail alloc]initWithNibName:@"compDetail_iPad" bundle:nil];
            pug=indexPath.row;
            [self.navigationController pushViewController:mp animated:YES];
            [mp release];
        }

    }
    else if(tableView==tablenight1)
    {
        pup=indexPath.row;
        if([[status objectAtIndex:indexPath.row] isEqualToString:@"0"])
        {
            [self GettingServisec3];
        }
        else
        {
            [self GettingServisec2];
        }
    }

}

-(IBAction)showBusiMathod:(id)sender
{
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=BlockUsers"];
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
    
     NSDictionary *StudentData=[recievedData objectForKey:@"Business"];
    
    NSArray *Serviceid1 = [self getArrayFromJSONDictionary:StudentData forKey:@"Business_m"];
    NSArray *Serviceid2 = [self getArrayFromJSONDictionary:StudentData forKey:@"Hours_of_operation"];
    NSArray *Serviceid3 = [self getArrayFromJSONDictionary:StudentData forKey:@"ID"];
    NSArray *Serviceid4 = [self getArrayFromJSONDictionary:StudentData forKey:@"Business"];
    NSArray *Serviceid5 = [self getArrayFromJSONDictionary:StudentData forKey:@"Contact"];
    NSArray *Serviceid6 = [self getArrayFromJSONDictionary:StudentData forKey:@"UserName"];
    NSArray *Serviceid7 = [self getArrayFromJSONDictionary:StudentData forKey:@"PhysicalAddress"];
    
    showBusiArray = [[NSMutableArray alloc]initWithArray:Serviceid1];
    showBusiArray1 = [[NSMutableArray alloc]initWithArray:Serviceid2];
    showBusiArray2= [[NSMutableArray alloc]initWithArray:Serviceid3];
    
    showbee3= [[NSMutableArray alloc]initWithArray:Serviceid4];
    showbee4= [[NSMutableArray alloc]initWithArray:Serviceid5];
    showbee5= [[NSMutableArray alloc]initWithArray:Serviceid6];
    showbee6= [[NSMutableArray alloc]initWithArray:Serviceid7];
        
    [showBusiTable reloadData];
    
}

-(IBAction)touch3:(id)sender
{
    if([[showBusiArray objectAtIndex:0] isEqualToString:@"Blocked"])
    {
        NSString *str=[NSString stringWithFormat:@"You have successfully Blocked %@",[userName objectAtIndex:pup]];
        
        [NSThread detachNewThreadSelector:@selector(GettingServisec) toTarget:self withObject:nil];
        
        UIAlertView *puff=[[UIAlertView alloc]initWithTitle:@"Success" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [puff show];
        [puff release];
    }
}

-(IBAction)GettingServisec2
{
    [done removeAllObjects];
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=block&id=%@&tbl=student",[userID objectAtIndex:pup]];

    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
	
    NSArray *Serviceid1 = [self getArrayFromJSONDictionary:recievedData forKey:@"message"];
    
    done = [[NSMutableArray alloc]initWithArray:Serviceid1];
    [self touch2:0];
}

-(IBAction)GettingServisec3
{
    [done removeAllObjects];
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=Unblock&id=%@&tbl=student",[userID objectAtIndex:pup]];
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
    
    NSArray *Serviceid1 = [self getArrayFromJSONDictionary:recievedData forKey:@"message"];
    
    done = [[NSMutableArray alloc]initWithArray:Serviceid1];
    [self touch2:0];
}

-(IBAction)touch2:(id)sender
{
    if([[done objectAtIndex:0] isEqualToString:@"Blocked"])
    {
         NSString *str=[NSString stringWithFormat:@"You have successfully Blocked %@",[userName objectAtIndex:pup]];
        
        [NSThread detachNewThreadSelector:@selector(GettingServisec) toTarget:self withObject:nil];
        
        UIAlertView *puff=[[UIAlertView alloc]initWithTitle:@"Success" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [puff show];
        [puff release];
    }
    else if([[done objectAtIndex:0] isEqualToString:@"Unblocked"])
    {
        NSString *str=[NSString stringWithFormat:@"You have successfully Unblocked %@",[userName objectAtIndex:pup]];
        
        [NSThread detachNewThreadSelector:@selector(GettingServisec) toTarget:self withObject:nil];
        
        UIAlertView *puff=[[UIAlertView alloc]initWithTitle:@"Success" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [puff show];
        [puff release];
    }
    [tablenight1 reloadData];
}

//----------------------json----------------------------

-(void)GettingServisec
{
    [userID removeAllObjects];
    [userName removeAllObjects];
    [userTable removeAllObjects];
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=users"];
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
    
    NSDictionary *StudentData=[recievedData objectForKey:@"Student"];
    
    NSArray *ar =[self getArrayFromJSONDictionary:StudentData forKey:@"ID"];
    NSArray *Serviceid = [self getArrayFromJSONDictionary:StudentData forKey:@"Name"];
    NSArray *ar1 =[self getArrayFromJSONDictionary:StudentData forKey:@"Table"];
    NSArray *Serviceid4 = [self getArrayFromJSONDictionary:StudentData forKey:@"Status"];

    userID = [[NSMutableArray alloc]initWithArray:ar];
    userName = [[NSMutableArray alloc]initWithArray:Serviceid];
    userTable = [[NSMutableArray alloc]initWithArray:ar1];
    status= [[NSMutableArray alloc]initWithArray:Serviceid4];

    [tablenight1 reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
}

-(void)complaintMethod
{
    [compArray removeAllObjects];
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=ComplaintView"];
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
        
    NSArray *ar =[self getArrayFromJSONDictionary:recievedData forKey:@"Text"];
 
    compArray= [[NSMutableArray alloc]initWithArray:ar];
    
    [tablenight reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
}


-(NSArray *) getArrayFromJSONDictionary:(NSDictionary *)parent forKey:(NSString *)key {
    id obj = [parent valueForKeyPath:key];
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
        [DejalBezelActivityView activityViewForView:self.view];
    [NSThread detachNewThreadSelector:@selector(GettingServisec) toTarget:self withObject:nil];
    //[NSThread detachNewThreadSelector:@selector(showBusiMathod:) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(complaintMethod) toTarget:self withObject:nil];
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