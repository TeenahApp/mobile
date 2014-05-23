//
//  ViewMemberTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TMember.h"
#import "UIAvatarCellTableViewCell.h"
#import "UIAvatarView.h"

@interface ViewMemberTableViewController : UITableViewController <UIActionSheetDelegate>

@property (strong, nonatomic) TMember * member;

@property (strong, nonatomic) UIAvatarView * image;

@property (strong, nonatomic) NSArray * sections;

@property (strong, nonatomic) NSMutableArray * data;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
