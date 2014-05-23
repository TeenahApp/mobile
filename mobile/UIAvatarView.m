//
//  UIAvatarView.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/20/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UIAvatarView.h"

@implementation UIAvatarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithURL:(NSURL *)url frame: (CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Initialization code
        
        // Read a default (avatar).
        // TODO: Chagne this avatar into something more beautic.
        self.image = [UIImage imageNamed:@"Avatar"];  
    
        if (url != nil)
        {
        
            // Try to load the URL.
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
                NSData * imageData = [NSData dataWithContentsOfURL:url];
            
                // Load the URL.
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    // TODO: If the image is not nil.
                    self.image = [UIImage imageWithData:imageData];
                });
            
                // Done.
            
            });
            
        }
        
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 4;
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
