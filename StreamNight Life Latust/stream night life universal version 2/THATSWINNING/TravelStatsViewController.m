
//
//  TravelStatsViewController.m
//  THATSWINNING_NEW
//
//  Created by Santosh Gupta on 21/06/13.
//  Copyright (c) 2013 Smoketech. All rights reserved.
//

#import "TravelStatsViewController.h"

@interface TravelStatsViewController ()

@end

@implementation TravelStatsViewController

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    // Do any additional setup after loading the view from its nib.
}
-(void)done {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated {

}
-(void)viewDidAppear:(BOOL)animated {
    noofstopage = 0;
    long double sumSpeed = 0.0,speed=0 ;
    long double distance = 0.0;
    
    for (int i = 0 ; i < [self.speed_Array count] ; i++) {
        if([[self.runningStatus_Array objectAtIndex:i] integerValue] == 0) {
            noofstopage = noofstopage +1;
        }
        
        speed=[[self.speed_Array objectAtIndex:i] floatValue];
        
        speed=speed>=0 ? speed : -speed;
        
        sumSpeed =sumSpeed + speed;
        distance = distance + [[self.distance_Array objectAtIndex:i] floatValue];
       
    }
    distance = distance*0.00062137;
    avgspeed = sumSpeed/[self.speed_Array count];
    
    avgspeed = avgspeed*0.00062137/0.00028;
    self.minSpeed_Label.text = [NSString stringWithFormat:@"%Lf miles",distance];
    self.avgSpeed_Label.text = [NSString stringWithFormat:@"%lf mile/hour",avgspeed];
    self.noofStopage_Label.text = [NSString stringWithFormat:@"%d",noofstopage];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//    for(int i = 0 ; i < [self.runningStatus_Array count] ; i++){
//        if([[self.runningStatus_Array objectAtIndex:i] integerValue] == 0) {
//            noofstopage = noofstopage +1;
//        }
//
//    }

//    minspeed = [[self.speed_Array objectAtIndex:0] floatValue];
//    maxspeed = [[self.speed_Array objectAtIndex:0] floatValue];
//    int j = 0;
//    while (TRUE) {
//        if ([[self.speed_Array objectAtIndex:j] floatValue] == 0.0) {
//            j++;
//            continue;
//        }
//        else {
//            minspeed = [[self.speed_Array objectAtIndex:j] floatValue];
//            maxspeed = [[self.speed_Array objectAtIndex:j] floatValue];
//            break;
//        }
//    }
//        if ([[self.speed_Array objectAtIndex:i] floatValue] == 0.0) {
//            i++;
//        }
//        if ([[self.speed_Array objectAtIndex:i] floatValue]< minspeed) {
//            minspeed = [[self.speed_Array objectAtIndex:i] floatValue];
//        }
//        if([[self.speed_Array objectAtIndex:i] floatValue]> maxspeed) {
//            maxspeed = [[self.speed_Array objectAtIndex:i] floatValue];
//        }


@end
