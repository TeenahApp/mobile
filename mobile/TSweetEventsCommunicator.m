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

-(TSweetResponse *) create: (NSString *) title
             startDatetime: (NSString *) startDatetime
            finishDatatime: (NSString *) finishDatatime
                  location: (NSString *) location
                   circles: (NSString *) circles
                  latitude: (NSString *) latitude
                 longitude: (NSString *) longitude
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

-(TSweetResponse *) get: (NSString *) eventId
{
    NSString * route = [NSString stringWithFormat:@"/events/%@", eventId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) update: (NSString *) eventId
                     title: (NSString *) title
             startDatetime: (NSString *) startDatetime
            finishDatatime: (NSString *) finishDatatime
                  location: (NSString *) location
                  latitude: (NSString *) latitude
                 longitude: (NSString *) longitude
{
    NSString * route = [NSString stringWithFormat:@"/events/%@", eventId];
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

-(TSweetResponse *) delete: (NSString *) eventId
{
    NSString * route = [NSString stringWithFormat:@"/events/%@", eventId];
    return [[TSweetRest shared] delete:route parameters: nil];
}

-(TSweetResponse *) createMedia: (NSString *) eventId
                       category: (NSString *) category
                           data: (NSString *) data
                      extension: (NSString *) extension
{
    NSString * route = [NSString stringWithFormat:@"/events/%@/medias", eventId];
    NSDictionary * parameters = @{
                                  @"category": category,
                                  @"data": data,
                                  @"extension": extension
                                  };
    
    return [[TSweetRest shared] put:route parameters: parameters];

}

-(TSweetResponse *) makeDecision: (NSString *) eventId
                        decision: (NSString *) decision
{
    NSString * route = [NSString stringWithFormat:@"/events/%@/decision/%@", eventId, decision];
    return [[TSweetRest shared] put:route parameters: nil];
}

-(TSweetResponse *) getDecision: (NSString *) eventId
{
    NSString * route = [NSString stringWithFormat:@"/events/%@/decision", eventId];
    return [[TSweetRest shared] get:route];
}


-(TSweetResponse *) like: (NSString *) eventId
{
    NSString * route = [NSString stringWithFormat:@"/events/%@/like", eventId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *) comment: (NSString *) eventId
                    comment: (NSString *) comment
{
    NSString * route = [NSString stringWithFormat:@"/events/%@/comment", eventId];
    NSDictionary * parameters = @{
                                  @"comment": comment
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *) likeComment: (NSString *) eventId
                      commentId: (NSString *) commentId
{
    NSString * route = [NSString stringWithFormat:@"/events/%@/comments/%@", eventId, commentId];
    return [[TSweetRest shared] get:route];
}

@end

