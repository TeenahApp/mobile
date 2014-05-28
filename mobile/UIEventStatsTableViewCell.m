//
//  UIEventStatsTableViewCell.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UIEventStatsTableViewCell.h"

@implementation UIEventStatsTableViewCell

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
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(84, 0, 0.5f, self.bounds.size.height)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(156, 0, 0.5f, self.bounds.size.height)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    
    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(228, 0, 0.5f, self.bounds.size.height)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:lineView1];
    [self.contentView addSubview:lineView2];
    [self.contentView addSubview:lineView3];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
