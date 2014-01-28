//
//  SetTrackingTimeViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 13/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "SetTrackingTimeViewController.h"

@interface SetTrackingTimeViewController ()

@end

@implementation SetTrackingTimeViewController

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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *startTime = [defaults objectForKey:@"startTime"];
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *endTime = [defaults objectForKey:@"endTime"];
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *trackingSwitch = [defaults objectForKey:@"trackingswitch"];
    
    startTracking_TextField.text = startTime;
    endTracking_TextField.text = endTime;
    if ([trackingSwitch isEqualToString:@"on"]) {
        [tracking_Switch setOn:YES];
    }
    else if ([trackingSwitch isEqualToString:@"off"]) {
        [tracking_Switch setOn:NO];
    }
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    actionSheet = [[UIActionSheet alloc] init];

    UIToolbar* pickerToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    pickerToolbar.barStyle = UIBarStyleBlackTranslucent;
    pickerToolbar.items = [NSArray arrayWithObjects:
                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(donePicker)],
                           nil];
    //[pickerToolbar sizeToFit];
    [actionSheet addSubview:pickerToolbar];
    // Do any additional setup after loading the view from its nib.
}

-(void)done {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!date_Picker) {
        date_Picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 45, 320, 216)];
        date_Picker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    
    [actionSheet showInView:self.view];
    [actionSheet addSubview:date_Picker];
    [actionSheet setFrame:CGRectMake(0, self.view.frame.size.height - 225, 320, 260)];

    if (textField.tag == 0) {
        date_Picker.tag = 0;
    }
    else {
        date_Picker.tag = 1;
    }
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}
-(void)openDatePicker {

}
-(void)donePicker {
    NSDate *date = date_Picker.date;
    static NSDateFormatter *dateFormatter;
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    if (date_Picker.tag == 0) {
        startTracking_TextField.text = [dateFormatter stringFromDate:date];

    }
    else {
        endTracking_TextField.text = [dateFormatter stringFromDate:date];

    }
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(IBAction)switchTracking:(id)sender {
    UISwitch *switchbutton = (UISwitch *)sender;
    static NSDateFormatter *dateFormatter;
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    NSDate *date1 = [dateFormatter dateFromString:startTracking_TextField.text];
    NSDate *date2 = [dateFormatter dateFromString:endTracking_TextField.text];
    
    if ([date1 compare:date2]== NSOrderedAscending) {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if ([date1 compare:[NSDate date]] == NSOrderedAscending || [date1 compare:[NSDate date]] == NSOrderedSame) {
            if (switchbutton.isOn) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:startTracking_TextField.text forKey:@"startTime"];
                defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:endTracking_TextField.text forKey:@"endTime"];
                defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"on" forKey:@"trackingswitch"];
                [defaults synchronize];
                appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                [appDelegate.locationManager startUpdatingLocation];
            }
            else {
                appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.locationManager stopUpdatingLocation] ;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:@"startTime"];
                [defaults removeObjectForKey:@"endTime"];
                [defaults removeObjectForKey:@"trackingswitch"];
                startTracking_TextField.text = @"";
                endTracking_TextField.text = @"";
                [defaults synchronize];

                
            }
        }
        else {
            NSDate *currDate=[NSDate date];
            NSTimeInterval interval = [date1 timeIntervalSinceDate:currDate];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:startTracking_TextField.text forKey:@"startTime"];
            defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:endTracking_TextField.text forKey:@"endTime"];
            defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"on" forKey:@"trackingswitch"];
            [defaults synchronize];
            appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.baseDate=date1;
            [ appDelegate callCheckTracking:interval];
        }
    }
    else {
        [tracking_Switch setOn:NO];
        UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please select proper time.Start time should be less than end time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
