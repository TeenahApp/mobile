//
//  CommentsTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

#import "UITabInputView.h"
#import "UILikeButton.h"

#import "TSweetResponse.h"

#import "TSweetEventsCommunicator.h"
#import "TSweetMediasCommunicator.h"
#import "TSweetMembersCommunicator.h"

#import "TComment.h"

#import "UICommentTableViewCell.h"

@interface CommentsTableViewController : UITableViewController <UITabInputViewDelegate>

@property (nonatomic, strong) UILabel * noRowsLabel;
@property (nonatomic, strong) UIView * noRowsView;

@property (nonatomic, strong) NSString * area;

@property NSInteger affectedId;

@property (nonatomic, strong) UITabInputView * tabInput;

@property (nonatomic, strong) NSMutableArray * sections; // AKA: datetimes.

@property (nonatomic, strong) NSMutableArray *  comments;

@property (nonatomic, strong) TComment * currentComment;

@property (nonatomic, strong) NSDateFormatter * dateFormatter;

@property (nonatomic, strong) UIAlertView * alert;

@end
