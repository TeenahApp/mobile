//
//  CirclesCommunicator.h
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSweetResponse.h"
#import "TSweetRest.h"

@interface CirclesCommunicator : NSObject

+(id) shared;

-(TSweetResponse *) getCircles;

-(TSweetResponse *) create: (NSString *) name
                   members: (NSArray *) members;

-(TSweetResponse *) getMembers: (NSInteger) circleId;

-(TSweetResponse *) createMembers: (NSInteger) circleId
                           members: (NSArray *) members;

-(TSweetResponse *) leave: (NSInteger) circleId;

-(TSweetResponse *) getEvents: (NSInteger) circleId;

-(TSweetResponse *) getStats: (NSInteger) circleId;

-(TSweetResponse *) fetchMessages: (NSInteger) circleId;

@end
