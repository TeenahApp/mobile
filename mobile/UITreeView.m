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

-(TSweetResponse *) goToGetMember: (id) sender
{
    UIButton * button = (UIButton *) sender;
    return [self getMember: [NSString stringWithFormat:@"%d", button.tag]];
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
        [self draw];
        
        // Call the delegate.
        NSLog(@"string ----- %@", self.member.memberId);
        
        // Update the member id in the add relation view.
        [self.delegate didUpdateMember: self.member];
    }
    
    return tsr;
}

-(void) viewMember
{
    [self.delegate didViewMember];
}

-(void)draw
{
    [[self subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    NSLog(@"Draw member");
    
    NSURL * imageURL = nil;
    
    if ([self.member.photo isEqual:[NSNull null]])
    {
        // TODO: Fix the image regarding to the gender of the member.
        //       Display a man with Shmagh, and a woman whit a Hijab.
        NSLog(@"============= Nil");
        imageURL = [NSURL URLWithString:@"http://i2.wp.com/www.maas360.com/assets/Uploads/defaultUserIcon.png"];
    }
    else
    {
        NSLog(@"============= Not nil");
        imageURL = [NSURL URLWithString:self.member.photo];
    }

    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    UIImageView * myImageView = [[UIImageView alloc] initWithImage:image];
    
    myImageView.frame = CGRectMake(0, 0, 60, 60);
    myImageView.center = self.center;
    
    myImageView.layer.cornerRadius = 30;
    myImageView.layer.masksToBounds = YES;
    myImageView.layer.borderWidth = 4;
    
    myImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [myImageView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewMember)];
    
    [myImageView addGestureRecognizer:tapper];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(0, myImageView.center.y + 120, self.frame.size.width, 80)];
    
    NSString * currentName = [NSString stringWithFormat:@"(%@)\n%@", self.member.fullname, self.member.dob];
    
    [name setText:currentName];
    
    name.textAlignment = NSTextAlignmentCenter;
    name.numberOfLines = 2;
    
    [self addSubview:name];
    
    UIButton * addRelationButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addRelationButton setTitle:@"Add" forState:UIControlStateNormal];
    addRelationButton.center = CGPointMake(myImageView.center.x + 60, myImageView.center.y);
    
    [addRelationButton addTarget:self action:@selector(addRelation) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:addRelationButton];
    
    NSLog(@"%@", self.member.father);
    
    if (self.member.father != nil) {
        
        NSLog(@"CALlllllllllled");
        
        // Add father.
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(myImageView.center.x, myImageView.center.y)];
        [path addLineToPoint:CGPointMake(myImageView.center.x, myImageView.center.y - 100)];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [path CGPath];
        shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 3.0;
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        
        UIButton * fatherButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        [fatherButton setTitle:self.member.father.name forState:UIControlStateNormal];
        fatherButton.center = CGPointMake(myImageView.center.x, myImageView.center.y - 120);
        
        fatherButton.tag = [self.member.father.memberId intValue];
        [fatherButton addTarget:self action:@selector(goToGetMember:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:fatherButton];
        [self.layer addSublayer:shapeLayer];
    }
    
    NSLog(@"-------- CHILDREN: %d ---------------- ", [self.member.children count]);
    
    if ([self.member.children count] > 0) {
        
        int children = [self.member.children count];
        int i = 1;
        
        CGFloat angle = 180.0/(children+1);
        
        //for(int i=1; i<=children; i++)
        for (NSString * key in self.member.children)
        {
            TMember * node = (TMember *) [self.member.children objectForKey:key];
            
            NSLog(@"%f", angle*i);
            
            CGFloat x = ((M_PI * (angle * i))/ 180);
            
            CGFloat x1 = cos(x) * 100 + myImageView.center.x;
            CGFloat y1 = sin(x) * 100 + myImageView.center.y;
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(myImageView.center.x, myImageView.center.y)];
            [path addLineToPoint:CGPointMake(x1, y1)];
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [path CGPath];
            shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 3.0;
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            
            UIButton * nodeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
            [nodeButton setTitle: node.name forState:UIControlStateNormal];
            nodeButton.center = CGPointMake(x1, y1 + 20);
            
            nodeButton.tag = [node.memberId intValue];
            [nodeButton addTarget:self action:@selector(goToGetMember:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:nodeButton];
            [self.layer addSublayer:shapeLayer];
            
            i++;
        }
        
    }
    
    [self addSubview:myImageView];
    
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
    [addMotherButton addTarget:self.delegate action:@selector(didAddMother) forControlEvents:UIControlEventTouchUpInside];
    
    // Father.
    UIButton * addFatherButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addFatherButton setTitle:@"Father" forState:UIControlStateNormal];
    addFatherButton.center = CGPointMake(self.center.x, self.center.y - 100);
    [self.relationsView addSubview:addFatherButton];
    [addFatherButton addTarget:self.delegate action:@selector(didAddFather) forControlEvents:UIControlEventTouchUpInside];
    
    // Partner.
    UIButton * addPartnerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    
    if ([self.member.gender isEqual: @"male"])
    {
        [addPartnerButton addTarget:self.delegate action:@selector(didAddWife) forControlEvents:UIControlEventTouchUpInside];
        [addPartnerButton setTitle:@"Wife" forState:UIControlStateNormal];
    }
    else
    {
        [addPartnerButton addTarget:self.delegate action:@selector(didAddHusband) forControlEvents:UIControlEventTouchUpInside];
        [addPartnerButton setTitle:@"Husband" forState:UIControlStateNormal];
    }
    
    addPartnerButton.center = CGPointMake(self.center.x + 100, self.center.y - 100);
    [self.relationsView addSubview:addPartnerButton];
    
    // Sister.
    UIButton * addSisterButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addSisterButton setTitle:@"Sister" forState:UIControlStateNormal];
    addSisterButton.center = CGPointMake(self.center.x - 100, self.center.y);
    [self.relationsView addSubview:addSisterButton];
    [addSisterButton addTarget:self.delegate action:@selector(didAddSister) forControlEvents:UIControlEventTouchUpInside];
    
    // Brother.
    UIButton * addBrotherButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addBrotherButton setTitle:@"Brother" forState:UIControlStateNormal];
    addBrotherButton.center = CGPointMake(self.center.x + 100, self.center.y);
    [self.relationsView addSubview:addBrotherButton];
    [addBrotherButton addTarget:self.delegate action:@selector(didAddBrother) forControlEvents:UIControlEventTouchUpInside];
    
    // Daughter.
    UIButton * addDaughterButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addDaughterButton setTitle:@"Daughter" forState:UIControlStateNormal];
    addDaughterButton.center = CGPointMake(self.center.x - 100, self.center.y + 100);
    [self.relationsView addSubview:addDaughterButton];
    [addDaughterButton addTarget:self.delegate action:@selector(didAddDaughter) forControlEvents:UIControlEventTouchUpInside];
    
    // Son.
    UIButton * addSonButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addSonButton setTitle:@"Son" forState:UIControlStateNormal];
    addSonButton.center = CGPointMake(self.center.x, self.center.y + 100);
    [self.relationsView addSubview:addSonButton];
    [addSonButton addTarget:self.delegate action:@selector(didAddSon) forControlEvents:UIControlEventTouchUpInside];
    
    // TODO: Add other relations view.
    /*
    // Other.
    UIButton * addOtherButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [addOtherButton setTitle:@"Other" forState:UIControlStateNormal];
    addOtherButton.center = CGPointMake(self.center.x + 100, self.center.y + 100);
    [self.relationsView addSubview:addOtherButton];
     */

}

-(void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    //NSLog(@"Helloworld");
    [self.relationsView removeFromSuperview];
}


@end
