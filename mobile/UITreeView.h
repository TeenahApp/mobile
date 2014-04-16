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

@interface UITreeView : UIView

@property (strong, atomic) TMember * member;

-(TSweetResponse *) getMember: (NSString *) memberId;
-(void) draw;

@end
