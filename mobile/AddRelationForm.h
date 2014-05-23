//
//  AddRelationForm.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/22/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface AddRelationForm : NSObject <FXForm>

@property (nonatomic, strong) NSString * relationship;

@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;

@property (nonatomic, strong) NSDate * dob;
@property BOOL isAlive;
@property (nonatomic, strong) NSDate * dod;

@property BOOL isRoot;

@end
