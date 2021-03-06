//
//  TCircle.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/10/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMember.h"

@interface TCircle : NSObject

@property NSInteger circleId;

@property (strong, nonatomic) NSString * name;

@property BOOL isActive;

@property NSInteger membersCount;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

@property NSInteger createdBy;
@property (nonatomic, strong) TMember * creator;

// TODO: members.

-(id) initWithJson: (NSDictionary *) json;

@end
