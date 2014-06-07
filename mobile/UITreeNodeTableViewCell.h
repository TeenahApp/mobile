//
//  UITreeNodeTableViewCell.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/7/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITreeNodeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (weak, nonatomic) IBOutlet UIButton *dispalyNameButton;

@property (weak, nonatomic) IBOutlet UILabel *dobdodLabel;

@end
