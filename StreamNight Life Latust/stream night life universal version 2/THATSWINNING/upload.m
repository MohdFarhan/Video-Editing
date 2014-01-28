
//  upload.m
//  THATSWINNING
//
//  Created by Guramrit on 24/02/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "upload.h"
#import "campusEvents.h"
#import "DejalActivityView.h"
#import "CKViewController.h"
#import "CKCalendarView.h"
#import "UIImage+Resize.h"
#import <QuartzCore/QuartzCore.h>
#import "Header.h"

@interface upload () <CKCalendarDelegate>

@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@end

@implementation upload

-(void)dealloc
{
//    [selectDate release];
//    [SelectedhourArray release];
//    [bottomview release];
//    [b1 release];
//    [responseData release];
//    [ar release];
//    [option release];
//    [strname release];
//    [image release];
//    [puppy release];
//    [tool release];
//    [desctxt release];
//    [locationTxt release];
//    [datetxt release];
//    [durationTxt release];
//    [titleTxt release];
//    [datePicker release];
//    [pp release];
//    [pick release];
//    [Scroll release];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated{
   
        [desctxt resignFirstResponder];
    [titleTxt resignFirstResponder];

   
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

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) return [UIColor grayColor];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

-(void)removeActivity
{
   // [DejalBezelActivityView removeViewAnimated:YES];
    [SVProgressHUD dismiss];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:timePicker];
    [self.view addSubview:datePicker];
    timePicker.hidden=YES;
    tool.hidden=YES;
    selectDate=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];
    SelectedhourArray=[[NSMutableArray alloc]initWithObjects:@"am",@"pm",nil];
    
    //    UIImageView *imgView = [[UIImageView alloc]initWithFrame:desctxt.bounds];
    //    imgView.image = [UIImage imageNamed: @"complaint-bg.png"];
    //    [desctxt addSubview: imgView];
    //    [desctxt sendSubviewToBack: imgView];
    
    //desctxt.backgroundColor = [UIColor clearColor];
    categaryArray = [[NSArray alloc] initWithObjects:@"Sport Events",@"Deals And Specials",@"Entertainment",@"Community Events",@"Randoms",nil];
    locationArray = [[NSMutableArray alloc]initWithObjects:@"Eau Claire, Wisconsin",@"Menomonie, Wisconsin",@"River Falls, Wisconsin",@"Milwaukee, Wisconsin", @"Madison, Wisconsin", nil];
    
    @try
    {
        puppy=[[NSMutableArray alloc]init];
        option=[[NSMutableArray alloc]init];
        datePicker.hidden=YES;
        Scroll.delegate =self;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            if ([UIScreen mainScreen].bounds.size.height == 480) {
                [Scroll setContentSize:CGSizeMake(320, 590)];
            }
            
            CGFloat sc1=[UIScreen mainScreen].bounds.size.height;
            if([UIScreen mainScreen].scale==2.0f && sc1==568.0f)
            {
                bottomview = [[UIView alloc] initWithFrame:CGRectMake(0,455,320,70)];
            }
            else
            {
                bottomview = [[UIView alloc] initWithFrame:CGRectMake(0,366,320,70)];
            }
            bottomview.backgroundColor = [UIColor clearColor];
            [self.view addSubview:bottomview];
            
            UIImageView *bottomimg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,50)];
            bottomimg.image = [UIImage imageNamed:@"bottom-nav.png"];
            [bottomview addSubview:bottomimg];
            
            b1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [b1 addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
            b1.titleLabel.font=[UIFont boldSystemFontOfSize:14.0];
            b1.titleLabel.numberOfLines=2;
            [b1 setTitle:@"Upload for review" forState:UIControlStateNormal];
            b1.frame = CGRectMake(90,07,150,40);
            [bottomview addSubview:b1];
        }
        else {
            
        }
        [b1 setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception);
    }
    
    desctxt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    desctxt.layer.borderWidth = 2.0;
    desctxt.layer.cornerRadius = 10.0;
}



-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([whichControl isEqualToString:@"Date"] || [whichControl isEqualToString:@"time"]){
        [self Done];
    }
    if([whichControl isEqualToString:@"location"] || [whichControl isEqualToString:@"category"]){
        [self closePicker];
    }

    if (textView == desctxt)
	{
		
        [UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [Scroll frame];
		rect.origin.y -= 160;
		[Scroll setFrame:rect];
		[UIView commitAnimations];
	}

    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == desctxt)
	{
        
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.25];
		CGRect rect = [Scroll frame];
		rect.origin.y += 160;
		[Scroll setFrame:rect];
		[UIView commitAnimations];
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	if([whichControl isEqualToString:@"Date"] || [whichControl isEqualToString:@"time"]){
        [self Done];
    }
    if([whichControl isEqualToString:@"location"] || [whichControl isEqualToString:@"category"]){
        [self closePicker];
    }

    /*
    if (textField == durationTxt)
	{
        pickervew=YES;
        [textField resignFirstResponder];
        [desctxt resignFirstResponder];
        [titleTxt resignFirstResponder];
        [self performSelector:@selector(TimePicker) withObject:nil afterDelay:0.1];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        }
        else {
            [Scroll addSubview:timePicker];
            timePicker.frame = CGRectMake(199, 340, 294, 216);
        }
    }
    else if(textField==datetxt)
    {
////        pickervew=NO;
        [self performSelector:@selector(DatePickerUp) withObject:nil afterDelay:0.0];
//       
//        CKViewController *cal = [[CKViewController alloc] init];
//        [self.view addSubview:cal.view];
//        
//     //   [self.navigationController pushViewController:cal animated:YES];
        
         [textField resignFirstResponder];
        [desctxt resignFirstResponder];
        [titleTxt resignFirstResponder];
        CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
        self.calendar = calendar;
        calendar.delegate = self;
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
        self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
        
        self.disabledDates = @[
                               [self.dateFormatter dateFromString:@"05/01/2013"],
                               [self.dateFormatter dateFromString:@"06/01/2013"],
                               [self.dateFormatter dateFromString:@"07/01/2013"]
                               ];
        
        calendar.onlyShowCurrentMonth = NO;
        calendar.adaptHeightToNumberOfWeeksInMonth = YES;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            calendar.frame = CGRectMake(0, 0, 320, 320);
            [self.view addSubview:calendar];
        }
        else {
            calendar.frame = CGRectMake(199, 285, 294, 300);
            [Scroll addSubview:calendar];
        }

        
                
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];

        
    }
    else if(textField==categaryTxt)
    {
        pickervew=YES;
        [textField resignFirstResponder];
        [desctxt resignFirstResponder];
        [titleTxt resignFirstResponder];
        if (Picker2) {
            [Picker2 removeFromSuperview];
           // [Picker2 release];
            Picker2 = nil;
        }
        Picker1 = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            Picker1.frame = CGRectMake(0, 0, 320, 216);
             [self.view addSubview:Picker1];
        }
        else {
            Picker1.frame = CGRectMake(199, 453, 294, 216);
            [Scroll addSubview:Picker1];
        }
        Picker1.showsSelectionIndicator = YES;
        Picker1.tag = 11;
        Picker1.delegate = self;
        Picker1.dataSource = self;
       
        UIBarButtonItem *RightBut=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closePicker)];
        self.navigationItem.rightBarButtonItem=RightBut;
    }
    else if(textField==locationTxt)
    {
        pickervew=NO;
        [textField resignFirstResponder];
        [desctxt resignFirstResponder];
        [titleTxt resignFirstResponder];
        if (Picker1) {
            [Picker1 removeFromSuperview];
           // [Picker1 release];
            Picker1 = nil;
        }
        Picker2 = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            Picker2.frame = CGRectMake(0, 0, 320, 216);
            [self.view addSubview:Picker2];
        }
        else {
            Picker2.frame = CGRectMake(199, 395, 294, 216);
            [Scroll addSubview:Picker2];
        }
        Picker2.showsSelectionIndicator = YES;
        Picker2.tag = 22;
        Picker2.delegate = self;
        Picker2.dataSource = self;
        UIBarButtonItem *RightBut=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closePicker)];
        self.navigationItem.rightBarButtonItem=RightBut;
    }
*/
}
-(IBAction)dateButtonClick:(id)sender{
    if([whichControl isEqualToString:@"Date"] || [whichControl isEqualToString:@"time"]){
        [self Done];
    }
    if([whichControl isEqualToString:@"location"] || [whichControl isEqualToString:@"category"]){
        [self closePicker];
    }
    whichControl=@"Date";
    ////        pickervew=NO;
    [self performSelector:@selector(DatePickerUp) withObject:nil afterDelay:0.0];
    //
    //        CKViewController *cal = [[CKViewController alloc] init];
    //        [self.view addSubview:cal.view];
    //
    //     //   [self.navigationController pushViewController:cal animated:YES];
    
    [desctxt resignFirstResponder];
    [titleTxt resignFirstResponder];
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
    
    self.disabledDates = @[
                           [self.dateFormatter dateFromString:@"05/01/2013"],
                           [self.dateFormatter dateFromString:@"06/01/2013"],
                           [self.dateFormatter dateFromString:@"07/01/2013"]
                           ];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        calendar.frame = CGRectMake(0, 0, 320, 320);
        [self.view addSubview:calendar];
    }
    else {
        calendar.frame = CGRectMake(199, 285, 294, 300);
        [Scroll addSubview:calendar];
    }
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    

}
-(IBAction)timeButtonClick:(id)sender{
    if([whichControl isEqualToString:@"Date"] || [whichControl isEqualToString:@"time"]){
        [self Done];
    }
    if([whichControl isEqualToString:@"location"] || [whichControl isEqualToString:@"category"]){
        [self closePicker];
    }
    whichControl=@"time";
    pickervew=YES;
   
    [desctxt resignFirstResponder];
    [titleTxt resignFirstResponder];
    [self performSelector:@selector(TimePicker) withObject:nil afterDelay:0.1];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    }
    else {
        [Scroll addSubview:timePicker];
        timePicker.frame = CGRectMake(199, 340, 294, 216);
    }

}
-(IBAction)locationButtonClick:(id)sender{
    if([whichControl isEqualToString:@"Date"] || [whichControl isEqualToString:@"time"]){
        [self Done];
    }
    if([whichControl isEqualToString:@"location"] || [whichControl isEqualToString:@"category"]){
        [self closePicker];
    }
    whichControl=@"location";
    pickervew=NO;
   
    [desctxt resignFirstResponder];
    [titleTxt resignFirstResponder];
    if (Picker1) {
        [Picker1 removeFromSuperview];
        // [Picker1 release];
        Picker1 = nil;
    }
    Picker2 = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        Picker2.frame = CGRectMake(0, 0, 320, 216);
        [self.view addSubview:Picker2];
    }
    else {
        Picker2.frame = CGRectMake(199, 395, 294, 216);
        [Scroll addSubview:Picker2];
    }
    Picker2.showsSelectionIndicator = YES;
    Picker2.tag = 22;
    Picker2.delegate = self;
    Picker2.dataSource = self;
    UIBarButtonItem *RightBut=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closePicker)];
    self.navigationItem.rightBarButtonItem=RightBut;

}
-(IBAction)categoryButtonClick:(id)sender{
    if([whichControl isEqualToString:@"Date"] || [whichControl isEqualToString:@"time"]){
        [self Done];
    }
    if([whichControl isEqualToString:@"location"] || [whichControl isEqualToString:@"category"]){
        [self closePicker];
    }
    whichControl=@"category";
    pickervew=YES;
   
    [desctxt resignFirstResponder];
    [titleTxt resignFirstResponder];
    if (Picker2) {
        [Picker2 removeFromSuperview];
        // [Picker2 release];
        Picker2 = nil;
    }
    Picker1 = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        Picker1.frame = CGRectMake(0, 0, 320, 216);
        [self.view addSubview:Picker1];
    }
    else {
        Picker1.frame = CGRectMake(199, 453, 294, 216);
        [Scroll addSubview:Picker1];
    }
    Picker1.showsSelectionIndicator = YES;
    Picker1.tag = 11;
    Picker1.delegate = self;
    Picker1.dataSource = self;
    
    UIBarButtonItem *RightBut=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closePicker)];
    self.navigationItem.rightBarButtonItem=RightBut;

}



-(void)closePicker {
    if (pickervew) {
        [Picker1 removeFromSuperview];
       // [Picker1 release];
        Picker1 = nil;
        categaryTxt.text = [categaryArray objectAtIndex:pickerIndex];
    }
    else {
        [Picker2 removeFromSuperview];
        //[Picker2 release];
        Picker2 = nil;
        locationTxt.text = [locationArray objectAtIndex:pickerIndex];

    }
    [desctxt resignFirstResponder];
   whichControl=nil;
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)DatePickerUp
{
    [titleTxt resignFirstResponder];
    [durationTxt resignFirstResponder];
    [locationTxt resignFirstResponder];
    [datetxt resignFirstResponder];

    //datePicker.hidden=NO;
//    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [self but];
}

-(void)TimePicker
{
    [titleTxt resignFirstResponder];
    [durationTxt resignFirstResponder];
    [locationTxt resignFirstResponder];
    [datetxt resignFirstResponder];
    timePicker.hidden=NO;
    [desctxt resignFirstResponder];

    [self but];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==actionSheet.cancelButtonIndex)
    {
    }
    else
    {
        locationTxt.text=[option objectAtIndex:buttonIndex];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //locationTxt,*datetxt,*durationTxt,*titleTxt;
	if (textField == durationTxt)
	{
        //		[UIView beginAnimations:nil context:NULL];
        //		[UIView setAnimationBeginsFromCurrentState:YES];
        //		[UIView setAnimationDuration:0.25];
        //		CGRect rect = [self.view frame];
        //		rect.origin.y += 150;
        //		[self.view setFrame:rect];
        //		[UIView commitAnimations];
	}
    else if (textField == locationTxt)
	{
        [datetxt resignFirstResponder];
    }
    else if (textField==titleTxt)
    {
        [titleTxt resignFirstResponder];
    }
    [desctxt resignFirstResponder];
    [titleTxt resignFirstResponder];
}

-(IBAction)Done1
{
    
    self.navigationItem.rightBarButtonItem=nil;
}

-(void)but
{
    UIBarButtonItem *RightBut=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(Done)];
    self.navigationItem.rightBarButtonItem=RightBut;
}

-(void)Done
{
    NSArray *subViews;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
           subViews = [self.view subviews];
    }
    else {
            subViews = [Scroll subviews];
    }

    for (UIView *subView in subViews) {
        if ([subView isKindOfClass:[CKCalendarView class]]) {
            [subView removeFromSuperview];
        }
    }
    if (pickervew==NO)
    {
//        NSDate *date = [datePicker date];
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    
//        [dateFormat setDateFormat:@"yyyy-MM-dd"];
//        NSString *dateString = [dateFormat stringFromDate:date];
//        datetxt.text=dateString;
//    
//        if (Datepicker==NO)
//        {
//            [UIDatePicker beginAnimations: @"Bouncing" context: nil];
//            [UIDatePicker setAnimationDelegate: self];
//            [UIDatePicker setAnimationDuration: .5];
//            [UIDatePicker setAnimationCurve: UIViewAnimationCurveEaseIn];
//        
//            datePicker.frame =  CGRectMake(datePicker.frame.origin.x,
//                                       datePicker.frame.origin.y+200,
//                                       datePicker.frame.size.width,
//                                       datePicker.frame.size.height);
//            [UIDatePicker commitAnimations];
//            Datepicker=YES;
//        }
//        datePicker.hidden=YES;
        
    }
    else if(pickervew==YES)
    {
        
//        NSInteger row;
//        NSInteger row1;
//        row = [timePicker selectedRowInComponent:0];
//        row1 = [timePicker selectedRowInComponent:1];
        
        NSDateFormatter *dateFarmater = [[NSDateFormatter alloc] init];
        [dateFarmater setDateFormat:@"hh:mm a"];
        NSString *timeStr = [dateFarmater stringFromDate:timePicker.date];
        [durationTxt setText:timeStr];
        
        timePicker.hidden=YES;
        tool.hidden=YES;
    }
    self.navigationItem.rightBarButtonItem=nil;
    [desctxt resignFirstResponder];
whichControl=nil;
}

-(IBAction)upload:(id)sender
{
   // [DejalBezelActivityView activityViewForView:self.view];
    [SVProgressHUD show];

    [self  performSelector:@selector(uploAD_INFO) withObject:nil afterDelay:1.0];
    [desctxt resignFirstResponder];

}

-(void)uploAD_INFO
{
    
    [locationTxt resignFirstResponder];
    [datetxt resignFirstResponder];
    [durationTxt resignFirstResponder];
    
  
    if([titleTxt.text length] == 0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill title" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[alert release];
        [self removeActivity];
    }
    else if( [datetxt.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill date" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[alert release];
        [self removeActivity];
    }
    else if( [durationTxt.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill Time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[alert release];
        [self removeActivity];
    }
    else if([categaryTxt.text length] == 0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill Category" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[alert release];
        [self removeActivity];
    }
    else if( [locationTxt.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[alert release];
        [self removeActivity];
    }
    
    else if( [desctxt.text length]<=0 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Fill duration" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[alert release];
        [self removeActivity];
    }
//    else if (!uploadImageView.image)
//    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Select image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        //[alert release];
//        [self removeActivity];
//    }
    else
    {
        
        int h=arc4random()%10000009;
        NSString *Picname=[[NSString alloc]initWithFormat:@"pic%d.png",h];
     //   NSLog(@"%@",Picname);
        [self GettingServisec:Picname];
        if ([ar count]) {
            if([[ar objectAtIndex:0] isEqualToString:@"Success"])
            {
                
                [self upload1:Picname];
                locationTxt.text=nil;
                datetxt.text=nil;
                durationTxt.text=nil;
                desctxt.text=nil;
                
                UIAlertView *selectvalue=[[UIAlertView alloc]initWithTitle:@"Success" message:@"You have successfully uploaded Event for review" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [selectvalue show];
                //[selectvalue release];
               // [DejalBezelActivityView removeViewAnimated:YES];
                [SVProgressHUD dismiss];
                
            }
            else
            {
                UIAlertView *selectvalue=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Event Incorrect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [selectvalue show];
                //[selectvalue release];
            }
            
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==alertView.cancelButtonIndex)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(IBAction)get2:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        
		picker.delegate = self;
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [self.navigationController presentViewController:picker animated:YES completion:nil];
            
        }
        else {
            CGRect popoverRect;
            
            popoverRect.size.width = 0;
            popoverRect.origin.x  = btn.frame.size.width/2;
            popoverRect.origin.y  = 0;
            popoverRect.size.height = 0;
            popOverController = [[UIPopoverController alloc] initWithContentViewController:picker];
            [popOverController presentPopoverFromRect:popoverRect inView:btn permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        }
	}
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    @try
    {
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        pp.image=image;
     //   NSLog(@"%@",image);
        uploadImageView.alpha = 1.0;
        uploadImageView.image = image;
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception);
    }
}

-(void)upload1:(NSString *)img
{
    NSData *imageData;
    
    if (image!=nil)
    {
        imageData = UIImageJPEGRepresentation(uploadImageView.image, 1.0);
                
        NSUInteger len = [imageData length];
        len=len/1024;
        len=len/1024;
        if (len>2)
        {
            image = [image resizedImage:CGSizeMake(image.size.width/2, image.size.height) interpolationQuality:kCGInterpolationHigh];
            
            //
            //        UIAlertView *alert5=[[UIAlertView alloc]initWithTitle:@"Caution" message:@"Please upload images upto 2mb sizes" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            //        [alert5 show];
            //        //[alert5 release];
        }
        
        imageData= UIImageJPEGRepresentation(image,1);
        
    }
    else
    {
        imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"icon.png"], -0.1);
    }
    
    
    NSString *urlString = @"http://www.thatswinning.com/traker/img/image.php";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
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
        
     //  NSLog(@"%@",returnString);
    //    NSLog(@"%@",img);
       // [returnString release];
    }
}


-(void)upload2:(NSString *)img
{
    UIImage *tommy=[puppy objectAtIndex:0];
    NSData *imageData= UIImageJPEGRepresentation(tommy,1);
    
    NSUInteger len = [imageData length];
    len=len/1024;
    len=len/1024;
    if (len>2)
    {
        tommy = [tommy resizedImage:CGSizeMake(tommy.size.width/2, tommy.size.height) interpolationQuality:kCGInterpolationHigh];
        
        //
        //        UIAlertView *alert5=[[UIAlertView alloc]initWithTitle:@"Caution" message:@"Please upload images upto 2mb sizes" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        //        [alert5 show];
        //        //[alert5 release];
    }
   // NSLog(@"%@",[puppy objectAtIndex:0]);

    imageData= UIImageJPEGRepresentation(tommy,1);


    NSString *urlString = @"http://www.thatswinning.com/traker/image.php";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    {
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n-%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"myfile\"; filename=\"%@\"\r\n",img] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n-%@-\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
     //   NSLog(@"%@",returnString);
        
        //[returnString release];
    }
}

-(void)GettingServisec:(NSString *)imageName
{
    [ar removeAllObjects];
    NSLog(@"%@",categaryTxt.text);
    NSString *strloc = [locationTxt.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *strdate = [datetxt.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *strdur = [durationTxt.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *strdesc = [desctxt.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *strtitle = [titleTxt.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *strcategory = [categaryTxt.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    strname=@"image.png";
    
    NSString *strusername=strdur;
    if([strusername intValue]<10)
    {
        strusername=[NSString stringWithFormat:@"0%@:00:00",strusername];
       // NSLog(@"%@",strusername);
    }
    else
    {
        strusername=[NSString stringWithFormat:@"%@:00:00",strusername];
        //NSLog(@"%@",strusername);
    }
    
    NSString *strName = [strlocation stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    //NSLog(@"%@",strName);
    NSString *weekDay = @"0";
    if (reccuring_Swith.isOn) {
        weekDay =  reocurrngDay_Label.text;
    }
    NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=Events&loc=%@&title=%@&dt=%@&dura=%@&des=%@&pic=%@&phyloc=%@&category=%@&day=%@",strloc,strtitle,strdate,strdur,strdesc,imageName,strloc,strcategory,weekDay];
    
   NSLog(@"%@",strurl);
    NSURL *url = [[NSURL alloc]initWithString:strurl];
    responseData = [NSData dataWithContentsOfURL:url];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSError *error;
	SBJSON *json = [SBJSON new] ;
	NSDictionary *recievedData = [json objectWithString:responseString error:&error];
	//[responseString release];
	
    ar =[self getArrayFromJSONDictionary:recievedData forKey:@"message"];
}

-(NSMutableArray *) getArrayFromJSONDictionary:(NSDictionary *)parent forKey:(NSString *)key
{
    id obj = [parent objectForKey:key];
    if([obj isKindOfClass:[NSArray class]])
    {
        return obj;
    }
    if([obj length]==0)
    {
        return [[NSMutableArray alloc] init] ;
    }
    NSMutableArray *ret = [NSMutableArray arrayWithObject:obj];
    return ret;
}

-(void)viewWillAppear:(BOOL)animated
{
    @try
    {
        [self performSelector:@selector(come) withObject:nil afterDelay:0.1];
    }
    @catch (NSException *exception)
    {
    }
}

-(void)come
{
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,58,30);
    button1.titleLabel.font= [UIFont boldSystemFontOfSize:14];
    [button1 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed: @"back1.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
   // [button1 release];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thepickerView
{
    if (thepickerView.tag == 11 || thepickerView.tag == 22) {
        return 1;
    }
	return 2;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 11) {
        return [categaryArray count];
    }
    if (pickerView.tag == 22) {
        return [locationArray count];
    }
    int como;
    if (component==0)
    {
        como=[selectDate count];
    }
    if (component==1)
    {
        como=2;
    }
	return como;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    pickerIndex = row;
//    NSString *SelectedTime;
//    NSString *SelectedHour;
//    if (component==0) {
//        SelectedTime=[selectDate objectAtIndex:row];
//    }
//    if (component==1) {
//        SelectedHour=[SelectedhourArray objectAtIndex:row];
//    }
//    durationTxt.text=[NSString stringWithFormat:@"%@ %@",SelectedTime,SelectedHour];
}


-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    lab.textAlignment=UITextAlignmentCenter;
    lab.backgroundColor=[UIColor clearColor];
    lab.font = [UIFont boldSystemFontOfSize:17];
    if (pickerView.tag == 11) {
        lab.text=[categaryArray objectAtIndex:row];

    }
    else if (pickerView.tag == 22) {
        lab.text=[locationArray objectAtIndex:row];

    }


    else if (component==0)
    {
        lab.text=[selectDate objectAtIndex:row];
    }
    else if (component==1)
    {
        lab.text=[SelectedhourArray objectAtIndex:row];
    }
    return lab;
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    //self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:date];
    datetxt.text=dateString;
    NSDateFormatter* theDateFormatter = [[NSDateFormatter alloc] init];
    [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [theDateFormatter setDateFormat:@"EEEE"];
    reocurrngDay_Label.text =  [theDateFormatter stringFromDate:date];
    
    
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date) {
        self.calendar.backgroundColor = [UIColor blueColor];
        return YES;
    } else {
        self.calendar.backgroundColor = [UIColor redColor];
        return NO;
    }
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}
-(IBAction)reoccurring_Switch:(id)sender {
    if ([datetxt.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [reccuring_Swith setOn:NO animated:YES];
    }
    else {
        
    }

}

@end
