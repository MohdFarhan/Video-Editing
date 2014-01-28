//
//  selectAccount.m
//  THATSWINNING
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "selectAccount.h"
#import "normalAccount.h"


@interface selectAccount ()

@end

@implementation selectAccount


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
}

-(IBAction)movetoNormalAcc:(id)sender
{
    normalAccount *dl2=[[normalAccount alloc]init];
    [self.navigationController pushViewController:dl2 animated:YES];
    [dl2 release];
}

-(IBAction)movetoBussAcc:(id)sender
{

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


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
