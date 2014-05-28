//
//  EventsCommunicator.m
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import "TSweetEventsCommunicator.h"

@implementation EventsCommunicator

+(id)shared
{
    static EventsCommunicator * shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

-(TSweetResponse *)getEvents
{
    NSString * route = [NSString stringWithFormat:@"/events"];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) create:(NSString *)title startDatetime:(NSDate *)startDatetime finishDatatime:(NSDate *)finishDatatime location:(NSString *)location circles:(NSArray *)circles latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude
{
    NSString * route = [NSString stringWithFormat:@"/events"];
    NSDictionary * parameters = @{
                                  @"title": title,
                                  @"start_datetime": startDatetime,
                                  @"finish_datetime": finishDatatime,
                                  @"location": location,
                                  @"circles": circles,
                                  @"latitude": latitude,
                                  @"longitude": longitude
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *) getEvent:(NSInteger)eventId
{
    NSString * route = [NSString stringWithFormat:@"/events/%ld", (long)eventId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) update:(NSInteger)eventId title:(NSString *)title startDatetime:(NSDate *)startDatetime finishDatatime:(NSDate *)finishDatatime location:(NSString *)location latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude
{
    NSString * route = [NSString stringWithFormat:@"/events/%ld", (long)eventId];
    NSDictionary * parameters = @{
                                  @"title": title,
                                  @"start_datetime": startDatetime,
                                  @"finish_datetime": finishDatatime,
                                  @"location": location,
                                  @"latitude": latitude,
                                  @"longitude": longitude
                                  };

    return [[TSweetRest shared] put:route parameters: parameters];
}

-(TSweetResponse *) deleteEvent:(NSInteger)eventId
{
    NSString * route = [NSString stringWithFormat:@"/events/%ld", (long)eventId];
    return [[TSweetRest shared] delete:route parameters: nil];
}

-(TSweetResponse *) createMedia:(NSInteger)eventId category:(NSString *)category data:(NSData *)data extension:(NSString *)extension
{
    NSString * route = [NSString stringWithFormat:@"/events/%ld/medias", (long)eventId];
    NSDictionary * parameters = @{
                                  @"category": category,
                                  @"data": data,
                                  @"extension": extension
                                  };
    
    return [[TSweetRest shared] put:route parameters: parameters];

}

-(TSweetResponse *) makeDecision:(NSInteger)eventId decision:(NSString *)decision
{
    NSString * route = [NSString stringWithFormat:@"/events/%ld/decision/%@", (long)eventId, decision];
    return [[TSweetRest shared] put:route parameters: nil];
}

-(TSweetResponse *) getDecision:(NSInteger)eventId
{
    NSString * route = [NSString stringWithFormat:@"/events/%ld/decision", (long)eventId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) likeEvent:(NSInteger)eventId
{
    NSString * route = [NSString stringWithFormat:@"/events/%ld/like", (long)eventId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) getEventComments:(NSInteger)eventId
{
    NSString * route = [NSString stringWithFormat:@"/events/%ld/comments", (long)eventId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) commentOnEvent:(NSInteger)eventId comment:(NSString *)comment
{
    NSString * route = [NSString stringWithFormat:@"/events/%ld/comment", (long)eventId];
    NSDictionary * parameters = @{
                                  @"comment": comment
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *) likeCommentOnEvent:(NSInteger)eventId commentId:(NSInteger)commentId
{
    NSString * route = [NSString stringWithFormat:@"/events/%ld/comments/%ld/like", (long)eventId, (long)commentId];
    return [[TSweetRest shared] get:route];
}

@end

