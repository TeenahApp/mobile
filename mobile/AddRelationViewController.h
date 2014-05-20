//
//  AddRelationViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/22/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSweetResponse.h"
#import "TSweetMembersCommunicator.h"

@interface AddRelationViewController : UIViewController

@property (strong, nonatomic) NSString * relation;
@property NSInteger memberA;

@property (weak, nonatomic) IBOutlet UISegmentedControl *isRootSegmented;

@property (weak, nonatomic) IBOutlet UITextField *keyTextField;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *dobTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *isAliveSegmented;
@end
