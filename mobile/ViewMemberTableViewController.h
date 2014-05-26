//
//  ViewMemberTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TMember.h"
#import "TMemberEducation.h"

#import "UIAvatarCellTableViewCell.h"
#import "UIAvatarView.h"

#import "AddMemberEducationViewController.h"
#import "AddMemberJobViewController.h"

@interface ViewMemberTableViewController : UITableViewController <UIActionSheetDelegate>

@property (strong, nonatomic) TMember * member;

@property (strong, nonatomic) UIAvatarView * image;

@property (strong, nonatomic) NSArray * sections;

@property (strong, nonatomic) NSMutableArray * data;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIActionSheet * actionSheet;

@property BOOL canAddEducation;
@property BOOL canAddJob;

@end
