//
//  ShareGameViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "SharePlaceViewController.h"
#import "MapViewController.h"
#import "NecessitiesList.h"
#import "DejalActivityView.h"
#import <QuartzCore/QuartzCore.h>
@interface SharePlaceViewController ()

@end

@implementation SharePlaceViewController
@synthesize popoverController;
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
    scrollView.contentSize = CGSizeMake(320, 554);
    CGFloat sc1=[UIScreen mainScreen].bounds.size.height;
    if([UIScreen mainScreen].scale==2.0f && sc1==568.0f)
    {
        CGRect rect = scrollView.frame;
        rect.size.height = 400;
        scrollView.frame = rect;
    }
    else
    {
        CGRect rect = scrollView.frame;
        rect.size.height = 314;
        scrollView.frame = rect;
    }
     }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (locationNotification) name:@"LocationNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (mapNotification) name:@"MapNotification" object:nil];

    category_Array = [[NSArray alloc ] initWithObjects:@"Best Bars",@"Best Restaurants",@"Date Night Places",@"Party Scenes",@"Relaxing", nil];
    
    campusLocation_Array=[[NSMutableArray alloc]initWithObjects:@"Eau Claire, Wisconsin",@"Menomonie, Wisconsin",@"River Falls, Wisconsin",@"Milwaukee, Wisconsin", @"Madison, Wisconsin", nil];
    description_TextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    description_TextView.layer.borderWidth = 2.0;
    description_TextView.layer.cornerRadius = 10.0;

    // Do any additional setup after loading the view from its nib.
}
-(void)locationNotification {
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *str = delegate.placeAddress;
    if (str) {
        address_textField.text = str;
    }
}
-(void)viewDidAppear:(BOOL)animated {
    [self performSelector:@selector(createBackButton) withObject:nil afterDelay:0.1];

}
-(void)mapNotification {
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.coordinate.latitude != 0.0 && delegate.coordinate.latitude != 0.0) {
        [delegate getAddressFromLatLon:delegate.coordinate.latitude withLongitude:delegate.coordinate.longitude];
    }
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
            if (self.popoverController != nil) {
                [self.popoverController dismissPopoverAnimated:YES];
                self.popoverController=nil;
            }
            self.popoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
            [self.popoverController presentPopoverFromRect:popoverRect inView:btn permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        }
	}
    
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
        NSLog(@"%@",exception);
    }
    [picker dismissViewControllerAnimated:YES completion:nil ];
    
}
-(IBAction)onClickSharePlace_Button:(id)sender {
    [DejalBezelActivityView activityViewForView:self.view];
    [self performSelector:@selector(sharePlace) withObject:nil  afterDelay:0.0];
}
-(void)sharePlace {

    if (![placeName_textField.text isEqualToString:@""] && ![Category_textField.text isEqualToString:@""] && ![description_TextView.text isEqualToString:@""]  && ![operationHour_textField.text isEqualToString:@""]  && ![address_textField.text isEqualToString:@""] && imageView.image != nil) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *sid = [defaults objectForKey:@"studentID"];
        NSString *placeName = [placeName_textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *category = [Category_textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *description = [description_TextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *address = [address_textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *operationHour = [operationHour_textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *location = [location_textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        
        if (!dateFormat) {
            dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yy-MM-dd-hh:mm:ssa"];
        }
        NSString *picDate = [dateFormat stringFromDate:[NSDate date]];
        NSString *Picname=[[NSString alloc]initWithFormat:@"pic%@-%@.png",sid,picDate];
       // NSLog(@"%@",Picname);
        
        NSString *webServiceURLString = [NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=PlacetoGoDetails&sid=%@&place_name=%@&hour_operation=%@&phy_address=%@&place_description=%@&place_category=%@&place_image=%@&campus_location=%@",sid,placeName,operationHour,address,description,category,Picname,location];

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

                placeName_textField.text = @"";
                Category_textField.text = @"";
                description_TextView.text = @"";
                address_textField.text = @"";
                operationHour_textField.text = @"";
                location_textField.text = @"";

                
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry !" message:@"Place has not been shared succussfully. Pleasse try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry !" message:@"Place has not been shared succussfully. Pleasse try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
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
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wow !" message:@"Place has been shared succussfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
     //   NSLog(@"%@",returnString);
     //   NSLog(@"%@",img);
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self done];
    if (textField.tag == 0) {
        return YES;
    }
    else if (textField.tag == 1) {
        [operationHour_textField resignFirstResponder];
        if (!fromDatePicker) {

            fromDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width/2, 216)];
            CGRect rect = fromDatePicker.frame;
            rect.size.width = self.view.frame.size.width/2;
            fromDatePicker.frame = rect;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, -30, self.view.frame.size.width, 30)];
            label.backgroundColor = [UIColor blackColor];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                label.text  = @"From                         to";
            }
            else {
                label.text  = @"From                                                             to";

            }
            label.font = [UIFont boldSystemFontOfSize:20];
            [fromDatePicker addSubview:label];
        }
        if (!toDatePicker) {
            toDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height, self.view.frame.size.width/2, 216)];
            CGRect rect = toDatePicker.frame;
            rect.size.width = self.view.frame.size.width/2;
            toDatePicker.frame = rect;
        }
        fromDatePicker.datePickerMode = UIDatePickerModeTime;
        toDatePicker.datePickerMode = UIDatePickerModeTime;
        [self.view addSubview:fromDatePicker];
        [self.view addSubview:toDatePicker];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGRect rect = fromDatePicker.frame;
        rect.origin.y = self.view.frame.size.height - rect.size.height;
        fromDatePicker.frame = rect;
        rect = toDatePicker.frame;
        rect.origin.y = self.view.frame.size.height - rect.size.height;
        toDatePicker.frame = rect;
        [UIView commitAnimations];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideDatePicker)];
        return NO;

    }
    else if(textField.tag == 2) {
        if (!categoryPicker) {
            categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
        }
        categoryPicker.tag = 2;
        categoryPicker.showsSelectionIndicator = YES;
        categoryPicker.dataSource = self;
        categoryPicker.delegate = self;
        [self.view addSubview:categoryPicker];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGRect rect = categoryPicker.frame;
        rect.origin.y = self.view.frame.size.height - rect.size.height;
        categoryPicker.frame = rect;
        [UIView commitAnimations];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hidePicker)];
        return NO;
    }
    else if(textField.tag == 3) {
        MapViewController * mapViewController = [[MapViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
        [self presentViewController:navController animated:YES completion:nil];
        return NO;

    }
    else if (textField.tag == 4) {
        if (!categoryPicker) {
            categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
        }
        categoryPicker.tag = 1;
        categoryPicker.showsSelectionIndicator = YES;
        categoryPicker.dataSource = self;
        categoryPicker.delegate = self;
        [self.view addSubview:categoryPicker];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGRect rect = categoryPicker.frame;
        rect.origin.y = self.view.frame.size.height - rect.size.height;
        categoryPicker.frame = rect;
        [UIView commitAnimations];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hidePicker)];
        return NO;

    }
}
-(void)hideDatePicker {
    
    if (!dateFormat) {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"hh:mma"];
    }
    NSString *fromDate = [dateFormat stringFromDate:fromDatePicker.date];
    NSString *toDate = [dateFormat stringFromDate:toDatePicker.date];
    operationHour_textField.text  = [NSString stringWithFormat:@"%@ - %@",fromDate,toDate];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = fromDatePicker.frame;
    rect.origin.y = self.view.frame.size.height+30;
    fromDatePicker.frame = rect;
    rect = toDatePicker.frame;
    rect.origin.y = self.view.frame.size.height+30;
    toDatePicker.frame = rect;
    [UIView commitAnimations];
    [self performSelector:@selector(done) withObject:nil afterDelay:0.0];
}
-(void)hidePicker {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = categoryPicker.frame;
    rect.origin.y = self.view.frame.size.height;
    categoryPicker.frame = rect;
    [UIView commitAnimations];
    [self performSelector:@selector(done) withObject:nil afterDelay:0.0];
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [self done];
    
    scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height + 150);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + 150);
    [UIView commitAnimations];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y - 150);
    [UIView commitAnimations];
    scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height - 150);
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return [category_Array count];
        
    }
    else {
        return [campusLocation_Array count];
        
    }
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    lab.textAlignment=UITextAlignmentCenter;
    lab.backgroundColor=[UIColor clearColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        lab.font = [UIFont boldSystemFontOfSize:17];

    }
    else {
        lab.font = [UIFont boldSystemFontOfSize:20];

    }
    if (pickerView.tag == 1) {
        lab.text = [category_Array objectAtIndex:row];
        
    }
    else {
        lab.text = [campusLocation_Array objectAtIndex:row];
        
    }
    
    return lab;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        Category_textField.text = [category_Array objectAtIndex:row];
        
    }
    else {
        location_textField.text = [campusLocation_Array objectAtIndex:row];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
