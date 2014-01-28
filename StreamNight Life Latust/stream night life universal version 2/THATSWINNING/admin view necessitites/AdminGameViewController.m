//
//  ViewGameViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "AdminGameViewController.h"
#import "JSON.h"
#import "ReportViewController.h"
#import "DejalActivityView.h"
#import <QuartzCore/QuartzCore.h>
@interface AdminGameViewController ()

@end

@implementation AdminGameViewController

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
    self.instruction_TextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.instruction_TextView.layer.borderWidth = 2.0;
    self.instruction_TextView.layer.cornerRadius = 10.0;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated {
    if ([self.status isEqualToString:@"0"]) {
        approve_disapporve_Button.selected = NO;
    }
    else if([self.status isEqualToString:@"1"]) {
        approve_disapporve_Button.selected = YES;
    }
    [DejalBezelActivityView activityViewForView:self.imageView];
    [self performSelectorInBackground:@selector(loadImage) withObject:nil];
    
}
-(void)loadImage {
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]]];
    if (img) {
        self.imageView.image = img;
    }
    [DejalBezelActivityView removeViewAnimated:YES];

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
}

-(IBAction)done:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)onClickApprove_Button:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        NSString *statusflag = @"0";
        NSString *strurl;
        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=EditGameStatus&game_id=%@&game_status=%@",self.game_id,statusflag];
        
        NSURL *url = [[NSURL alloc]initWithString:strurl];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSError *error;
        SBJSON *json = [SBJSON new] ;
        NSDictionary *recievedData = [json objectWithString:responseString error:&error];
        if ([[recievedData objectForKey:@"message"] isEqualToString:@"Update Successful"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disapproved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            btn.selected = YES;
        }
        btn.selected = NO;
        
    }
    else {
        NSString *statusflag = @"1";
        NSString *strurl;
        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=EditGameStatus&game_id=%@&game_status=%@",self.game_id,statusflag];
        
        NSURL *url = [[NSURL alloc]initWithString:strurl];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSError *error;
        SBJSON *json = [SBJSON new] ;
        NSDictionary *recievedData = [json objectWithString:responseString error:&error];
        if ([[recievedData objectForKey:@"message"] isEqualToString:@"Update Successful"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Approved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            btn.selected = YES;
        }
    }
}
-(IBAction)onClickReport_Button:(id)sender {
    ReportViewController *reportViewController;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        reportViewController = [[ReportViewController alloc] initWithNibName:@"ReportViewController" bundle:nil];
        
    }
    else {
        reportViewController = [[ReportViewController alloc] initWithNibName:@"ReportViewController_iPad" bundle:nil];
        
    }
    [self.navigationController pushViewController:reportViewController animated:YES];
    reportViewController.necessitiescategory = self.necessitiescategory;
    reportViewController.title_Label.text = self.title_Label.text;
    reportViewController.idstr = self.game_id;
    reportViewController.adminFlag = YES;
    

    
}
-(IBAction)onClickDelete_Button:(id)sender {
    NSString *strurl;
    strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=DeleteGame&game_id=%@",self.game_id];
    
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSError *error;
    SBJSON *json = [SBJSON new] ;
    NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    if ([[recievedData objectForKey:@"message"] isEqualToString:@"Successful"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shared Game Deleted" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
