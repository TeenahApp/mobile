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

#import "FXForms.h"
#import "AddRelationForm.h"

@interface AddRelationViewController : FXFormViewController

@property (strong, nonatomic) AddRelationForm * form;
@property (strong, nonatomic) NSString * relation;
@property NSInteger memberA;

@end
