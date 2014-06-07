//
//  AddMemberEducationViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/25/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FXForms.h"
#import "AddMemberEducationForm.h"

#import "TSweetRest.h"
#import "TSweetMembersCommunicator.h"

@interface AddMemberEducationViewController : FXFormViewController

@property (nonatomic, strong) AddMemberEducationForm * form;

@property NSInteger memberId;

@property (nonatomic, strong) UIAlertView * alert;

@end
