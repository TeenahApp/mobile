//
//  CircleViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/8/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "CircleViewController.h"

@interface CircleViewController ()

@end

@implementation CircleViewController

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
    
    TSweetResponse * tsr = [[CirclesCommunicator shared] getStats:@"1"];
   
    [self.mainLabel setText:@"Members Count"];
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame: CGRectMake(0, 0, self.innerView.frame.size.width, self.innerView.frame.size.height)];
    
    barChart.backgroundColor = [UIColor clearColor];
    
    [barChart setXLabels:@[@"Mbrs",@"A.Mbrs",@"Mls",@"A.Mls",@"Fmls",@"A.Fmls"]];
    
    [barChart setYValues:@[tsr.json[@"members_count"], tsr.json[@"alive_members_count"], tsr.json[@"males_count"], tsr.json[@"alive_males_count"], tsr.json[@"females_count"], tsr.json[@"alive_females_count"]]];
    
    barChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    
    [barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNYellow]];
    [barChart strokeChart];
    
    //barChart.delegate = self;

    [self.innerView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self.innerView addSubview:barChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
