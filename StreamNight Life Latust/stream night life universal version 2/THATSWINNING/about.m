//  about.m
//  THATSWINNING
//  Created by Mohit on 04/02/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "about.h"
#import "DejalActivityView.h"
#import "AddComplaintViewController.h"
#import "ViewController.h"
@interface about ()
@end

@implementation about

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(IBAction)AddComp:(id)sender
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        AddComplaintViewController *viewController = [[AddComplaintViewController alloc] initWithNibName:@"AddComplaintViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        AddComplaintViewController *viewController = [[AddComplaintViewController alloc] initWithNibName:@"AddComplaintViewController_iPad" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];

    }
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    NSString *htmlString = [NSString stringWithFormat:@"<html><body>Stream is your connection to everything that makes your campus fun.  All the information is user created and moderated by us. By creating an account you accept our terms and agreements outlined on our site <a href=\"www.streamnightlife.com\">streamnightlife.com</a>. Stream is owned and operated by ThatsWinning LLC.</body></html>"];
    [webView loadHTMLString:htmlString baseURL:nil];

    
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
-(IBAction)onClickLinkButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.streamnightlife.com"]];
    
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
