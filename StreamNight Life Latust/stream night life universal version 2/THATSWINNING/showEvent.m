//  reviewEventdetail.m
//  THATSWINNING
//  Created by Mohit on 21/01/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.

#import "showEvent.h"
#import "DejalActivityView.h"
#import <QuartzCore/QuartzCore.h>
@interface showEvent ()
@end

@implementation showEvent

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

-(void)dealloc
{

    [self.description_TextView release];
    [self.title_Label release];
    [self.time_Label release];
    [self.date_Label release];
    [self.location_Label release];
    [self.category_Label release];
    [self.imageView release];
    [self.reoccurring_Label release];
    [super dealloc];
    
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==alertView.cancelButtonIndex)
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.description_TextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.description_TextView.layer.borderWidth = 2.0;
    self.description_TextView.layer.cornerRadius = 10.0;
//    ar=[[NSMutableArray alloc]init];
  //  NSLog(@"%d",beta);
    


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
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURl]]];
    if (img) {
        self.imageView.image = img;
    }
    [DejalBezelActivityView removeViewAnimated:YES];
    
}

//-------json----------------------------

-(NSArray *) getArrayFromJSONDictionary:(NSDictionary *)parent forKey:(NSString *)key
{
    id obj = [parent objectForKey:key];
    if([obj isKindOfClass:[NSArray class]])
    {
        return obj;
    }
    if([obj length]==0)
    {
        return [[[NSArray alloc] init] autorelease];
    }
    NSArray *ret = [NSArray arrayWithObject:obj];
    return ret;
}

-(IBAction)delete:(id)sender
{
  //  NSLog(@"%@",[EId objectAtIndex:beta]);
    
//    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=DeleteEvent&id=%@",[EId objectAtIndex:beta]];
//  //  NSLog(@"%@",strurl);
//    NSURL *url = [[NSURL alloc]initWithString:strurl];
//    responseData = [NSData dataWithContentsOfURL:url];
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//	
//	NSError *error;
//	SBJSON *json = [[SBJSON new] autorelease];
//	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
//	[responseString release];
//
//    
//    NSArray *Serviceid1 = [self getArrayFromJSONDictionary:recievedData forKey:@"message"];
//    
//    ar1 = [[NSMutableArray alloc]initWithArray:Serviceid1];
//    [self touch2:0];
}

-(IBAction)touch2:(id)sender
{
//    if([[ar1 objectAtIndex:0] isEqualToString:@"Deleted"])
//    {
//        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Success" message:@"You have successfully deleted event" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alt show];
//        [alt release];
//    }
}

-(IBAction)GettingServisec1
{
//   // NSLog(@"%@",[EId objectAtIndex:beta]);
//    NSString *statusflag = @"1";
//    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=EditEventStatus&id=%@&status=%@",[EId objectAtIndex:beta],statusflag];
//    //NSLog(@"%@",strurl);
//    NSURL *url = [[NSURL alloc]initWithString:strurl];
//    responseData = [NSData dataWithContentsOfURL:url];
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//	
//	NSError *error;
//	SBJSON *json = [[SBJSON new] autorelease];
//	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
//	[responseString release];
//	
//    NSArray *Serviceid1 = [self getArrayFromJSONDictionary:recievedData forKey:@"message"];
//    
//    ar = [[NSMutableArray alloc]initWithArray:Serviceid1];
//    [self touch1:0];
}

-(IBAction)touch1:(id)sender
{
//    if([[ar objectAtIndex:0] isEqualToString:@"Approved"])
//    {
//        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Success" message:@"You have successfully approved event" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alt show];
//        [alt release];
//    }
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
-(IBAction)onClickShare_Button:(id)sender {
    UIImage *postImage;
    if (self.imageView.image != nil) {
        
        UIActionSheet *actonSheet = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Social Network",@"Instagram", nil];
        [actonSheet showInView:self.view];
        [actonSheet release];
        
       
    }
else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Image not found to post" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (buttonIndex == 0) {
            
            UIImage* postImage = self.imageView.image;
            NSString *postText = [NSString stringWithFormat:@"Coming event : %@, %@,%@, Category: %@, Location: %@, Descrition: %@",self.title_Label.text,self.date_Label.text,self.time_Label.text,self.category_Label.text,self.location_Label.text,self.description_TextView.text] ;
            
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
                UIDocumentInteractionController *documentInteractionController = [[UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]]retain];
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
}

@end
