//
//  TreeViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITreeView.h"
#import "TreeViewController.h"
#import "ViewMemberTableViewController.h"

@interface TreeViewController : UIViewController<UITreeViewDelegate>

@property (strong, nonatomic) UITreeView * treeView;
@property (strong, nonatomic) NSString * relation;

@property NSInteger memberId;
@property (strong, nonatomic) TMember * member;

-(void) showAddRelations;

@end
