//
//  AddMemberRelationViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/22/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import <AddressBookUI/AddressBookUI.h>

#import "TSweetResponse.h"
#import "TSweetMembersCommunicator.h"

#import "FXForms.h"
#import "AddMemberRelationForm.h"

@interface AddMemberRelationViewController : FXFormViewController <ABPeoplePickerNavigationControllerDelegate>

@property (strong, nonatomic) AddMemberRelationForm * form;
@property (strong, nonatomic) NSMutableArray * acceptedRelations;
@property (strong, nonatomic) NSString * relation;
@property NSInteger memberA;

@property (nonatomic, strong) UIAlertView * alert;

-(NSString *)mobileFormatWithString:(NSString *)mobile;

@end
