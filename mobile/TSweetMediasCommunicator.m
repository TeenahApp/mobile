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

-(TSweetResponse *) likeMedia:(NSInteger)mediaId
{
    NSString * route = [NSString stringWithFormat:@"/medias/%ld/like", (long)mediaId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) commentOnMedia:(NSInteger)mediaId comment:(NSString *)comment
{
    NSString * route = [NSString stringWithFormat:@"/medias/%ld/comment", (long)mediaId];
    NSDictionary * parameters = @{
                                  @"comment": comment
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *) likeCommentOnMedia:(NSInteger)mediaId commentId:(NSInteger)commentId
{
    NSString * route = [NSString stringWithFormat:@"/medias/%ld/comments/%ld/like", (long)mediaId, (long)commentId];
    return [[TSweetRest shared] get:route];
}

@end
