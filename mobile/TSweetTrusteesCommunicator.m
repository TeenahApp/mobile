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

-(TSweetResponse *)getTrustees
{
    NSString * route = [NSString stringWithFormat:@"/trustees"];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)create:(NSInteger)memberId
{
    NSString * route = [NSString stringWithFormat:@"/trustees"];
    NSDictionary * parameters = @{
                                  @"id": [NSNumber numberWithInteger:memberId]
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)deactivate:(NSInteger)memberId
{
    NSString * route = [NSString stringWithFormat:@"/trustees/%ld/deactivate", (long)memberId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)activate:(NSInteger)memberId
{
    NSString * route = [NSString stringWithFormat:@"/trustees/%ld/activate", (long)memberId];
    return [[TSweetRest shared] get:route];
}

@end
