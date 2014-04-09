//
//  AutoCompletesCommunicator.m
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import "TSweetAutoCompletesCommunicator.h"

@implementation AutoCompletesCommunicator

+(id)shared
{
    static AutoCompletesCommunicator * shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

-(TSweetResponse *)majors:(NSString *)query
{
    NSString * route = [NSString stringWithFormat:@"/majors/autocomplete/%@", query];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)companies:(NSString *)query
{
    NSString * route = [NSString stringWithFormat:@"/companies/autocomplete/%@", query];
    return [[TSweetRest shared] get:route];
}

@end
