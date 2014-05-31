//
//  CommentTableViewCell.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

// TODO: Fix the lining issue.
// TODO: Fix the avatar.

#import <UIKit/UIKit.h>

#import "TComment.h"

#define kPadding 8

#define kAvatarSize 44

#define kAvatarPercentage 20
#define kDisplayNamePercentage 60
#define kLikeIconPercentage 10
#define kLikesCountPercentage 10
#define kDatetimePercentage 80

@interface UICommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton * likeButton;

-(void)initWithComment:(TComment *)comment;

+(CGFloat)cellHeightWithContent:(NSString *)content width:(CGFloat)width;
+(UILabel *)getContentLabelWithContent:(NSString *)content width:(CGFloat)width;

@end
