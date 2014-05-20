//
//  TMemberRelation.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/21/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMember.h"

@class TMember;

@interface TMemberRelation : NSObject

@property NSInteger relationId;

@property BOOL isActive;

@property NSInteger memberA;
@property NSInteger memberB;

@property (nonatomic, strong) NSString * relationship;

@property (nonatomic, strong) TMember * firstMember;
@property (nonatomic, strong) TMember * secondMember;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

-(id) initWithJson: (NSDictionary *) json;

@end
