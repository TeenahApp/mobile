//
//  UIAvatarView.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/20/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAvatarView : UIImageView

@property (strong, nonatomic) UIImage * image;

-(id) initWithURL: (NSURL *) url frame: (CGRect)frame;

@end
