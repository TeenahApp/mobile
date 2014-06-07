//
//  TreeTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/6/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

#import "TSweetResponse.h"
#import "TSweetMembersCommunicator.h"

#import "UITreeNodeTableViewCell.h"

#import "TMember.h"

#import "ViewMemberTableViewController.h"

@interface TreeTableViewController : UITableViewController

@property NSInteger memberId;

@property (nonatomic, strong) TMember * member;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
