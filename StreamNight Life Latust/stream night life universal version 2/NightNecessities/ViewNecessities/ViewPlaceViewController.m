//
//  ViewPlaceViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "ViewPlaceViewController.h"
#import "SharePlaceViewController.h"
#import "MapViewController.h"
#import "ReportViewController.h"
#import "DejalActivityView.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewPlaceViewController ()

@end

@implementation ViewPlaceViewController

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
-(void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(createBackButton) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(come) withObject:nil afterDelay:0.1];

}
-(void)viewDidAppear:(BOOL)animated {
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

-(void)createBackButton
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStyleDone target:self action:@selector(openMap)];
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
-(void)openMap {
    MapViewController * mapViewController = [[MapViewController alloc] init];
    NSRange range1 = [self.address rangeOfString:@"("];
    NSRange range2 = [self.address rangeOfString:@")"];
    NSRange range;
    range.length = range2.location - range1.location -1;
    range.location = range1.location+1;
    if (range1.location != NSNotFound && range2.location != NSNotFound ) {
        NSString *str = [self.address substringWithRange:range];
        NSRange r = [str rangeOfString:@","];
        NSString *latstr = [str substringToIndex:r.location - 1];
        NSString *lonstr = [str substringFromIndex:r.location + 1];
        mapViewController.location = [[CLLocation alloc] initWithLatitude:[latstr floatValue] longitude:[lonstr floatValue]];
    }
    mapViewController.placetitle = [self.address substringToIndex:range1.location-1];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    [self presentViewController:navController animated:YES completion:nil];
    
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

    }
    [self.navigationController pushViewController:reportViewController animated:YES];
    reportViewController.necessitiescategory = self.necessitiescategory;
    reportViewController.title_Label.text = self.title_Label.text;
    reportViewController.idstr = self.idstr;
}
-(IBAction)onClickSharePlace_Button:(id)sender {
    
    UIActionSheet *actonSheet = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Social Network",@"Instagram", nil];
    [actonSheet showInView:self.view];
    
   
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIImage *postImage = self.imageView.image;
        NSString *postText = [NSString stringWithFormat:@"Place : %@ Category: %@ Open: %@ Description: %@",self.title_Label.text,self.Category_Label.text,self.open_Label.text,self.description_TextView.text];
        
        NSArray *activityItems = @[postText, postImage];
        
        UIActivityViewController *activityController =
        [[UIActivityViewController alloc]
         initWithActivityItems:activityItems applicationActivities:nil];
        
        [self presentViewController:activityController
                           animated:YES completion:^(void){
                               // [activityController release];
                           }];
    }
    else if(buttonIndex == 1){
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,     NSUserDomainMask, YES);
        NSString *savePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"Image.png"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:savePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
        }
        [UIImageJPEGRepresentation(self.imageView.image, 1.0) writeToFile:savePath atomically:YES];
        
        NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
        
        if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
            //imageToUpload is a file path with .ig file extension
            UIDocumentInteractionController *documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
            documentInteractionController.UTI = @"com.instagram.exclusivegram";
            documentInteractionController.delegate = self;
            
            // documentInteractionController.annotation = [NSDictionary dictionaryWithObject:@"Insert Caption here" forKey:@"InstagramCaption"];
            [documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Instagram not found !" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
            [alert show];
            
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
