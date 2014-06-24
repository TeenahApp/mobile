//
//  UITreeView.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIAvatarView.h"

#import "TMember.h"
#import "TSweetResponse.h"
#import "TSweetMembersCommunicator.h"
#import "AddMemberRelationViewController.h"

@protocol UITreeViewDelegate <NSObject>

-(void) didAddMother;
-(void) didAddFather;

-(void) didAddSister;
-(void) didAddBrother;

-(void) didAddDaughter;
-(void) didAddSon;

-(void) didAddHusband;
-(void) didAddWife;

-(void) didUpdateMember: (TMember *) member;

-(void) didViewMember;

@end

@interface UITreeView : UIView

@property (nonatomic, assign) id<UITreeViewDelegate> delegate;

@property (strong, atomic) TMember * member;
@property (strong, atomic) NSString * relation;
@property (strong, atomic) UIView * relationsView;

-(TSweetResponse *) getMember: (NSInteger) memberId;

-(void) draw;
-(void) addRelation;
-(void) viewMember;
-(void) handleSingleTap:(UITapGestureRecognizer *)recognizer;

@end
