//
//  ShareTipViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 23/04/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "ShareTipViewController.h"
#import "NecessitiesList.h"
#import "JSON.h"
#import "DejalActivityView.h"
#import <QuartzCore/QuartzCore.h>


@interface ShareTipViewController ()

@end

@implementation ShareTipViewController

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

    scrollView.contentSize = CGSizeMake(320, 364);
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
    category_Array = [[NSArray alloc ] initWithObjects:@"College Related",@"Night Life",@"Romance", nil];
    
    campusLocation_Array=[[NSMutableArray alloc]initWithObjects:@"Eau Claire, Wisconsin",@"Menomonie, Wisconsin",@"River Falls, Wisconsin",@"Milwaukee, Wisconsin", @"Madison, Wisconsin", nil];
    
    description_TextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
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
    //[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)onClickShareTip_Button:(id)sender{
    [DejalBezelActivityView activityViewForView:self.view];
    [self performSelector:@selector(shareTip) withObject:nil  afterDelay:0.0];
}
-(void)shareTip {

    if (![tipName_textField.text isEqualToString:@""] && ![Category_textField.text isEqualToString:@""] && ![description_TextView.text isEqualToString:@""] && ![location_textField.text isEqualToString:@""]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *sid = [defaults objectForKey:@"studentID"];
        NSString *tipName = [tipName_textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *category = [Category_textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *description = [description_TextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *location = [location_textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *webServiceURLString = [NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=StudTip&sid=%@&title=%@&category=%@&description=%@&campus_location=%@",sid,tipName,category,description,location];
        webServiceURLString = [webServiceURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
        NSURL *webServiceURL = [[NSURL alloc] initWithString:webServiceURLString];
        NSData *responseData = [NSData dataWithContentsOfURL:webServiceURL];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSError *error;
        SBJSON *json = [SBJSON new];
        NSDictionary *recievedData = [json objectWithString:responseString error:&error];
        if (recievedData) {
            NSString *status = [recievedData objectForKey:@"message"];
            if ([status isEqualToString:@"Success"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wow !" message:@"Tip has been submited succussfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                tipName_textField.text = @"";
                Category_textField.text = @"";
                description_TextView.text = @"";
                location_textField.text = @"";

            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry !" message:@"Tip has not been submited succussfully. Pleasse try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry !" message:@"Tip has not been submited succussfully. Pleasse try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }

        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields before upload tip." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [DejalBezelActivityView removeViewAnimated:YES];

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [description_TextView resignFirstResponder];
    if (textField.tag == 1) {
        [tipName_textField resignFirstResponder];
        if (!categoryPicker) {
            categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
            categoryPicker.showsSelectionIndicator = YES;
            categoryPicker.dataSource = self;
            categoryPicker.delegate = self;
        }
        categoryPicker.tag = 1;
        [self.view addSubview:categoryPicker];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGRect rect = categoryPicker.frame;
        rect.origin.y = self.view.frame.size.height - 216;
        categoryPicker.frame = rect;
        [UIView commitAnimations];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hidePicker)];
        
        scrollView.contentSize = CGSizeMake(320, scrollView.contentSize.height +50);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x , scrollView.contentOffset.y + 50);
        [UIView commitAnimations];
        
        return NO;
    }
    else if(textField.tag == 2) {
        
            [tipName_textField resignFirstResponder];
            if (!categoryPicker) {
                categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
                categoryPicker.showsSelectionIndicator = YES;
                categoryPicker.dataSource = self;
                categoryPicker.delegate = self;
            }
            categoryPicker.tag = 2;
            [self.view addSubview:categoryPicker];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            CGRect rect = categoryPicker.frame;
            rect.origin.y = self.view.frame.size.height - 216;
            categoryPicker.frame = rect;
            [UIView commitAnimations];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hidePicker)];
            
        scrollView.contentSize = CGSizeMake(320, scrollView.contentSize.height +70);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x , scrollView.contentOffset.y + 70);
        [UIView commitAnimations];
        return NO;

    }
    else {
        [self done];
        return YES;
    }
}
-(void)hidePicker {
    if (categoryPicker.tag == 1) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x , scrollView.contentOffset.y - 50);
        scrollView.contentSize = CGSizeMake(320, scrollView.contentSize.height -50);
        [UIView commitAnimations];
    }
    else if(categoryPicker.tag == 2) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x , scrollView.contentOffset.y - 70);
        scrollView.contentSize = CGSizeMake(320, scrollView.contentSize.height -70);
        [UIView commitAnimations];
    }
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
- (void)textFieldDidEndEditing:(UITextField *)textField {

}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [self done];
    [textView resignFirstResponder];

    scrollView.contentSize = CGSizeMake(320, scrollView.contentSize.height +150);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x , scrollView.contentOffset.y + 150);
    [UIView commitAnimations];
    return YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [description_TextView resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x , scrollView.contentOffset.y - 150);
    scrollView.contentSize = CGSizeMake(320, scrollView.contentSize.height - 150);
    [UIView commitAnimations];
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
    lab.textAlignment=NSTextAlignmentCenter;
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
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
