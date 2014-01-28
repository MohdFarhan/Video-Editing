//
//  NightNecessitiesApprovalControllerViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 20/05/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "NightNecessitiesApprovalControllerViewController.h"
#import "JSON.h"
#import "AdminGameViewController.h"
#import "AdminPlaceViewController.h"
#import "AdminTipViewController.h"
#import "DejalActivityView.h"
#import <QuartzCore/QuartzCore.h>

@interface NightNecessitiesApprovalControllerViewController ()

@end

@implementation NightNecessitiesApprovalControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tipTable.layer.cornerRadius = 10.0;
    self.tipTable.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.gameTable.layer.cornerRadius = 10.0;
    self.gameTable.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.placeTable.layer.cornerRadius = 10.0;
    self.placeTable.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {


    }
    else
    {
        
        self.tipTable.layer.borderWidth = 5.0;
        self.gameTable.layer.borderWidth = 5.0;
        self.placeTable.layer.borderWidth = 5.0;
    }
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(come) withObject:nil afterDelay:0.1];
    
}
-(void)viewDidAppear:(BOOL)animated {
    [DejalBezelActivityView activityViewForView:self.view];
    [self performSelector:@selector(getTipsFromWebService) withObject:nil afterDelay:0.0];
    [self performSelector:@selector(getGameFromWebService) withObject:nil afterDelay:0.0];
    [self performSelector:@selector(getPlaceFromWebService) withObject:nil afterDelay:0.0];

    
}
-(void)come
{
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,58,30);
    button1.titleLabel.font= [UIFont boldSystemFontOfSize:14];
    [button1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed: @"back1.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
}

-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 0) {
        return [self.ttitle_Array count];
    }
    if(tableView.tag == 1) {
      //  NSLog(@"table 2 %d",[self.gtitle_Array count]);
        return [self.gtitle_Array count];
    }
    if (tableView.tag == 2) {
        return [self.ptitle_Array count];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView1 heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 30;

    }
    else
    {
        return 50;

    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        if ([[self.tstatus_Array objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            UIImageView *statusImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redImage.png"]];
            statusImageView.frame = CGRectMake(cell.bounds.size.width - 30, (cell.frame.size.height - 20)/2, 20, 20);
            [cell addSubview:statusImageView];
        }
        else {
            UIImageView *statusImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minimize.png"]];
            statusImageView.frame = CGRectMake(cell.bounds.size.width - 30, (cell.frame.size.height - 20)/2, 20, 20);
            [cell addSubview:statusImageView];
        }
    }
    else if(tableView.tag == 1) {
        if ([[self.gstatus_Array objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            UIImageView *statusImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redImage.png"]];
            statusImageView.frame = CGRectMake(cell.bounds.size.width - 30, (cell.frame.size.height - 20)/2, 20, 20);
            [cell addSubview:statusImageView];
        }
        else {
            UIImageView *statusImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minimize.png"]];
            statusImageView.frame = CGRectMake(cell.bounds.size.width - 30, (cell.frame.size.height - 20)/2, 20, 20);
            [cell addSubview:statusImageView];
        }
    }
   else if (tableView.tag == 2) {
        if ([[self.pstatus_Array objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            UIImageView *statusImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redImage.png"]];
            statusImageView.frame = CGRectMake(cell.bounds.size.width - 30, (cell.frame.size.height - 20)/2, 20, 20);
            [cell addSubview:statusImageView];
        }
        else {
            UIImageView *statusImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minimize.png"]];
            statusImageView.frame = CGRectMake(cell.bounds.size.width - 30, (cell.frame.size.height - 20)/2, 20, 20);
            [cell addSubview:statusImageView];
        }
    }

    
}
//redImage.png
//minimize.png
- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:MyIdentifier];
    // if (cell == nil)
    // {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    //}
    
    if (tableView1.tag == 0) {

        cell.textLabel.text = [[self.ttitle_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
    }
    else if(tableView1.tag == 1) {

        cell.textLabel.text = [[self.gtitle_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];

    }
    else if (tableView1.tag == 2) {

        cell.textLabel.text = [[self.ptitle_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];

    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    else {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        AdminTipViewController *viewController;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            viewController = [[AdminTipViewController alloc] initWithNibName:@"AdminTipViewController" bundle:nil];
        }
        else
        {
            viewController = [[AdminTipViewController alloc] initWithNibName:@"AdminTipViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:viewController animated:YES];
        viewController.title_Label.text = [[self.ttitle_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.Category_Label.text = [[self.tcategory_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.description_TextView.text = [[self.tdescription_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.status = [[self.tstatus_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.tip_id = [[self.tid_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.location_Label.text = [[self.tlocation_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];

        viewController.necessitiescategory = @"Student Tips";

    }
    if(tableView.tag == 1) {
        AdminGameViewController *viewController;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            viewController = [[AdminGameViewController alloc] initWithNibName:@"AdminGameViewController" bundle:nil];
        }
        else
        {
            viewController = [[AdminGameViewController alloc] initWithNibName:@"AdminGameViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:viewController animated:YES];
        viewController.title_Label.text = [[self.gtitle_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.instruction_TextView.text = [[self.gdescription_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.Category_Label.text = [[self.gcategory_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.status = [[self.gstatus_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.game_id = [[self.gid_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.urlString = [self.gimageURL_Array objectAtIndex:indexPath.row];

        viewController.necessitiescategory = @"Drinking Games";

    }
    if (tableView.tag == 2) {
        AdminPlaceViewController *viewController;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            viewController = [[AdminPlaceViewController alloc] initWithNibName:@"AdminPlaceViewController" bundle:nil];
        }
        else
        {
            viewController = [[AdminPlaceViewController alloc] initWithNibName:@"AdminPlaceViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:viewController animated:YES];
        viewController.title_Label.text = [[self.ptitle_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.Category_Label.text = [[self.pcategory_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.open_Label.text = [[self.phour_operation_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.description_TextView.text = [[self.pdescription_Array objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        viewController.status = [self.pstatus_Array objectAtIndex:indexPath.row];
        viewController.place_id = [self.pid_Array objectAtIndex:indexPath.row];
        viewController.urlString = [self.pimageURL_Array objectAtIndex:indexPath.row];
        viewController.location_Label.text = [self.plocation_Array objectAtIndex:indexPath.row];
        viewController.necessitiescategory = @"Places To Go";

    }
}

-(void)getTipsFromWebService {
    NSString *strurl;
    strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=StudentTip"];
    
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [SBJSON new] ;
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    
    self.tid_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"stip_id"]];
    self.tsid_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"sid"]];
    self.ttitle_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"title"]];
    self.tcategory_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"category"]];
    self.tdescription_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"description"]];
    self.tstatus_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"tip_status"]];
    self.tlocation_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"campus_location"]];

    if ([self.ttitle_Array count]) {
        [self.tipTable reloadData];

    }
    
}
-(void)getGameFromWebService {
    NSString *strurl;
    
    strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=GameDetails"];
    
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [SBJSON new] ;
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    
    
    self.gid_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_id"]];
    self.gsid_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"sid"]];
    self.gtitle_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_name"]];
    self.gcategory_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_category"]];
    self.gdescription_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_instruction"]];
    self.gimageURL_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_img"]];
    self.gstatus_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_status"]];
    if ([self.gtitle_Array count]) {
        [self.gameTable reloadData];

    }

    
}
-(void)getPlaceFromWebService {
    NSString *strurl;
    
    strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=PlacetoGoData"];
    
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [SBJSON new] ;
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    
    
    self.pid_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_id"]];
    self.psid_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"sid"]];
    self.ptitle_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_name"]];
    self.phour_operation_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"hour_operation"]];
    self.paddress_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"phy_address"]];
    self.pcategory_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_category"]];
    self.pdescription_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_description"]];
    self.pimageURL_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_image"]];
    self.pstatus_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_status"]];
    self.plocation_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"campus_location"]];
    if ([self.ptitle_Array count]) {
        [self.placeTable reloadData];

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
        return [[NSArray alloc] init] ;
    }
    NSArray *ret = [NSArray arrayWithObject:obj];
    return ret;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
