//
//  UIMediaCollectionViewCell.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/1/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UIMediaCollectionViewCell.h"

@implementation UIMediaCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"initWithFrame");
    }
    return self;
}

-(void)awakeFromNib
{
    //NSLog(@"Hello World : awakeFrom");
}

-(void)loadImage:(NSURL *)URL
{
    self.image = [UIImage imageNamed:@"Avatar"];
    [self.imageView setImage:self.image];

    // Try to load the URL.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
        NSData * imageData = [NSData dataWithContentsOfURL:URL];
        
        self.image = [UIImage imageWithData:imageData];
            
        // Load the URL.
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self.imageView setImage:self.image];
        });
            
        // Done.
            
    });

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
