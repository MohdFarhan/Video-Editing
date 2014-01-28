//
//  ShareGameViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "ShareGameViewController.h"
#import "NecessitiesList.h"
#import "JSON.h"
#import "DejalActivityView.h"
#import <QuartzCore/QuartzCore.h>
@interface ShareGameViewController ()

@end

@implementation ShareGameViewController

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
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    scrollView.contentSize = CGSizeMake(320, 450);
    CGFloat sc1=[UIScreen mainScreen].bounds.size.height;
    if([UIScreen mainScreen].scale==2.0f && sc1==568.0f)
    {
        CGRect rect = scrollView.frame;
        rect.size.height = 450;
        scrollView.frame = rect;
    }
    else
    {
        CGRect rect = scrollView.frame;
        rect.size.height = 364;
        scrollView.frame = rect;
    }
    }
    else {
        
    }
    category_Array = [[NSArray alloc ] initWithObjects:@"Card Game",@"Power Drinking",@"The Rest", nil];
    
    description_TextView.layer.borderColor = [UIColor grayColor].CGColor;
    description_TextView.layer.borderWidth = 2.0;
    description_TextView.layer.cornerRadius = 10.0;

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
}

-(void)back {
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[NecessitiesList class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}
-(IBAction)onClickUploadImage_Button:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		UIImagePickerController *picker= [[UIImagePickerController alloc]init];
		picker.delegate = self;
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [self presentModalViewController:picker animated:YES];

        }
        else {
            CGRect popoverRect;
            
            popoverRect.size.width = 0;
            popoverRect.origin.x  = btn.frame.size.width/2;
            popoverRect.origin.y  = 0;
            popoverRect.size.height = 0;
            UIPopoverController *popOverController = [[UIPopoverController alloc] initWithContentViewController:picker];
            [popOverController presentPopoverFromRect:popoverRect inView:btn permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        }
	}

}
-(IBAction)onClickShareGame_Button:(id)sender  {
    [DejalBezelActivityView activityViewForView:self.view];
    [self performSelector:@selector(shareGame) withObject:nil  afterDelay:0.0];
}
-(void)shareGame {
    {
        if (![gameName_textField.text isEqualToString:@""] && ![Category_textField.text isEqualToString:@""] && ![description_TextView.text isEqualToString:@""] && imageView.image != nil) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *sid = [defaults objectForKey:@"studentID"];
            NSString *gameName = [gameName_textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *category = [Category_textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *description = [description_TextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            int h=arc4random()%10000009;
            NSString *Picname=[[NSString alloc]initWithFormat:@"pic%d.png",h];
         //   NSLog(@"%@",Picname);
            
            NSString *webServiceURLString = [NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=GameData&sid=%@&game_name=%@&game_category=%@&game_instruction=%@&game_img=%@",sid,gameName,category,description,Picname];
            webServiceURLString = [webServiceURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *webServiceURL = [[NSURL alloc] initWithString:webServiceURLString];
            NSData *responseData = [NSData dataWithContentsOfURL:webServiceURL];
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            
            NSError *error;
            SBJSON *json = [SBJSON new];
            NSDictionary *recievedData = [json objectWithString:responseString error:&error];
            if (recievedData) {
                NSString *status = [recievedData objectForKey:@"message"];
                if ([status isEqualToString:@"Success"]) {
                    [self uploadImage:Picname];
                    
                    gameName_textField.text = @"";
                    Category_textField.text = @"";
                    description_TextView.text = @"";
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry !" message:@"Game has not been submited succussfully. Pleasse try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry !" message:@"Game has not been submited succussfully. Pleasse try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    [DejalBezelActivityView removeViewAnimated:YES];

}
-(void)uploadImage:(NSString *)img
{
    NSData *imageData = UIImagePNGRepresentation(imageView.image);
    
    if (imageView.image!=nil)
    {
        imageData = UIImageJPEGRepresentation(imageView.image, 1.0);
    }
    else
    {
        imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"icon.png"], -0.1);
    }
    NSUInteger len = [imageData length];
    len=len/1024;
    len=len/1024;
    if (len>2)
    {
        UIAlertView *alert5=[[UIAlertView alloc]initWithTitle:@"Caution" message:@"Please upload images upto 2mb sizes" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert5 show];
    }
    NSString *urlString = @"http://www.thatswinning.com/traker/img/image.php";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    {
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"myfile\"; filename=\"%@\"\r\n",img] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wow !" message:@"Tip has been submited succussfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
      //  NSLog(@"%@",returnString);
      //  NSLog(@"%@",img);
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [description_TextView resignFirstResponder];
    if (textField.tag == 1) {
        [gameName_textField resignFirstResponder];
        if (!categoryPicker) {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 216)];
            }
            else {
                categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 768, 216)];
            }
        }
        categoryPicker.showsSelectionIndicator = YES;
        categoryPicker.dataSource = self;
        categoryPicker.delegate = self;
        [self.view addSubview:categoryPicker];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGRect rect = categoryPicker.frame;
        rect.origin.y = self.view.frame.size.height - 216;
        categoryPicker.frame = rect;
        [UIView commitAnimations];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hidePicker)];
        
        return NO;
    }
    else {
        [self done];
        return YES;
    }
}
-(void)hidePicker {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = categoryPicker.frame;
    rect.origin.y = self.view.frame.size.height;
    categoryPicker.frame = rect;
    [UIView commitAnimations];
    [self performSelector:@selector(done) withObject:nil afterDelay:0.3];
}

-(void)done {
    
    if (categoryPicker) {
        [categoryPicker removeFromSuperview];
        categoryPicker = nil;
    }
    
    self.navigationItem.rightBarButtonItem = nil;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    @try
    {
        
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        imageView.alpha = 1.0;

        imageView.image = image;

    }
    @catch (NSException *exception)
    {
      //  NSLog(@"%@",exception);
    }
    [picker dismissModalViewControllerAnimated:YES];

}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self done];
    scrollView.contentSize = CGSizeMake(320, scrollView.contentSize.height +100);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x , scrollView.contentOffset.y + 120);
    [UIView commitAnimations];
    return YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    scrollView.contentSize = CGSizeMake(320, scrollView.contentSize.height - 120);
    scrollView.contentOffset = CGPointMake(0 , 0 );
    [UIView commitAnimations];
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [category_Array count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [category_Array objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Category_textField.text = [category_Array objectAtIndex:row];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
