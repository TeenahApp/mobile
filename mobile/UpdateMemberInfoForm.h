//
//  UpdateMemberInfoForm.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface UpdateMemberInfoForm : NSObject <FXForm>

@property (nonatomic, strong) NSString * displayName;

@property (nonatomic, strong) NSArray * maritalStatusKeys;
@property (nonatomic, strong) NSArray * maritalStatusValues;

@property (nonatomic, strong) NSString * maritalStatus;

@property BOOL isAlive;

@property (nonatomic, strong) NSDate * dob;
@property (nonatomic, strong) NSString * pob;

@property (nonatomic, strong) NSDate * dod;
@property (nonatomic, strong) NSString * pod;

@property (nonatomic, strong) NSString * email;

-(id)initWithMaritalStatuses:(NSMutableDictionary *)maritalStatuses;

@end
