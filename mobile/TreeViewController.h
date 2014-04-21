//
//  TreeViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITreeView.h"

@interface TreeViewController : UIViewController<UITreeViewDelegate>

@property (strong, nonatomic) UITreeView * treeView;

// UITreeView * treeView;

@end
