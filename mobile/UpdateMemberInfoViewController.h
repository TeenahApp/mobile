//
//  UpdateMemberInfoViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

#import "FXForms.h"
#import "UpdateMemberInfoForm.h"

#import "TSweetRest.h"
#import "TSweetMembersCommunicator.h"

#import "TMember.h"

@interface UpdateMemberInfoViewController : FXFormViewController

@property (nonatomic, strong) UpdateMemberInfoForm * form;

@property (nonatomic, strong) TMember * member;

@property (nonatomic, strong) UIAlertView * alert;

@property (nonatomic, strong) TSweetResponse * updateResponse;

@end
