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

@interface TreeViewController : UIViewController<UITreeViewDelegate>

@property (strong, nonatomic) UITreeView * treeView;
@property (strong, nonatomic) NSString * relation;
@property (strong, nonatomic) NSString * memberId;

// UITreeView * treeView;
-(void) showAddRelations;

@end
