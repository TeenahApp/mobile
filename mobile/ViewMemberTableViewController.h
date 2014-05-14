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

@interface ViewMemberTableViewController : UITableViewController

@property (strong, nonatomic) TMember * member;

@property (strong, nonatomic) UIImage * image;

@property (strong, nonatomic) NSArray * sections;

@property (strong, nonatomic) NSMutableArray * data;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
