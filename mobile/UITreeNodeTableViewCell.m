//
//  UITreeNodeTableViewCell.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/7/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UITreeNodeTableViewCell.h"

@implementation UITreeNodeTableViewCell

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
    self.photo.layer.cornerRadius = self.photo.frame.size.width/2;
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
