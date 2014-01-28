//  reviewEvents.m
//  THATSWINNING
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "reviewEvents.h"
#import "reviewEventdetail.h"
#import "applicationManager.h"
#import "DejalActivityView.h"
#import <QuartzCore/QuartzCore.h>

@interface reviewEvents ()
@end

@implementation reviewEvents

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

-(void)dealloc
{
    [tablenight release];
    [lbl release];
    [loc release];
    [bag release];
   // [responseData release];
    [super dealloc];
}

-(void)removeActivity
{
    [DejalBezelActivityView removeViewAnimated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [DejalBezelActivityView activityViewForView:bag];
    [self performSelector:@selector(removeActivity) withObject:nil afterDelay:1.0];
    
    loc=[[NSMutableArray alloc]initWithObjects:@"Event 1",@"Event 2",@"Event 3" ,nil];
    
    [self updatetable];
    tablenight.layer.cornerRadius = 10.0;
    tablenight.layer.borderColor = [UIColor darkGrayColor].CGColor;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {

        tablenight.layer.borderWidth = 2.0;
    }
    else
    {

        tablenight.layer.borderWidth = 5.0;
    }
}

-(void)updatetable
{
    //tablenight = [[UITableView alloc] initWithFrame:CGRectMake(02,05,280,360) style:UITableViewStylePlain];
    //tablenight.delegate = self;
    //tablenight.dataSource = self;
    tablenight.separatorStyle=NO;
    tablenight.backgroundColor = [UIColor clearColor];
    //[bag addSubview:tablenight];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        return 40;
    }
    else
    {
        
        return 70;
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [title_Array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
	}
	else
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
	}
    /*
    UIImageView * imageView2 = [[UIImageView alloc] init];
 	UIImage *imgFile1 = [UIImage imageNamed:@"go.png"];
 	[imageView2 setImage:imgFile1];
 	[cell addSubview:imageView2];
    [imageView2 release];
    */
    UIImageView *imageView2;
     if ([[status_Array objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
       imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redImage.png"]];
     imageView2.frame = CGRectMake(cell.bounds.size.width - 30, (cell.frame.size.height - 20)/2, 20, 20);
     [cell addSubview:imageView2];
     }
     else {
     imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minimize.png"]];
     imageView2.frame = CGRectMake(cell.bounds.size.width - 30, (cell.frame.size.height - 20)/2, 20, 20);
     [cell addSubview:imageView2];
     }

    // */
    UIImageView * imageView1 = [[UIImageView alloc] init];
 	UIImage *imgFile = [UIImage imageNamed:@"divider.png"];
 	[imageView1 setImage:imgFile];
 	[cell addSubview:imageView1];
    [imageView1 release];
    
    cell.textLabel.text =[title_Array objectAtIndex:indexPath.row];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        cell.textLabel.font=[UIFont boldSystemFontOfSize:12.0];
        imageView2.frame=CGRectMake(tableView.frame.size.width - 30,10,15,20);
        imageView1.frame=CGRectMake(02,38,tableView.frame.size.width,02);
    }
    else
    {
        cell.textLabel.font=[UIFont boldSystemFontOfSize:18.0];
        imageView2.frame=CGRectMake(tableView.frame.size.width - 30,25,15,20);
        imageView1.frame=CGRectMake(0,68,tableView.frame.size.width,02);
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    reviewEventdetail *mp;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        mp=[[reviewEventdetail alloc]initWithNibName:@"reviewEventdetail" bundle:nil];
        [self.navigationController pushViewController:mp animated:YES];
    }
    else
    {
        mp=[[reviewEventdetail alloc]initWithNibName:@"reviewEventdetail_iPad" bundle:nil];
        [self.navigationController pushViewController:mp animated:YES];
    }


    mp.idstr = [id_Array objectAtIndex:indexPath.row];
    mp.time_Label.text = [NSString stringWithFormat:@"Time: %@",[time_Array objectAtIndex:indexPath.row]];;
    mp.date_Label.text = [NSString stringWithFormat:@"Date: %@",[date_Array objectAtIndex:indexPath.row]];
    mp.title_Label.text = [title_Array objectAtIndex:indexPath.row];
    mp.category_Label.text = [category_Array objectAtIndex:indexPath.row];
    mp.location_Label.text = [locationArray objectAtIndex:indexPath.row];
    mp.imageURl = [imageURL_Array objectAtIndex:indexPath.row];
    mp.status = [status_Array objectAtIndex:indexPath.row];
    NSLog(@"Desc:=%@",[description_Array objectAtIndex:indexPath.row]);
    mp.description_TextView.text = [description_Array objectAtIndex:indexPath.row];
    
    if (![[day_Array objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        mp.reoccurring_Label.text = [NSString stringWithFormat:@"* Every %@",[day_Array objectAtIndex:indexPath.row]];
    }
    
    beta=indexPath.row;
    [mp release];
}

-(void)GettingServisec
{
    [EId removeAllObjects];
    [EDesc removeAllObjects];
    [ELoc removeAllObjects];
    [EPrice removeAllObjects];
    [EDuration removeAllObjects];
    
    //NSString *strloc = [strlocation stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
   // NSLog(@"%@",strloc);
    
   // NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=ViewApprovedEvents&loc=%@",strloc];
   // NSLog(@"%@",strurl);
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=ViewEvents"];
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	[responseString release];
  //  NSLog(@"%@",recievedData);
	
    description_Array =[[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"Description"]];
    
    id_Array = [[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"ID"]];
    locationArray =[[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"Location"]];
    date_Array = [[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"Date"]];
    time_Array = [[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"Duration"]];
    title_Array = [[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"EventTitle"]];
    imageURL_Array = [[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"Image"]];
    status_Array = [[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"status"]];
    phyLocation_Array = [[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"PhyLocation"]];
    category_Array = [[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"Category"]];
    day_Array = [[NSMutableArray alloc]initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"Day"]];




    [tablenight reloadData];

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
    [DejalBezelActivityView activityViewForView:tablenight];
    [NSThread detachNewThreadSelector:@selector(GettingServisec) toTarget:self withObject:nil];
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
//    applicationManager *app=[[applicationManager alloc]init];
//    [self.navigationController pushViewController:app animated:NO];
//    [app release];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
