//
//  ViewMediaTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/1/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIMultiColumnsTableViewCell.h"

#import "TSweetResponse.h"
#import "TSweetMediasCommunicator.h"
#import "TSweetMembersCommunicator.h"

#import "ViewMemberTableViewController.h"
#import "CommentsTableViewController.h"

#import "TMedia.h"

@interface ViewMediaTableViewController : UITableViewController

@property (strong, nonatomic) NSArray * sections;
@property (strong, nonatomic) NSMutableArray * data;

@property (nonatomic, strong) TMedia * media;

@property (nonatomic, strong) UIImage * image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *likeButton;

@end
