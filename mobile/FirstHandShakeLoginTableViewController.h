//
//  FirstHandShakeLoginTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/3/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSweetResponse.h"
#import "TSweetUsersCommunicator.h"

#import <MBProgressHUD.h>

#import "SecondHandShakeLoginTableViewController.h"

@interface FirstHandShakeLoginTableViewController : UITableViewController

@property (nonatomic, strong) NSString * mobile;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendTempPasswordButton;

@property (nonatomic, strong) TSweetResponse * tokenizeResponse;

@property (nonatomic, strong) UIAlertView * alert;

@end
