//
//  UIMultiColumnsTableViewCell.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/1/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPadding 10

@interface UIMultiColumnsTableViewCell : UITableViewCell

@property CGFloat columnHeight;
@property BOOL hasDrawn;

- (void)setColumns:(NSArray *)columns;

@end
