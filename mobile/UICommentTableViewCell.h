//
//  CommentTableViewCell.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICommentTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *memberPhoto;

@property (weak, nonatomic) IBOutlet UILabel *memberNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
