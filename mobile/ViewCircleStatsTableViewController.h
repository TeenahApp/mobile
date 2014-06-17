//
//  ViewCircleStatsTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/19/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#define kChartCellPadding 16

#import <UIKit/UIKit.h>
#import <PNChart/PNChart.h>

#import "TSweetResponse.h"
#import "TSweetCirclesCommunicator.h"

#import "UIMultiColumnsTableViewCell.h"

@interface ViewCircleStatsTableViewController : UITableViewController

@property NSInteger circleId;

@property (strong, nonatomic) NSArray * sections;
@property (strong, nonatomic) NSMutableArray * data;

@end
