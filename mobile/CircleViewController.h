//
//  CircleViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/8/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSweetCirclesCommunicator.h"
#import "TSweetResponse.h"

#import "PNChart.h"

// TODO: Complete this view controller.

@interface CircleViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSDictionary * circle;

@property (weak, nonatomic) IBOutlet UIScrollView *innerView;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@property (strong, nonatomic) NSDictionary * stats;

@property (weak, nonatomic) IBOutlet UIPageControl *pager;

@property (strong, nonatomic) NSArray * pages;

@property (strong, nonatomic) NSMutableArray * locations;

// TODO: Better to be graph.
//@property (strong, nonatomic) NSMutableArray * educations;

@property (strong, nonatomic) NSMutableArray * educationMajors;

@property (strong, nonatomic) NSMutableArray * companies;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *menuView;

@property (weak, nonatomic) IBOutlet UIButton *membersLabel;

@end
