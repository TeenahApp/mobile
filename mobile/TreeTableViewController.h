//
//  TreeTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/6/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import <UICKeyChainStore.h>

#import "TSweetResponse.h"
#import "TSweetMembersCommunicator.h"

#import "UITreeNodeTableViewCell.h"

#import "TMember.h"

#import "AddMemberRelationViewController.h"
#import "ViewMemberTableViewController.h"

@interface TreeTableViewController : UITableViewController <UIActionSheetDelegate>

@property NSInteger memberId;

@property (nonatomic, strong) TMember * member;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIActionSheet * actionSheet;

@property (strong, nonatomic) NSDictionary * relationStrings;
@property (strong, nonatomic) NSMutableArray * relations;

@property (strong, nonatomic) NSString * currentRelation;

@end
