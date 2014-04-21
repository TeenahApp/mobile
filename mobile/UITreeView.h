//
//  UITreeView.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TMember.h"
#import "TSweetResponse.h"
#import "TSweetMembersCommunicator.h"
#import "AddRelationViewController.h"

@protocol UITreeViewDelegate <NSObject>

-(void) didAddRelation;

@end

@interface UITreeView : UIView

@property (nonatomic, assign) id<UITreeViewDelegate> delegate;

@property (strong, atomic) TMember * member;
@property (strong, atomic) NSString * relation;
@property (strong, atomic) UIView * relationsView;

-(TSweetResponse *) getMember: (NSString *) memberId;
-(void) draw;
-(void) addRelation;
-(void) handleSingleTap:(UITapGestureRecognizer *)recognizer;

@end
