//
//  AddEventViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/19/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSweetResponse.h"
#import "TSweetCirclesCommunicator.h"
#import "TSweetEventsCommunicator.h"

#import "FXForms.h"
#import "AddEventForm.h"

@interface AddEventViewController : FXFormViewController

@property (nonatomic, strong) AddEventForm * form;

@end
