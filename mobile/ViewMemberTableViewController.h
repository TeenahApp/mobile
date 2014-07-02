//
//  ViewMemberTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

#import "TMember.h"
#import "TMemberEducation.h"

#import "UIMultiColumnsTableViewCell.h"

#import "AddMemberEducationViewController.h"
#import "AddMemberJobViewController.h"
#import "UpdateMemberInfoViewController.h"
#import "CommentsTableViewController.h"

@interface ViewMemberTableViewController : UITableViewController <UIActionSheetDelegate>

@property (strong, nonatomic) TMember * member;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *displayNameButton;

@property (nonatomic, strong) TSweetResponse * likeResponse;

@property (strong, nonatomic) NSArray * sections;
@property (strong, nonatomic) NSMutableArray * data;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *likeButton;

@property BOOL canAddEducation;
@property BOOL canAddJob;

@property (nonatomic, strong) NSDictionary * degrees;

@property (nonatomic, strong) NSDictionary * relations;

@property (nonatomic, strong) UIAlertView * alert;

@end
