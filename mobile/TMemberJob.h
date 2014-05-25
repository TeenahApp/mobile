//
//  TMemberJob.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TJobCompany.h"

@interface TMemberJob : NSObject

@property NSInteger memberJobId;

@property NSInteger memberId;
@property NSInteger companyId;

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * status;

@property NSInteger startYear;
@property NSInteger finishYear;

// major.
@property (nonatomic, strong) TJobCompany * company;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

// TODO: member.

-(id) initWithJson: (NSDictionary *) json;

@end
