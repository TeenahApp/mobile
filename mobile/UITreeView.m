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
    
    // Then add the whole view to the main view.
    //[self addSubview:self.relationsView];
    
    if (tsr.code == 200)
    {
        [self.member fromJson:tsr.json];
        //[self draw];
        
        [self drawRect:self.frame];
        
        // Call the delegate.
        NSLog(@"string ----- %@", self.member.memberId);
        
        // Update the member id in the add relation view.
        [self.delegate didUpdateMember: self.member.memberId];
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
    [self addSubview:myImageView];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [name setText:self.member.name];
    [self addSubview:name];
    
    UIButton * addRelationButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addRelationButton setTitle:@"Add" forState:UIControlStateNormal];
    addRelationButton.center = CGPointMake(myImageView.center.x + 60, myImageView.center.y);
    
    [addRelationButton addTarget:self action:@selector(addRelation) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:addRelationButton];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    /*
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 3.5f);
    
    // TODO: Add relations.
    CGContextMoveToPoint(context, myImageView.center.x, myImageView.center.y);
    CGContextAddLineToPoint(context, 200, 200);
    CGContextStrokePath(context);
    
    UIButton * node = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 80, 20)];
    
    [node setTitle:[NSString stringWithFormat:@"%d", 1] forState:UIControlStateNormal];
    
    //node.center = CGPointMake(x1, y1);
     */
    
}

-(void)addRelation
{
    //NSLog(@"Hello world");
    [self addSubview:self.relationsView];
    
    //[self.relationsView removeFromSuperview];
    
    //UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //AddRelationViewController * addRelationVC = [[AddRelationViewController alloc] init];
    //[self presentViewController:addRelationVC animated:YES completion:nil];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"Draw Rect");
    
    
    // Drawing code
    [super drawRect:rect];
    
    /*
    
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
    
    UITapGestureRecognizer * singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleSingleTap:)];
    
    self.relationsView = [[UIView alloc] initWithFrame:self.frame];
    self.relationsView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self.relationsView addGestureRecognizer:singleFingerTap];
    
    // Add buttons.
    
    // Mother.
    UIButton * addMotherButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addMotherButton setTitle:@"Mother" forState:UIControlStateNormal];
    addMotherButton.center = CGPointMake(self.center.x - 100, self.center.y - 100);
    [self.relationsView addSubview:addMotherButton];
    
    // Father.
    UIButton * addFatherButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addFatherButton setTitle:@"Father" forState:UIControlStateNormal];
    addFatherButton.center = CGPointMake(self.center.x, self.center.y - 100);
    [self.relationsView addSubview:addFatherButton];
    
    [addFatherButton addTarget:self.delegate action:@selector(didAddFather) forControlEvents:UIControlEventTouchUpInside];
    
    // Partner.
    UIButton * addPartnerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addPartnerButton setTitle:@"Partner" forState:UIControlStateNormal];
    addPartnerButton.center = CGPointMake(self.center.x + 100, self.center.y - 100);
    [self.relationsView addSubview:addPartnerButton];
    
    // Sister.
    UIButton * addSisterButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addSisterButton setTitle:@"Sister" forState:UIControlStateNormal];
    addSisterButton.center = CGPointMake(self.center.x - 100, self.center.y);
    [self.relationsView addSubview:addSisterButton];
    
    // Brother.
    UIButton * addBrotherButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addBrotherButton setTitle:@"Brother" forState:UIControlStateNormal];
    addBrotherButton.center = CGPointMake(self.center.x + 100, self.center.y);
    [self.relationsView addSubview:addBrotherButton];
    
    // Daughter.
    UIButton * addDaughterButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addDaughterButton setTitle:@"Daughter" forState:UIControlStateNormal];
    addDaughterButton.center = CGPointMake(self.center.x - 100, self.center.y + 100);
    [self.relationsView addSubview:addDaughterButton];
    
    // Son.
    UIButton * addSonButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addSonButton setTitle:@"Son" forState:UIControlStateNormal];
    addSonButton.center = CGPointMake(self.center.x, self.center.y + 100);
    [self.relationsView addSubview:addSonButton];
    
    // Other.
    UIButton * addOtherButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addOtherButton setTitle:@"Other" forState:UIControlStateNormal];
    addOtherButton.center = CGPointMake(self.center.x + 100, self.center.y + 100);
    [self.relationsView addSubview:addOtherButton];

}

-(void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    //NSLog(@"Helloworld");
    [self.relationsView removeFromSuperview];
}


@end
