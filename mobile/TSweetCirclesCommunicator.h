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

-(TSweetResponse *) get;

-(TSweetResponse *) create: (NSString *) name
                   members: (NSString *) members;

-(TSweetResponse *) getMembers: (NSString *) circleId;

-(TSweetResponse *) createMembers: (NSString *) circleId
                           members: (NSString *) members;

-(TSweetResponse *) leave: (NSString *) circleId;

-(TSweetResponse *) getEvents: (NSString *) circleId;

-(TSweetResponse *) getStats: (NSString *) circleId;

-(TSweetResponse *) fetchMessages: (NSString *) circleId;

@end
