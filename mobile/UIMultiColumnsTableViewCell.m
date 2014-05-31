//
//  UIMultiColumnsTableViewCell.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/1/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UIMultiColumnsTableViewCell.h"

@implementation UIMultiColumnsTableViewCell

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
    // Set the column height.
    self.columnHeight = self.contentView.bounds.size.height;
}

// NSArray of objects.
- (void)setColumns:(NSArray *)columns
{
    // Notice: y is always zero.
    
    CGFloat columnWidth = self.contentView.bounds.size.width/columns.count;
    
    CGFloat x = 0;
    
    for (NSDictionary * column in columns)
    {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, columnWidth, self.columnHeight)];
        
        // Set the borders of the view.
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = .25f;
        
        // Heading.
        UILabel * headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPadding, kPadding, columnWidth-(kPadding*2), (self.columnHeight/2)-kPadding)];
        
        headingLabel.text = [NSString stringWithFormat:@"%@", [column objectForKey:@"count"]];
        headingLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        headingLabel.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        
        // Detail.
        UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPadding, (self.columnHeight/2), columnWidth-(kPadding*2), (self.columnHeight/2)-kPadding)];
        
        detailLabel.text = [NSString stringWithFormat:@"%@", [column objectForKey:@"label"]];
        detailLabel.font = [UIFont systemFontOfSize:13];
        detailLabel.textColor = [UIColor grayColor];
        
        // Add the labels to the column view.
        [view addSubview:headingLabel];
        [view addSubview:detailLabel];
        
        // Add the column view to the cell view.
        [self.contentView addSubview:view];
        
        x = x + columnWidth;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
