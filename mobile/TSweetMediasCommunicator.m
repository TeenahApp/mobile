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

-(TSweetResponse *) like: (NSString *) mediaId
{
    NSString * route = [NSString stringWithFormat:@"/medias/%@/like", mediaId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) comment: (NSString *) mediaId
                    comment: (NSString *) comment
{
    NSString * route = [NSString stringWithFormat:@"/medias/%@/comment", mediaId];
    NSDictionary * parameters = @{
                                  @"comment": comment
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *) likeComment: (NSString *) mediaId
                      commentId: (NSString *) commentId
{
    NSString * route = [NSString stringWithFormat:@"/medias/%@/comments/%@", mediaId, commentId];
    return [[TSweetRest shared] get:route];
}

@end
