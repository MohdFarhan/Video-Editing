//
//  AdminViewTipViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 03/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "AdminTipViewController.h"
#import "JSON.h"
#import "ReportViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Header.h"
@interface AdminTipViewController ()
@end

@implementation AdminTipViewController

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
-(void)viewDidAppear:(BOOL)animated {
    if ([self.status isEqualToString:@"0"]) {
        approve_disapporve_Button.selected = NO;
    }
    else if([self.status isEqualToString:@"1"]) {
        approve_disapporve_Button.selected = YES;
    }
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

//-(IBAction)onClickApprove_Button:(id)sender {
//    UIButton *btn = (UIButton *)sender;
//    if (btn.selected) {
//        NSString *statusflag = @"0";
//        NSString *strurl;
//        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=EditTipStatus&stip_id=%@&tip_status=%@",self.tip_id,statusflag];
//        
//        NSURL *url = [[NSURL alloc]initWithString:strurl];
//        NSData *responseData = [NSData dataWithContentsOfURL:url];
//        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//        
//        NSError *error;
//        SBJSON *json = [[SBJSON new] autorelease];
//        NSDictionary *recievedData = [json objectWithString:responseString error:&error];
//        if ([[recievedData objectForKey:@"message"] isEqualToString:@"Update Successful"]) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disapproved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            [alert release];
//            btn.selected = YES;
//        }
//        [responseString release];
//        btn.selected = NO;
//        
//    }
//    else {
//        NSString *statusflag = @"1";
//        NSString *strurl;
//        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=EditTipStatus&stip_id=%@&tip_status=%@",self.tip_id,statusflag];
//        
//        NSURL *url = [[NSURL alloc]initWithString:strurl];
//        NSData *responseData = [NSData dataWithContentsOfURL:url];
//        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//        
//        NSError *error;
//        SBJSON *json = [[SBJSON new] autorelease];
//        NSDictionary *recievedData = [json objectWithString:responseString error:&error];
//        if ([[recievedData objectForKey:@"message"] isEqualToString:@"Update Successful"]) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Approved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            [alert release];
//            btn.selected = YES;
//        }
//        [responseString release];
//    }
//}


-(IBAction)onClickApprove_Button:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        NSString *statusflag = @"0";
        NSString *strurl;
        strurl=[NSString stringWithFormat:@"?action=EditTipStatus&stip_id=%@&tip_status=%@",self.tip_id,statusflag];
        
        NSDictionary *jsonDic = [[NSDictionary alloc]init];
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
        
        [httpClient setParameterEncoding:AFFormURLParameterEncoding];
        
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                                path:strurl
                                                          parameters:nil];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:jsonData];
        
        [request setHTTPBody:body];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *recievedData = [responseString JSONValue];

            if ([[recievedData objectForKey:@"message"] isEqualToString:@"Update Successful"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disapproved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                btn.selected = YES;
            }
            btn.selected = NO;
            
        }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             NSLog(@"Error: %@", error);
                                             
                                         }];
        
        [operation start];
        
    }
    else {
        NSString *statusflag = @"1";
        NSString *strurl;
        strurl=[NSString stringWithFormat:@"?action=EditTipStatus&stip_id=%@&tip_status=%@",self.tip_id,statusflag];
        
        
        NSDictionary *jsonDic = [[NSDictionary alloc]init];
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
        
        [httpClient setParameterEncoding:AFFormURLParameterEncoding];
        
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                                path:strurl
                                                          parameters:nil];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:jsonData];
        
        [request setHTTPBody:body];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *recievedData = [responseString JSONValue];
            
            if ([[recievedData objectForKey:@"message"] isEqualToString:@"Update Successful"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Approved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                btn.selected = YES;
            }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             NSLog(@"Error: %@", error);
                                             
        }];
        [operation start];
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
    reportViewController.idstr = self.tip_id;
    reportViewController.adminFlag = YES;

}
-(IBAction)onClickDelete_Button:(id)sender {
    NSString *strurl;
    strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=DeleteTip&stip_id=%@",self.tip_id];
    
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSError *error;
    SBJSON *json = [SBJSON new] ;
    NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    if ([[recievedData objectForKey:@"message"] isEqualToString:@"Successful"]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip Deleted" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
