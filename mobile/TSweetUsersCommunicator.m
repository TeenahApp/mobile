//
//  UsersCommunicator.m
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/1/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import "TSweetUsersCommunicator.h"

@implementation UsersCommunicator

+(id)shared
{
    static UsersCommunicator * shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

-(TSweetResponse *)tokenize:(NSString *)mobile
{
    NSString * route = [NSString stringWithFormat:@"/users/token/%@", mobile];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)login:(NSString *)mobile smsToken:(NSString *)smsToken
{
    return [[TSweetRest shared] post:@"/users/login"
                          parameters: @{@"mobile": mobile, @"sms_token": smsToken}];
}

-(TSweetResponse *)initialize:(NSString *)gender name:(NSString *)name dob:(NSString *)dob
{
    NSString * route = @"/users/members";
    return [[TSweetRest shared] post:route parameters:@{ @"gender": gender, @"name": name, @"dob": dob}];
}

-(TSweetResponse *)dashboard
{
    return [[TSweetRest shared] get:@"/users/dashboard"];
}

-(TSweetResponse *)logout
{
    return [[TSweetRest shared] get:@"/users/logout"];
}

@end
