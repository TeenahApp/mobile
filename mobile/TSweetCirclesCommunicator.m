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

-(TSweetResponse *) getCircles
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

-(TSweetResponse *) getMembers:(NSInteger)circleId
{
    NSString * route = [NSString stringWithFormat:@"/circles/%d/members", circleId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) createMembers:(NSInteger)circleId members:(NSArray *)members
{
    NSString * route = [NSString stringWithFormat:@"/circles/%d/members", circleId];
    NSDictionary * parameters = @{ @"members": members };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *) leave:(NSInteger)circleId
{
    NSString * route = [NSString stringWithFormat:@"/circles/%d/leave", circleId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) getEvents:(NSInteger)circleId
{
    NSString * route = [NSString stringWithFormat:@"/circles/%d/events", circleId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) getStats:(NSInteger)circleId
{
    NSString * route = [NSString stringWithFormat:@"/circles/%d/stats", circleId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) fetchMessages:(NSInteger)circleId
{
    NSString * route = [NSString stringWithFormat:@"/circles/%d/messages", circleId];
    return [[TSweetRest shared] get:route];
}

@end
