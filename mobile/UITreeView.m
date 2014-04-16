//
//  UITreeView.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UITreeView.h"

@implementation UITreeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(TSweetResponse *)getMember:(NSString *)memberId
{
    TSweetResponse * tsr = [[MembersCommunicator shared] get:memberId];
    
    self.member = [[TMember alloc] init];
    
    if (tsr.code == 200)
    {
        [self.member fromJson:tsr.json];
        [self draw];
    }
    
    return tsr;
}

-(void)draw
{
    NSLog(@"Draw member");
    
    NSURL * imageURL = [NSURL URLWithString:self.member.photo];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    UIImageView * myImageView = [[UIImageView alloc] initWithImage:image];
    
    myImageView.frame = CGRectMake(0, 0, 60, 60);
    myImageView.center = self.center;
    
    myImageView.layer.cornerRadius = 30;
    myImageView.layer.masksToBounds = YES;
    myImageView.layer.borderWidth = 4;
    
    myImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [name setText:self.member.name];
    [self addSubview:name];
    
    [self addSubview:myImageView];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //NSLog(@"Draw Rect");
    
    /*
    // Drawing code
    [super drawRect:rect];
    
    NSURL * imageURL = [NSURL URLWithString:@"https://pbs.twimg.com/profile_images/378800000798785125/3a3fc94a88d08a4c558edda49c47b86e.png"];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    UIImageView * myImageView = [[UIImageView alloc] initWithImage:image];
    
    myImageView.frame = CGRectMake(0, 0, 60, 60);
    myImageView.center = self.center;
    
    myImageView.layer.cornerRadius = 30;
    myImageView.layer.masksToBounds = YES;
    myImageView.layer.borderWidth = 4;
    
    myImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self addSubview:myImageView];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat x0 = CGRectGetMidX(rect);
    CGFloat y0 = CGRectGetMidY(rect);
    
    int children = 4;
    
    CGFloat angle = 180.0/(children+1);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 3.5f);
    
    int slength = 100;
    
    for(int i=1; i<=children; i++)
    {
        NSLog(@"%f", angle*i);
        
        CGFloat x = ((M_PI * (angle * i))/ 180);
        
        CGFloat x1 = cos(x) * slength + x0;
        CGFloat y1 = sin(x) * slength + y0;
        
        CGContextMoveToPoint(context, x0, y0);
        CGContextAddLineToPoint(context, x1, y1);
        CGContextStrokePath(context);
        
        UIButton * node = [[UIButton alloc] initWithFrame:CGRectMake(x1, y1, 80, 20)];
        
        [node setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        
        node.center = CGPointMake(x1, y1);
        
        [node addTarget:self.delegate action:@selector(didClickOnSubNode) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self addSubview:node];
    }
     */

}


@end
