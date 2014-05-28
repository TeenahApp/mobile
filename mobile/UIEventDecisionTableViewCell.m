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
    
    self.willComeButton.buttonColor = [UIColor turquoiseColor];
    self.willComeButton.shadowColor = [UIColor greenSeaColor];
    
    //self.willComeButton.shadowHeight = 3.0f;
    //self.willComeButton.cornerRadius = 6.0f;
    
    //self.willComeButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    
    [self.willComeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    
    // Apologize button.
    self.apologizeButton.buttonColor = [UIColor alizarinColor];
    self.apologizeButton.shadowColor = [UIColor pomegranateColor];
    
    //self.apologizeButton.shadowHeight = 3.0f;
    //self.apologizeButton.cornerRadius = 6.0f;
    
    //self.apologizeButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    
    [self.apologizeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    
    [self.willComeButton addTarget:self.delegate action:@selector(didSayWillCome) forControlEvents:UIControlEventTouchUpInside];
    [self.apologizeButton addTarget:self.delegate action:@selector(didSayApologize) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
