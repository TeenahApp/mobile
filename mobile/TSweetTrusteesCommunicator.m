//
//  TrusteesCommunicator.m
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import "TSweetTrusteesCommunicator.h"

@implementation TrusteesCommunicator

+(id)shared
{
    static TrusteesCommunicator * shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

-(TSweetResponse *)get
{
    NSString * route = [NSString stringWithFormat:@"/trustees"];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)create:(NSString *)memberId
{
    NSString * route = [NSString stringWithFormat:@"/trustees"];
    NSDictionary * parameters = @{
                                  @"id": memberId
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)deactivate:(NSString *)memberId
{
    NSString * route = [NSString stringWithFormat:@"/trustees/%@/deactivate", memberId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)activate:(NSString *)memberId
{
    NSString * route = [NSString stringWithFormat:@"/trustees/%@/activate", memberId];
    return [[TSweetRest shared] get:route];
}

@end
