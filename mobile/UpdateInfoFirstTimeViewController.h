//
//  UpdateInfoFirstTimeViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UICKeyChainStore.h>

#import "FXForms.h"
#import "UpdateMemberFirstTimeForm.h"

@interface UpdateInfoFirstTimeViewController : FXFormViewController

@property (strong, nonatomic) UpdateMemberFirstTimeForm * form;

@end
