//
//  SecondHandShakeLoginTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/4/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import <UICKeyChainStore.h>

#import "TSweetResponse.h"
#import "TSweetUsersCommunicator.h"

#import "UpdateInfoFirstTimeViewController.h"
#import "TreeViewController.h"

@interface SecondHandShakeLoginTableViewController : UITableViewController

@property NSInteger memberId;

@property (nonatomic, strong) NSString * mobile;

@property (weak, nonatomic) IBOutlet UITextField *smsTokenTextField;

@property (nonatomic, strong) TSweetResponse * loginResponse;

@property (nonatomic, strong) UIAlertView * alert;

@end
