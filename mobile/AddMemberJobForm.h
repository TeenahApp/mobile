//
//  AddMemberJobForm.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface AddMemberJobForm : NSObject <FXForm>

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * company;

@property (nonatomic, strong) NSMutableArray * years;

@property NSInteger startYear;
@property NSInteger finishYear;

@property (nonatomic, strong) NSString * status;

@property (nonatomic, strong) NSArray * statusKeys;
@property (nonatomic, strong) NSArray * statusValues;

-(id)initWithStatuses: (NSMutableDictionary *)statuses;

@end
