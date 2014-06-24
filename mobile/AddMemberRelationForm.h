//
//  AddMemberRelationForm.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/22/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface AddMemberRelationForm : NSObject <FXForm>

@property (nonatomic, strong) NSString * relationship;

@property (nonatomic, strong) NSArray * relationKeys;
@property (nonatomic, strong) NSArray * relationValues;

@property (nonatomic, strong) NSString * secondRelationship;

@property (nonatomic, strong) NSArray * secondRelationKeys;
@property (nonatomic, strong) NSArray * secondRelationValues;

@property BOOL isRoot;

@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;

@property (nonatomic, strong) NSDate * dob;
@property BOOL isAlive;
@property (nonatomic, strong) NSDate * dod;

-(id)initWithRelations: (NSMutableDictionary *)relations;

@end
