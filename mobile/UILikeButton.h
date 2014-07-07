//
//  UILikeButton.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 9/8/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILikeButton : UIButton

@property NSInteger affectedId;
@property NSInteger commentId;

@property (nonatomic, strong) NSIndexPath * indexPath;

@end
