//
//  CircleEventsViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "CircleEventsViewController.h"

@interface CircleEventsViewController ()

@end

@implementation CircleEventsViewController

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
    // Do any additional setup after loading the view.
    
    MNCalendarView *calendarView = [[MNCalendarView alloc] initWithFrame:self.calendarView.bounds];
    calendarView.selectedDate = [NSDate date];
    calendarView.delegate = self;
    
    [self.calendarView addSubview:calendarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)calendarView:(MNCalendarView *)calendarView shouldSelectDate:(NSDate *)date
{
    //NSLog(@"%@", date);
    return YES;
}

-(int)calendarView:(MNCalendarView *)calendarView getEventsCountForDate:(NSDate *)date
{
    return 0;//arc4random_uniform(2) ? 0 : 1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
