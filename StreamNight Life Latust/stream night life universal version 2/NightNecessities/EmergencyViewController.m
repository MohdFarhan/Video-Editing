//
//  EmergencyViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "EmergencyViewController.h"

@interface EmergencyViewController ()

@end

@implementation EmergencyViewController

@synthesize dataArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    [dataArray release];
    [rootDict release];
    [dataDict release];
    [keyArray release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"Emergency" withExtension:@"plist"];
    rootDict = [[NSMutableDictionary alloc] initWithContentsOfURL:path];
    NSArray *ar = [rootDict allKeys];
 //   NSLog(@"%@",ar);
    keyArray = [[NSMutableArray alloc] initWithArray:[rootDict allKeys]];
    [tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(createBackButton) withObject:nil afterDelay:0.1];
    
}
-(void)createBackButton
{
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,58,30);
    button1.titleLabel.font= [UIFont boldSystemFontOfSize:14];
    [button1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed: @"back1.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 release];
}

-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [keyArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arr = [rootDict objectForKey:[keyArray objectAtIndex:section]];
    return [arr count];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView1 heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSArray *arr = [rootDict objectForKey:[keyArray objectAtIndex:indexPath.section]];
    NSArray *ar = [arr objectAtIndex:indexPath.row];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [ar count]*25;
        
    }
    else {
        return [ar count]*40;
        
    }

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [keyArray objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor colorWithRed:105.0/255 green:190.0/255 blue:255.0/255 alpha:1.0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:MyIdentifier];
    // if (cell == nil)
    // {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    //}
    
    NSArray *arr = [rootDict objectForKey:[keyArray objectAtIndex:indexPath.section]];
    NSArray *ar = [arr objectAtIndex:indexPath.row];
    //    UILabel *name_Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    //    UILabel *contact_Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 30)];
    //    UILabel *address_Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, 30)];
    //    UILabel *other_Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 320, 30)];
    //    [cell addSubview:name_Label];
    //    [cell addSubview:contact_Label];
    //    [cell addSubview:address_Label];
    //    [cell addSubview:other_Label];
    //
    UILabel *label;
    UIWebView *webview;
    for (int i = 0 ;  i < [ar count] ; i++) {
        
        if ([[ar objectAtIndex:i] length] < 45) {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                label = [[UILabel alloc] initWithFrame:CGRectMake(13, i*25, 300, 25)];
                webview = [[UIWebView alloc] initWithFrame:CGRectMake(13, i*25, 300, 25)];
                if (i == 0) {
                    label.font = [UIFont boldSystemFontOfSize:14];
                }
                else {
                    label.font = [UIFont systemFontOfSize:14];
                }
            }
            else {
                label = [[UILabel alloc] initWithFrame:CGRectMake(60, i*40, 600, 40)];
                 webview = [[UIWebView alloc] initWithFrame:CGRectMake(60, i*40, 600, 40)];
                if (i == 0) {
                    label.font = [UIFont boldSystemFontOfSize:20];
                }
                else {
                    label.font = [UIFont systemFontOfSize:20];
                }
            }

        }
        else{
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                label = [[UILabel alloc] initWithFrame:CGRectMake(13, i*25, 300, 25)];
               webview = [[UIWebView alloc] initWithFrame:CGRectMake(13, i*25, 300, 25)];
                label.numberOfLines = 2;
                
                if (i == 0) {
                    label.font = [UIFont boldSystemFontOfSize:14];
                }
                else {
                    label.font = [UIFont systemFontOfSize:11];
                }
            }
            else {
                label = [[UILabel alloc] initWithFrame:CGRectMake(60, i*40, 600, 40)];
                 webview = [[UIWebView alloc] initWithFrame:CGRectMake(60, i*40, 600, 40)];
                label.numberOfLines = 2;
                
                if (i == 0) {
                    label.font = [UIFont boldSystemFontOfSize:20];
                }
                else {
                    label.font = [UIFont systemFontOfSize:16];
                }
            }
            
        }
        
        label.textColor = [UIColor whiteColor];
        
        label.backgroundColor = [UIColor clearColor];
        label.text = [ar objectAtIndex:i];
       // [cell addSubview:label];
        webview.delegate=self;
        
        //if(i==1){
        [webview loadHTMLString:[NSString stringWithFormat:@"%@",[ar objectAtIndex:i]] baseURL:Nil];
        webview.backgroundColor=[UIColor clearColor];
        webview.opaque = NO;
        [webview setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:webview];
        
    }
    
    
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


-(IBAction)onClickHome_Button:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
