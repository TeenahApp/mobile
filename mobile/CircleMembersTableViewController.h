//
//  CircleMembersTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/13/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSweetCirclesCommunicator.h"
#import "TSweetResponse.h"

#import "TMember.h"

#import "ViewMemberTableViewController.h"

@interface CircleMembersTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray * members;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
