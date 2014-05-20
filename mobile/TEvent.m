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
        self.eventId = (NSInteger)[json objectForKey:@"id"];
        
        self.title = [json objectForKey:@"title"];
        self.location = [json objectForKey:@"location"];
        
        self.createdBy = (NSInteger)[json objectForKey:@"created_by"];
        //self.creator;
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.startsAt = [longDateFormatter dateFromString: [json objectForKey:@"start_datetime"]];
        self.finishesAt = [longDateFormatter dateFromString: [json objectForKey:@"finish_datetime"]];
        
        self.latitude = (NSNumber *)[json objectForKey:@"latitude"];
        self.longitude = (NSNumber *)[json objectForKey:@"longitude"];
        
        self.viewsCount = (NSInteger)[json objectForKey:@"views_count"];
        self.likesCount = (NSInteger)[json objectForKey:@"likes_count"];;
        self.commentsCount = (NSInteger)[json objectForKey:@"comments_count"];;
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];;
    }
    
    return self;
}

// TODO: Complete this description method.
-(NSString *)description
{
    return [NSString stringWithFormat:@"title: %@, location: %@", self.title, self.location];
}

@end
