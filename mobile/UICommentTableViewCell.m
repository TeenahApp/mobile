//
//  CommentTableViewCell.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UICommentTableViewCell.h"

@implementation UICommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    NSLog(@"awakeFromNib");
}

-(void)initWithComment:(TComment *)comment
{
    CGFloat cellWidth = self.contentView.bounds.size.width-(kPadding*2);
    //NSLog(@"cell height = %f", cellWidth);
    
    UIImage * image = [UIImage imageNamed:@"Avatar"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPadding, kPadding, kAvatarSize, kAvatarSize)];
    
    [imageView setImage:image];
    
    // Add the image.
    [self.contentView addSubview:imageView];
    
    // Creator.
    UILabel * creatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAvatarSize+(kPadding*2), kPadding, 200, kAvatarSize/2)];
    
    creatorLabel.font = [UIFont boldSystemFontOfSize:14];
    creatorLabel.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    
    [creatorLabel setText:comment.creator.fullname];
    
    [self.contentView addSubview:creatorLabel];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyyy HH:mm:ss"];
    
    // Created At.
    UILabel * createdAtLable = [[UILabel alloc] initWithFrame:CGRectMake(kAvatarSize+(kPadding*2), (kAvatarSize/2)+kPadding, 200, kAvatarSize/2)];
    
    createdAtLable.font = [UIFont systemFontOfSize:14];
    createdAtLable.textColor = [UIColor grayColor];
    
    [createdAtLable setText:[dateFormatter stringFromDate:comment.createdAt]];
    
    [self.contentView addSubview:createdAtLable];
    
    // Like Button
    UIImage * likeImage = [UIImage imageNamed:@"Heart"];
    
    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    self.likeButton.frame = CGRectMake(260, kPadding+4, kAvatarSize/2, 16);
    self.likeButton.tag = comment.commentId;
    
    [self.likeButton setBackgroundImage:likeImage forState:UIControlStateNormal];
    
    if (comment.hasLiked == YES)
    {
        [self.likeButton setEnabled:NO];
    }
    
    [self.contentView addSubview:self.likeButton];
    
    // Likes Count Label.
    UILabel * likesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(260+(kAvatarSize/2), kPadding, 30, kAvatarSize/2)];

    likesCountLabel.font = [UIFont systemFontOfSize:14];
    
    [likesCountLabel setText:[NSString stringWithFormat:@"%d", comment.likesCount]];
    
    [self.contentView addSubview:likesCountLabel];
    
    UILabel * label = [UICommentTableViewCell getContentLabelWithContent:comment.content width:cellWidth];
    label.frame = CGRectMake(kPadding, (kPadding*2)+kAvatarSize, label.frame.size.width, label.frame.size.height);
    
    [self.contentView addSubview:label];
}

+(CGFloat)cellHeightWithContent:(NSString *)content width:(CGFloat)width
{
    UILabel * tempLabel = [UICommentTableViewCell getContentLabelWithContent:content width:width];
    return (kPadding*3) + kAvatarSize + tempLabel.frame.size.height;
}

+(UILabel *)getContentLabelWithContent:(NSString *)content width:(CGFloat)width
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(kPadding, kPadding, width, 10)];
    
    label.numberOfLines = 0;
    
    //label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:15];
    
    label.text = content;
    
    [label sizeToFit];
    
    return label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
