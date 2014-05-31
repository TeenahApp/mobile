//
//  TEvent.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/21/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TEvent.h"

@implementation TEvent

-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    
    if(self)
    {
        self.eventId = [[json objectForKey:@"id"] integerValue];
        
        self.title = [json objectForKey:@"title"];
        self.location = [json objectForKey:@"location"];
        
        self.createdBy = [[json objectForKey:@"created_by"] integerValue];
        self.creator = [[TMember alloc] initWithJson:[json objectForKey:@"creator"]];
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.startsAt = [longDateFormatter dateFromString: [json objectForKey:@"start_datetime"]];
        self.finishesAt = [longDateFormatter dateFromString: [json objectForKey:@"finish_datetime"]];
        
        self.latitude = (NSNumber *)[json objectForKey:@"latitude"];
        self.longitude = (NSNumber *)[json objectForKey:@"longitude"];
        
        self.hasLiked = [[json objectForKey:@"has_liked"] boolValue];
        
        self.viewsCount = [[json objectForKey:@"views_count"] integerValue];
        self.comingsCount = [[json objectForKey:@"comings_count"] integerValue];
        self.likesCount = [[json objectForKey:@"likes_count"] integerValue];
        self.commentsCount = [[json objectForKey:@"comments_count"] integerValue];
        
        // Medias.
        self.medias = [[NSMutableArray alloc] init];
        
        for (NSDictionary * tempMedia in [json objectForKey:@"medias"])
        {
            TEventMedia * eventMedia = [[TEventMedia alloc] initWithJson:tempMedia];
            [self.medias addObject:eventMedia];
        }
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
    }
    
    return self;
}

// TODO: Complete this description method.
-(NSString *)description
{
    return [NSString stringWithFormat:@"title: %@, location: %@", self.title, self.location];
}

@end
