//
//  EventsTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSweetResponse.h"
#import "TSweetEventsCommunicator.h"

#import "AddEventViewController.h"
#import "ViewEventTableViewController.h"

#import "TEvent.h"

@interface EventsTableViewController : UITableViewController

@property NSInteger circleId;

@property (nonatomic, strong) NSMutableArray * sections;
@property (nonatomic, strong) NSMutableArray * data;

@end
