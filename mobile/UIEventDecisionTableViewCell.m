//
//  UIEventDecisionTableViewCell.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UIEventDecisionTableViewCell.h"

@implementation UIEventDecisionTableViewCell

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
    NSLog(@"UIEventDecisionTableViewCell");
    
    // Will come button.
    
    self.willComeButton.backgroundColor = [UIColor greenColor];
    [self.willComeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // Apologize button.
    self.apologizeButton.backgroundColor = [UIColor redColor];
    [self.apologizeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.willComeButton addTarget:self.delegate action:@selector(didSayWillCome) forControlEvents:UIControlEventTouchUpInside];
    [self.apologizeButton addTarget:self.delegate action:@selector(didSayApologize) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
