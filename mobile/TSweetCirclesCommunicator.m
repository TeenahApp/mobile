//
//  CirclesCommunicator.m
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import "TSweetCirclesCommunicator.h"

@implementation CirclesCommunicator

+(id)shared
{
    static CirclesCommunicator * shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

-(TSweetResponse *) get
{
    NSString * route = [NSString stringWithFormat:@"/circles"];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) create: (NSString *) name
                   members: (NSString *) members
{
    NSString * route = [NSString stringWithFormat:@"/circles"];
    NSDictionary * parameters = @{
                                  @"name": name,
                                  @"members": members
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *) getMembers: (NSString *) circleId
{
    NSString * route = [NSString stringWithFormat:@"/circles/%@", circleId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) createMembers: (NSString *) circleId
                          members: (NSString *) members
{
    NSString * route = [NSString stringWithFormat:@"/circles/%@/members", circleId];
    NSDictionary * parameters = @{ @"members": members };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *) leave: (NSString *) circleId
{
    NSString * route = [NSString stringWithFormat:@"/circles/%@/leave", circleId];
    
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) getEvents: (NSString *) circleId
{
    NSString * route = [NSString stringWithFormat:@"/circles/%@/events", circleId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) getStats: (NSString *) circleId
{
    NSString * route = [NSString stringWithFormat:@"/circles/%@/stats", circleId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) fetchMessages: (NSString *) circleId
{
    NSString * route = [NSString stringWithFormat:@"/circles/%@/messages", circleId];
    return [[TSweetRest shared] get:route];
}

@end
