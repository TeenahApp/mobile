//
//  ViewEventCommentsTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITabInputView.h"

#import "TSweetResponse.h"
#import "TSweetEventsCommunicator.h"

#import "TComment.h"

#import "UICommentTableViewCell.h"

@interface ViewEventCommentsTableViewController : UITableViewController <UITabInputViewDelegate>

@property NSInteger eventId;

@property (nonatomic, strong) UITabInputView * tabInput;

@property (nonatomic, strong) NSMutableArray * sections; // AKA: datetimes.

@property (nonatomic, strong) NSMutableArray *  comments;

@end
