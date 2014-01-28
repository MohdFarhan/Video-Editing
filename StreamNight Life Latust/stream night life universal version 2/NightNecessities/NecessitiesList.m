//
//  NecessitiesList.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "NecessitiesList.h"
#import "ShareGameViewController.h"
#import "SharePlaceViewController.h"
#import "ShareTipViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "ViewTipViewController.h"
#import "ViewGameViewController.h"
#import "ViewPlaceViewController.h"
#import "DejalActivityView.h"


@interface NecessitiesList ()

@end

@implementation NecessitiesList
@synthesize titleString,dataArray;

-(void)dealloc
{
    

}

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
    title_Label.text = titleString;
    indexArray = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
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
        
        UIImageView *bottomimg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,160,50)];
        bottomimg.image = [UIImage imageNamed:@"bottom-nav.png"];
        [bottomview addSubview:bottomimg];
        
        b1 = [UIButton buttonWithType:UIButtonTypeCustom];
        b1.tag=1;
        [b1 addTarget:self action:@selector(movehome) forControlEvents:UIControlEventTouchUpInside];
        b1.titleLabel.font=[UIFont boldSystemFontOfSize:14.0];
        b1.titleLabel.numberOfLines=2;
        //[b1 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
        [b1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [b1 setTitle:@"Home" forState:UIControlStateNormal];
        b1.frame = CGRectMake(50,07,60,40);
        [bottomview addSubview:b1];
        UIImageView *bottomimg2 = [[UIImageView alloc]initWithFrame:CGRectMake(160,4,160,48)];
        bottomimg2.image = [UIImage imageNamed:@"iphone.png"];
        [bottomview addSubview:bottomimg2];

        b2 = [UIButton buttonWithType:UIButtonTypeCustom];
        b2.tag=2;
        b2.titleLabel.font=[UIFont boldSystemFontOfSize:14.0];
        b2.titleLabel.numberOfLines=2;
        //[b2 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
        [b2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        b2.frame = CGRectMake(160,07,160,40);
        [bottomview addSubview:b2];
    
    }
    else {
            bottomview = [[UIView alloc] initWithFrame:CGRectMake(0,890,self.view.frame.size.width,70)];
  
        bottomview.backgroundColor = [UIColor clearColor];
        [self.view addSubview:bottomview];
        
        UIImageView *bottomimg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width/2,70)];
        bottomimg.image = [UIImage imageNamed:@"bottom-nav.png"];
        [bottomview addSubview:bottomimg];
        
        b1 = [UIButton buttonWithType:UIButtonTypeCustom];
        b1.tag=1;
        [b1 addTarget:self action:@selector(movehome) forControlEvents:UIControlEventTouchUpInside];
        b1.titleLabel.font=[UIFont boldSystemFontOfSize:20.0];
        b1.titleLabel.numberOfLines=2;
       // [b1 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
        [b1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [b1 setTitle:@"Home" forState:UIControlStateNormal];
        b1.frame = CGRectMake(150,17,60,40);
        [bottomview addSubview:b1];
        UIImageView *bottomimg2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2,5,self.view.frame.size.width/2,70)];
        bottomimg2.image = [UIImage imageNamed:@"iphone.png"];
        [bottomview addSubview:bottomimg2];

        
        b2 = [UIButton buttonWithType:UIButtonTypeCustom];
        b2.tag=2;
        b2.titleLabel.font=[UIFont boldSystemFontOfSize:20.0];
        b2.titleLabel.numberOfLines=2;
        //[b2 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
        [b2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        b2.frame = CGRectMake(500,17,160,50);
        [bottomview addSubview:b2];
    }
    
    //Bottom-----------------------------------------------------------
    
    
    
    if ([titleString isEqualToString:@"Student Tips"]) {
        [b2 addTarget:self action:@selector(uploadTips) forControlEvents:UIControlEventTouchUpInside];
        [b2 setTitle:@"Share A Tip" forState:UIControlStateNormal];
        organizeArray = [[NSArray alloc] initWithObjects:@"Most Recent",@"College Related",@"Night Life",@"Romance", nil];
        

    }
    else if([titleString isEqualToString:@"Drinking Games"]) {
        [b2 addTarget:self action:@selector(shareGame) forControlEvents:UIControlEventTouchUpInside];
        [b2 setTitle:@"Share A Game" forState:UIControlStateNormal];
        organizeArray = [[NSArray alloc] initWithObjects:@"Most Recent",@"Card Game",@"Power Drinking",@"The Rest", nil];


    }
    else if([titleString isEqualToString:@"Places To Go"]) {
        [b2 addTarget:self action:@selector(sharePlace) forControlEvents:UIControlEventTouchUpInside];
        [b2 setTitle:@"Share A Place" forState:UIControlStateNormal];
        organizeArray = [[NSArray alloc] initWithObjects:@"Most Recent",@"Best Bars",@"Best Restaurants",@"Date Night Places",@"Party Scenes",@"Relaxing", nil];


    }
    dataArray = [[NSMutableArray alloc] init];
    [self updatetable];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(createBackButton) withObject:nil afterDelay:0.1];
    [DejalBezelActivityView activityViewForView:self.view];
    [self performSelectorInBackground:@selector(getTipsFromWebService) withObject:nil];


}
-(void)viewDidAppear:(BOOL)animated {

    //[self getTipsFromWebService];
}
-(void)movehome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)uploadTips {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        ShareTipViewController *shareTipViewController = [[ShareTipViewController alloc] initWithNibName:@"ShareTipViewController" bundle:nil];
        [self.navigationController pushViewController:shareTipViewController animated:YES];
    }
    else {
        ShareTipViewController *shareTipViewController = [[ShareTipViewController alloc] initWithNibName:@"ShareTipViewController_iPad" bundle:nil];
        [self.navigationController pushViewController:shareTipViewController animated:YES];
    }

}
-(void)shareGame {
    ShareGameViewController *shareGameViewController;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        shareGameViewController = [[ShareGameViewController alloc] initWithNibName:@"ShareGameViewController" bundle:nil];
    }
    else {
        shareGameViewController = [[ShareGameViewController alloc] initWithNibName:@"ShareGameViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:shareGameViewController animated:YES];
}
-(void)sharePlace {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        SharePlaceViewController *sharePlaceViewController = [[SharePlaceViewController alloc] initWithNibName:@"SharePlaceViewController" bundle:nil];
        [self.navigationController pushViewController:sharePlaceViewController animated:YES];
    }
    else {
        SharePlaceViewController *sharePlaceViewController = [[SharePlaceViewController alloc] initWithNibName:@"SharePlaceViewController_iPad" bundle:nil];
        [self.navigationController pushViewController:sharePlaceViewController animated:YES];
    }

}

-(void)createBackButton
{
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,58,30);
    button1.titleLabel.font= [UIFont boldSystemFontOfSize:14];
    [button1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed: @"back1.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
}

-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

-(CGFloat)tableView:(UITableView *)tableView1 heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (tableView1.tag == 11) {
            return 40;
            
        }
        else {
            return 50;
            
        }

    }
    else {
        if (tableView1.tag == 11) {
            return 80;
            
        }
        else {
            return 80;
            
        }
        
    }

}
- (NSInteger)tableView:(UITableView *)tableView1 numberOfRowsInSection:(NSInteger)section {
    if (tableView1.tag == 11) {
        return [organizeArray count];
    }
    else {
        if ([organizeType_Label.text isEqualToString:@"Most Recent"]) {
            return [self.title_Array count];
        }
        else {
            [indexArray removeAllObjects];
            for (int i = 0 ; i < [self.category_Array count] ; i++ ) {
                if ([[self.category_Array objectAtIndex:i] isEqualToString:organizeType_Label.text]) {
                    [indexArray addObject:[NSString stringWithFormat:@"%d",i]];
                }
            }
            return [indexArray count];
        }
    }
}
-(void)tableView: (UITableView*)tableView1 willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    if (tableView1.tag == 11) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    tableView1.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    tableView1.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (tableView1.tag == 11) {
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//            cell.selectionStyle= UITableViewCellSelectionStyleNone;
////            UILabel *lbl=[[UILabel alloc]init];
////            lbl.frame=CGRectMake(05,00,180, 30);
////            lbl.numberOfLines=2;
////            lbl.font=[UIFont boldSystemFontOfSize:12.0];
////            lbl.text=[organizeArray objectAtIndex:indexPath.row];
////            [lbl setTextColor:[UIColor whiteColor]];
////            [lbl setBackgroundColor:[UIColor clearColor]];
////            [cell addSubview:lbl];
//            cell.textLabel.text = [organizeArray objectAtIndex:indexPath.row];
//        }
//        else {
//            cell.selectionStyle= UITableViewCellSelectionStyleNone;
//            UILabel *lbl=[[UILabel alloc]init];
//            lbl.frame=CGRectMake(05,00,300, 30);
//            lbl.numberOfLines=2;
//            lbl.font=[UIFont boldSystemFontOfSize:12.0];
//            lbl.text=[organizeArray objectAtIndex:indexPath.row];
//            [lbl setTextColor:[UIColor whiteColor]];
//            [lbl setBackgroundColor:[UIColor clearColor]];
//            [cell addSubview:lbl];
//        }
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:12.0];
        cell.textLabel.text = [organizeArray objectAtIndex:indexPath.row];
      
        return cell;
    }
    else {
        if ([organizeType_Label.text isEqualToString:@"Most Recent"]) {
            NSString *str = [[self.title_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            cell.textLabel.text = str;
        }
        else         {
            NSString *str = [[self.title_Array objectAtIndex:[[indexArray objectAtIndex:indexPath.row] integerValue]] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            cell.textLabel.text = str;
        }
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];


        return cell;
    }

    

}
- (void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView1.tag == 11) {
        organizeType_Label.text=[organizeArray objectAtIndex:indexPath.row];
        
        [self showcampus:nil] ;
        [tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.1];
    }
    else {
        if ([organizeType_Label.text isEqualToString:@"Most Recent"]) {
            
        }
        else {
            indexPath = [NSIndexPath indexPathForRow:[[indexArray objectAtIndex:indexPath.row] integerValue] inSection:0];
        }
        if ([titleString isEqualToString:@"Student Tips"]) {
            ViewTipViewController *viewTipViewController;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                viewTipViewController = [[ViewTipViewController alloc] initWithNibName:@"ViewTipViewController" bundle:nil];

            }
            else {
                viewTipViewController = [[ViewTipViewController alloc] initWithNibName:@"ViewTipViewController_iPad" bundle:nil];

            }
            [self.navigationController pushViewController:viewTipViewController animated:YES];
            viewTipViewController.title_Label.text = [[self.title_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewTipViewController.Category_Label.text = [[self.category_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewTipViewController.description_TextView.text = [[self.description_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewTipViewController.necessitiescategory = self.titleString;
            viewTipViewController.idstr = [[self.id_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewTipViewController.location_Label.text = [[self.location_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];

        }
        else if([titleString isEqualToString:@"Drinking Games"]) {
            ViewGameViewController *viewGameViewController ;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                viewGameViewController = [[ViewGameViewController alloc] initWithNibName:@"ViewGameViewController" bundle:nil];
                
            }
            else {
                viewGameViewController = [[ViewGameViewController alloc] initWithNibName:@"ViewGameViewController_iPad" bundle:nil];
                
            }
            [self.navigationController pushViewController:viewGameViewController animated:YES];

            viewGameViewController.title_Label.text = [[self.title_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewGameViewController.Category_Label.text = [[self.category_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewGameViewController.instruction_TextView.text = [[self.description_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewGameViewController.urlString = [self.imageURL_Array objectAtIndex:indexPath.row];
            viewGameViewController.necessitiescategory = self.titleString;
            viewGameViewController.idstr = [[self.id_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];

            //});
            
        }
        else if([titleString isEqualToString:@"Places To Go"]) {
            ViewPlaceViewController *viewPlaceViewController ;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                viewPlaceViewController = [[ViewPlaceViewController alloc] initWithNibName:@"ViewPlaceViewController" bundle:nil];
                
            }
            else {
                viewPlaceViewController = [[ViewPlaceViewController alloc] initWithNibName:@"ViewPlaceViewController_iPad" bundle:nil];
                
            }
            [self.navigationController pushViewController:viewPlaceViewController animated:YES];
            viewPlaceViewController.title_Label.text = [[self.title_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewPlaceViewController.Category_Label.text = [[self.category_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewPlaceViewController.open_Label.text = [[self.hour_operation_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewPlaceViewController.description_TextView.text = [[self.description_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewPlaceViewController.address = [[self.address_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewPlaceViewController.urlString = [self.imageURL_Array objectAtIndex:indexPath.row];

            viewPlaceViewController.necessitiescategory = self.titleString;
            viewPlaceViewController.idstr = [[self.id_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            viewPlaceViewController.location_Label.text = [[self.location_Array objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];

            //});
            
        }
    }

}

-(IBAction)showcampus:(id)sender
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if(organize_Button.selected==NO)
        {
            organize_Button.selected = YES;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:.3];
            CGRect rect = organizeTable.frame;
            rect.size.height = 40*[organizeArray count];
            organizeTable.frame = rect;
            
            [UIView commitAnimations];
            
        }
        else
        {
            organize_Button.selected = NO;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:0.3];
            CGRect rect = organizeTable.frame;
            rect.size.height = 0;
            organizeTable.frame = rect;
            
            [UIView commitAnimations];
            //[self performSelector:@selector(changeStateOfCampus) withObject:nil afterDelay:1.0];
            
        }

    }
    else {
        if(organize_Button.selected==NO)
        {
            organize_Button.selected = YES;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:.3];
            CGRect rect = organizeTable.frame;
            rect.size.height = 80*[organizeArray count];
            organizeTable.frame = rect;
            
            [UIView commitAnimations];
            
        }
        else
        {
            organize_Button.selected = NO;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:0.3];
            CGRect rect = organizeTable.frame;
            rect.size.height = 0;
            organizeTable.frame = rect;
            
            [UIView commitAnimations];
            //[self performSelector:@selector(changeStateOfCampus) withObject:nil afterDelay:1.0];
            
        }

    }
    
        
}


-(void)updatetable
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        organizeTable = [[UITableView alloc] initWithFrame:CGRectMake(91,85,137,0)];
        organizeTable.tag = 11;
        organizeTable.delegate = self;
        organizeTable.dataSource = self;
        organizeTable.scrollEnabled=NO;
        organizeTable.backgroundColor = [UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1.0];
        organizeTable.layer.cornerRadius = 10.0;
        [self.view addSubview:organizeTable];
        [organizeTable reloadData];
    }
    else {
        organizeTable = [[UITableView alloc] initWithFrame:CGRectMake(250,170,270,0)];
        organizeTable.tag = 11;
        organizeTable.delegate = self;
        organizeTable.dataSource = self;
        organizeTable.scrollEnabled=NO;
        organizeTable.backgroundColor = [UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1.0];
        organizeTable.layer.cornerRadius = 7.0;
        [self.view addSubview:organizeTable];
        [organizeTable reloadData];
    }

}

-(void)getTipsFromWebService {
    NSString *strurl;
    if ([title_Label.text isEqualToString:@"Student Tips"]) {
        NSString *location = [self.campusLocationString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=ViewApproveStudentTip&loc=%@",location];

    }
    else if([title_Label.text isEqualToString:@"Drinking Games"]) {
        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=ViewApproveGame"];

    }
    else {
        NSString *location = [self.campusLocationString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=ViewApprovePlacetoGo&loc=%@",location];

    }
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [SBJSON new];
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    
    if ([title_Label.text isEqualToString:@"Student Tips"]) {

                self.id_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"stip_id"]];
                self.sid_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"sid"]];
                self.title_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"title"]];
                self.category_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"category"]];
                self.description_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"description"]];
                self.location_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"campus_location"]];

    }
    else if([title_Label.text isEqualToString:@"Drinking Games"]) {

                self.id_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_id"]];
                self.sid_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"sid"]];
                self.title_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_name"]];
                self.category_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_category"]];
                self.description_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_instruction"]];
                self.imageURL_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"game_img"]];


    }
    else {

                self.id_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_id"]];
                self.sid_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"sid"]];
                self.title_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_name"]];
                self.hour_operation_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"hour_operation"]];
                self.address_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"phy_address"]];
                self.category_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_category"]];
                self.description_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_description"]];
                self.imageURL_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"place_image"]];
                self.location_Array = [[NSArray alloc] initWithArray:[self getArrayFromJSONDictionary:recievedData forKey:@"campus_location"]];


    }
    [tableView reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
}
-(void)organizeByCategory {
    
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
        return [[NSArray alloc] init];
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
