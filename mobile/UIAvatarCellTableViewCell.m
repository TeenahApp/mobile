//
//  UIAvatarCellTableViewCell.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/15/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UIAvatarCellTableViewCell.h"

@implementation UIAvatarCellTableViewCell

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
    
    // TODO: This actually does not work.
    self.photo.frame = CGRectMake(0, 0, 60, 60);
    
    self.photo.layer.cornerRadius = 46;
    self.photo.layer.masksToBounds = YES;
    self.photo.layer.borderWidth = 4;
    
    self.photo.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
