//
//  ViewTipViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "ViewTipViewController.h"
#import "ShareTipViewController.h"
#import "ReportViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewTipViewController ()

@end

@implementation ViewTipViewController

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
    self.description_TextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.description_TextView.layer.borderWidth = 2.0;
    self.description_TextView.layer.cornerRadius = 10.0;
    // Do any additional setup after loading the view from its nib.
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

-(IBAction)onClickHome_Button:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)onClickReport_Button:(id)sender {
    ReportViewController *reportViewController;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        reportViewController = [[ReportViewController alloc] initWithNibName:@"ReportViewController" bundle:nil];
        
    }
    else {
        reportViewController = [[ReportViewController alloc] initWithNibName:@"ReportViewController_iPad" bundle:nil];
        
    }    [self.navigationController pushViewController:reportViewController animated:YES];
    reportViewController.necessitiescategory = self.necessitiescategory;
    reportViewController.title_Label.text = self.title_Label.text;
    reportViewController.idstr = self.idstr;
}
-(IBAction)onClickShareTip_Button:(id)sender {
    
    
    NSString *postText = [NSString stringWithFormat:@"Tip : %@ Category: %@ Description: %@",self.title_Label.text,self.Category_Label.text,self.description_TextView.text];
    
    NSArray *activityItems = @[postText];
    
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:activityController
                       animated:YES completion:^(void){
                           // [activityController release];
                       }];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
