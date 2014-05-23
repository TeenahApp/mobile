//
//  SocialMediasCommunicator.m
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import "TSweetSocialMediasCommunicator.h"

@implementation SocialMediasCommunicator

+(id)shared
{
    static SocialMediasCommunicator * shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

-(TSweetResponse *)create:(NSString *)name account:(NSString *)account
{
    NSString * route = [NSString stringWithFormat:@"/socialmedias"];
    NSDictionary * parameters = @{
                                  @"name": name,
                                  @"account": account
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)update:(NSInteger)socialMediaId account:(NSString *)account
{
    NSString * route = [NSString stringWithFormat:@"/socialmedias/%ld", (long)socialMediaId];
    NSDictionary * parameters = @{
                                  @"account": account
                                  };
    
    return [[TSweetRest shared] put:route parameters: parameters];
}

-(TSweetResponse *)deleteSocialMedia:(NSInteger)socialMediaId
{
    NSString * route = [NSString stringWithFormat:@"/socialmedias/%ld", (long)socialMediaId];
    return [[TSweetRest shared] delete:route parameters:nil];
}

@end
