//
//  NightTrackingViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 13/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "NightTrackingViewController.h"
#import "SBJSON.h"
#import "SetTrackingTimeViewController.h"
#import "RouteMapViewController.h"
#import "DejalActivityView.h"
#import "Header.h"

@interface NightTrackingViewController ()

@end

@implementation NightTrackingViewController
@synthesize address,locationManager1;
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
    
    BOOL  isNotFirstTime = [defaults boolForKey:@"isNightTrackerNotFirstTime"];
    if(!isNotFirstTime){
        [[NSUserDefaults standardUserDefaults]  setBool:YES forKey:@"isNightTrackerNotFirstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alrtView=[[UIAlertView alloc]initWithTitle:@"Welcome!" message:@"This is great for all of us that have had one to many in the night. Track where you and your phone go through out the night here! Set your tracking period with the button below and let it run in the background. Share and laugh the next morning." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrtView show];
       
        
    }

    self.address = [[NSString alloc] init];
    [tracking_Button setTitleColor:[self colorWithHexString:@"69beff"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(EditTable:)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (locationNotification) name:@"LocationNotification" object:nil];

    self.locationManager1 = [[CLLocationManager alloc]init];
    self.locationManager1.delegate = self;
    self.locationManager1.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager1 startUpdatingLocation];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)locationNotification {
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self performSelector:@selector(come) withObject:nil afterDelay:0.1];
    [self checkTrackingStatus];

}
-(void)checkTrackingStatus {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *trackingSwitch = [defaults objectForKey:@"trackingswitch"];
    if (trackingSwitch && [trackingSwitch isEqualToString:@"on"]) {
        [tracking_Button setTitle:@"Stop Tracking" forState:UIControlStateNormal];
    }
    else {
        [tracking_Button setTitle:@"Start Tracking" forState:UIControlStateNormal];
        
    }
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
-(void)viewDidAppear:(BOOL)animated {
    [DejalBezelActivityView activityViewForView:self.view];
    [self performSelectorInBackground:@selector(getLocationFromServer) withObject:nil];
}
-(void)getLocationFromServer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *idstr = [defaults objectForKey:@"studentID"];
    
    
    NSString *strurl=[NSString stringWithFormat:@"?action=View_loc&uid=%@",idstr];
    
    NSDictionary *jsonDic = [[NSDictionary alloc]init];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
    
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:strurl
                                                      parameters:nil];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:jsonData];
    
    [request setHTTPBody:body];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *recievedData = [responseString JSONValue];
        
        if ([[recievedData objectForKey:@"TrackingTime"] isKindOfClass:[NSArray class]]) {
            location_Array = [[NSMutableArray alloc] initWithArray:[recievedData objectForKey:@"TrackingTime"]];
        }
        else {
            location_Array = [[NSMutableArray alloc] initWithObjects:[recievedData objectForKey:@"TrackingTime"], nil];
        }
        [location_Table reloadData];
        [DejalBezelActivityView removeViewAnimated:YES];
        
        
        
    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          [DejalBezelActivityView removeViewAnimated:YES];
                                         NSLog(@"Error: %@", error);
                                         
                                     }];
    
    [operation start];
    



}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor grayColor];
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString length] != 6)
        return  [UIColor grayColor];
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
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 40;

    }
    else {
        return 70;

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [location_Array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    else {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [location_Array objectAtIndex:indexPath.row];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        RouteMapViewController *mapViewController = [[RouteMapViewController alloc] initWithNibName:@"RouteMapViewController" bundle:nil];
        mapViewController.trackingtime = [location_Array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:mapViewController animated:NO];
    }
    else {
        RouteMapViewController *mapViewController = [[RouteMapViewController alloc] initWithNibName:@"RouteMapViewController_iPad" bundle:nil];
        mapViewController.trackingtime = [location_Array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:mapViewController animated:NO];
    }
    
}
- (IBAction) EditTable:(id)sender

{
    
    if(self.editing)
    {
        
        [super setEditing:NO animated:YES];
        
        
        [location_Table setEditing:NO animated:YES];
        
        [location_Table reloadData];
        
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
        
    }
    
    else
    {
        
        [super setEditing:YES animated:YES];
        
        [location_Table setEditing:YES animated:YES];
        
        [location_Table reloadData];
        
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        
    }
    
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (self.editing == NO || !indexPath) return UITableViewCellEditingStyleNone;
    
    if (self.editing && indexPath.row == ([location_Array count]))
        
    {
        
        return UITableViewCellEditingStyleInsert;
        
    } else
        
    {
        
        return UITableViewCellEditingStyleDelete;
        
    }
    
    return UITableViewCellEditingStyleNone;
    
}


- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *idstr = [defaults objectForKey:@"studentID"];
        
        
        NSString *strurl=[NSString stringWithFormat:@"http://www.thatswinning.com/traker/?action=DeleteLocByDate&tracking_time=%@&uid=%@",[location_Array objectAtIndex:indexPath.row],idstr];
        strurl = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [[NSURL alloc]initWithString:strurl];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSError *error;
        SBJSON *json = [SBJSON new];
        NSDictionary *recievedData = [json objectWithString:responseString error:&error];
        if ([[recievedData objectForKey:@"message"] isEqualToString:@"User deleted successfully"]) {
           // NSLog(@"Deleted");
        }
        [location_Array removeObjectAtIndex:indexPath.row];
        [location_Table reloadData];
    }
}


-(IBAction)onClickTrackButton:(id)sender {
    UIButton *btn = (UIButton *)sender;
    SetTrackingTimeViewController *setTrackingTime = [[SetTrackingTimeViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:setTrackingTime];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        [self presentViewController:navController animated:YES completion:nil];
    }
    else {
//        CGRect popoverRect;
//        popoverRect.size.width = 768;
//        popoverRect.origin.x  = 108;
//        popoverRect.origin.y  = 300;
//        popoverRect.size.height = 960;
//        UIPopoverController *popOverController = [[UIPopoverController alloc] initWithContentViewController:navController];
//        [popOverController presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        
        
        if (!popOverController) {
            popOverController = [[UIPopoverController alloc] initWithContentViewController:navController];
            popOverController.popoverContentSize = CGSizeMake(320, 480);
            popOverController.delegate = self;
        }
        else{
            [popOverController setContentViewController:navController];
        }

        CGRect popoverRect;
        
        popoverRect.size.width = 0;
        popoverRect.origin.x  = btn.frame.origin.x+(btn.frame.size.width/2);
        popoverRect.origin.y  = btn.frame.origin.y;
        popoverRect.size.height = 0;
        [popOverController presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        
    }
    
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    [self checkTrackingStatus];
}


-(IBAction)onClickHome_Button:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [manager stopUpdatingLocation];
    [self getAddressFromLatLon:newLocation.coordinate.latitude withLongitude:newLocation.coordinate.longitude];
}

-(IBAction)onClickSendMyLocation_Button:(id)sender {
    if ([self.address length]>0) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            ABPeoplePickerNavigationController *picker =[[ABPeoplePickerNavigationController alloc] init];
            picker.peoplePickerDelegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else {
            NSString *postText = self.address;
            
            NSArray *activityItems = @[postText];
            
            UIActivityViewController *activityController =
            [[UIActivityViewController alloc]
             initWithActivityItems:activityItems applicationActivities:nil];
            
            [self presentViewController:activityController
                               animated:YES completion:^(void){
                                   // [activityController release];
                               }];

        }

    }
    else {
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Please wait !" message:@"Currect address is bieing traced" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert1 show];
    }

}



//-(IBAction)showPicker:(id)sender
//{
//    ABPeoplePickerNavigationController *picker =[[ABPeoplePickerNavigationController alloc] init];
//    picker.peoplePickerDelegate = self;
//    [self presentViewController:picker animated:YES completion:nil];
//}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
     shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
 
    
    ABMultiValueRef phoneNumberProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSArray* phoneNumbers = (__bridge NSArray*)ABMultiValueCopyArrayOfAllValues(phoneNumberProperty);
 //   CFRelease(phoneNumberProperty);
    // Do whatever you want with the phone numbers
   // NSLog(@"Phone numbers = %@", phoneNumbers);
    
//    NSDictionary *selectedContact = [NSDictionary dictionaryWithDictionary:[PhoneContacts makeDictOfContact:person]];
//    NSArray* phoneNumbers = [[NSArray alloc]initWithObjects:[selectedContact objectForKey:@"Mobile"],nil];
    
    [self performSelector:@selector(message:) withObject:phoneNumbers afterDelay:0.3];

    [self dismissViewControllerAnimated:YES completion:nil];

    //    [self message:phone];
    return NO;
}

-(void)message:(NSString*)sender
{

    NSArray *arr = (NSArray *)sender;
    if ([arr count]>0) {
        NSArray *recipient=[NSArray arrayWithArray:arr];
        
        Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
        if (messageClass != nil) {
            if ([messageClass canSendText]) {

                MFMessageComposeViewController*  controller = [[MFMessageComposeViewController alloc] init];
                controller.messageComposeDelegate = self;
                [controller setBody:self.address];
                [controller setRecipients:recipient];
                controller.delegate = self;
                [self.navigationController presentViewController:controller animated:YES completion:nil];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Messaging functionality not found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }

    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please select contact no" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    

}

-(void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    //feedbackMsg.hidden = NO;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MessageComposeResultCancelled:
        {
            UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"SMS sending canceled!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert1 show];
        }
            
            // feedbackMsg.text = @"Result: SMS sending canceled";
            break;
            
        case MessageComposeResultSent:
        {
            UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"SMS sent!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert2 show];
        }
            
            // feedbackMsg.text = @"Result: SMS sent";
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"SMS sending failed!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert3 show];
        }
            
            // feedbackMsg.text = @"Result: SMS sending failed";
            break;
            
        default:
        {
            UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"SMS not sent!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert4 show];
        }
            
            // feedbackMsg.text = @"Result: SMS not sent";
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Memory Warning");
    // Dispose of any resources that can be recreated.
}

-(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude
{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:pdblLatitude longitude:pdblLongitude];
    
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            
            NSString *street_str = @"";
            
            if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStreetKey]] isEqualToString:@"(null)"]) {
                
                street_str = @"Street";
            }
            else{
                
                street_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStreetKey]];
            }
            
            NSString *city_str = @"";
            
            
            if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCityKey]] isEqualToString:@"(null)"]) {
                
                city_str = @"City";
            }
            else{
                
                city_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCityKey]];
            }
            
            NSString *state_str = @"";
            
            if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStateKey]] isEqualToString:@"(null)"]) {
                
                state_str = @"State";
            }
            else{
                
                state_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStateKey]];
            }
            
            NSString *country_str = @"";
            
            if ([[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCountryKey]] isEqualToString:@"(null)"]) {
                
                country_str = @"Country";
            }
            else{
                
                country_str= [NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCountryKey]];
            }
            
            
           self.address = [NSString stringWithFormat:@"I am at this location : %@, %@",street_str,city_str];
            
            
            
            
        }
    }];
    
    
    
    return nil;
}


@end
