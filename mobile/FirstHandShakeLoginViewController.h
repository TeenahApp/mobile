//
//  FirstHandShakeLoginViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/10/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSweetResponse.h"
#import "TSweetUsersCommunicator.h"
#import "SecondHandShakeLoginViewController.h"

@interface FirstHandShakeLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendSMSButton;

@end
