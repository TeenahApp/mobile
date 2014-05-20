//
//  MediasCommunicator.m
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import "TSweetMediasCommunicator.h"

@implementation MediasCommunicator

+(id)shared
{
    static MediasCommunicator * shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

-(TSweetResponse *) like:(NSInteger)mediaId
{
    NSString * route = [NSString stringWithFormat:@"/medias/%d/like", mediaId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) comment:(NSInteger)mediaId comment:(NSString *)comment
{
    NSString * route = [NSString stringWithFormat:@"/medias/%d/comment", mediaId];
    NSDictionary * parameters = @{
                                  @"comment": comment
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *) likeComment:(NSInteger)mediaId commentId:(NSInteger)commentId
{
    NSString * route = [NSString stringWithFormat:@"/medias/%d/comments/%d", mediaId, commentId];
    return [[TSweetRest shared] get:route];
}

@end
