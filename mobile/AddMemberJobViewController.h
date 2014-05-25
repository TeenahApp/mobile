//
//  AddMemberJobViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FXForms.h"
#import "AddMemberJobForm.h"

#import "TSweetRest.h"
#import "TSweetMembersCommunicator.h"

@interface AddMemberJobViewController : FXFormViewController

@property (nonatomic, strong) AddMemberJobForm * form;
@property NSInteger memberId;

@end
