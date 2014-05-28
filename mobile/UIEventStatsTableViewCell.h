//
//  UIEventStatsTableViewCell.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIEventStatsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *comingCountButton;
@property (weak, nonatomic) IBOutlet UIButton *likesCountButton;
@property (weak, nonatomic) IBOutlet UIButton *viewsCountButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsCountButton;

@end
