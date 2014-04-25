//
//  ViewMemberTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TMember.h"

@interface ViewMemberTableViewController : UITableViewController

@property (strong, nonatomic) TMember * member;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dobLabel;

@property (weak, nonatomic) IBOutlet UIButton *isAliveLabel;

@property (weak, nonatomic) IBOutlet UIButton *locationLabel;

@property (weak, nonatomic) IBOutlet UIButton *mobileLabel;

@end
