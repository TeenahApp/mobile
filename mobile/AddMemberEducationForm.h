//
//  AddMemberEducationForm.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/25/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface AddMemberEducationForm : NSObject <FXForm>

@property (nonatomic, strong) NSString * degree;

@property (nonatomic, strong) NSMutableArray * years;

@property NSInteger startYear;
@property NSInteger finishYear;

@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * major;

@property (nonatomic, strong) NSArray * degreeKeys;
@property (nonatomic, strong) NSArray * degreeValues;

@property (nonatomic, strong) NSArray * statusKeys;
@property (nonatomic, strong) NSArray * statusValues;

-(id)initWithDegrees: (NSMutableDictionary *)degrees statuses: (NSMutableDictionary *)statuses;

@end
