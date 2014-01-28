//
//  ReportViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 07/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "ReportViewController.h"
#import "SBJSON.h"
#import <QuartzCore/QuartzCore.h>
@interface ReportViewController ()

@end

@implementation ReportViewController

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
    self.report_Array = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated {
    [self getReports:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStyleDone target:self action:@selector(postReport)];

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

-(IBAction)onClickHome_Button:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)getReports:(id)sender {
    NSString * strurl;
    if ([self.necessitiescategory isEqualToString:@"Student Tips"]) {
        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=CmntStudDetails&stip_id=%@",self.idstr];

    }
    else if([self.necessitiescategory isEqualToString:@"Drinking Games"]) {
        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=comment_game_details&game_id=%@",self.idstr];

    }
    else {
        strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=comment_place_to_go_details&place_id=%@",self.idstr];

    }
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *recievedData = [json objectWithString:responseString error:&error];
    
    if ([[recievedData objectForKey:@"message"] isEqualToString:@"Comment not Found"]) {
        [self.report_Array addObject:[recievedData objectForKey:@"message"]];
        
    }
    else {
        if ([[recievedData objectForKey:@"cmnt_desc"] isKindOfClass:[NSArray class]]) {
            self.report_Array =[[NSMutableArray alloc] initWithArray:[recievedData objectForKey:@"cmnt_desc"]] ;
        }
        else {
            [self.report_Array removeAllObjects];
            [self.report_Array addObject:[recievedData objectForKey:@"cmnt_desc"]];

        }
        
    }
    
    [self.report_Table reloadData];
    [responseString release];

}
-(void)postReport {
    if ([self.report_TestField.text length] > 0) {
        NSString * strurl;

        NSString *report = self.report_TestField.text;
        NSString *userid;
        if (self.adminFlag) {
            userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"admin"];
        }
        else {
            userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"studentID"];
        }
        
        if ([self.necessitiescategory isEqualToString:@"Student Tips"]) {
            strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=comment_student_tip&student_id=%@&cmnt_description=%@&stip_id=%@",userid,report, self.idstr];
            
        }
        else if([self.necessitiescategory isEqualToString:@"Drinking Games"]) {
            strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=comment_game&student_id=%@&cmnt_description=%@&game_id=%@",userid,report, self.idstr];
            
        }
        else {
            strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=comment_place_to_go&student_id=%@&cmnt_description=%@&place_id=%@",userid,report, self.idstr];
            
        }
        strurl = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [[NSURL alloc]initWithString:strurl];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
        NSDictionary *recievedData = [json objectWithString:responseString error:&error];
        if ([[recievedData objectForKey:@"message"] isEqualToString:@"Success"]) {
            [self getReports:nil];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your comment has been submited" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }

        
        [responseString release];
        

    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry !" message:@"Please write comment" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }

    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 50;

    }
    else {
        return 70;

    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.report_Array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    UITextView *textView;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        textView = [[UITextView alloc] initWithFrame:cell.bounds];
        textView.font = [UIFont systemFontOfSize:14];
        
    }
    else {
        textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, 758, 60)];

        textView.font = [UIFont systemFontOfSize:18];
        
    }
    textView.showsVerticalScrollIndicator = YES;
    textView.backgroundColor = [UIColor clearColor];
    [cell addSubview:textView];
    textView.editable = NO;

    textView.text = [self.report_Array objectAtIndex:indexPath.row];
    

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
