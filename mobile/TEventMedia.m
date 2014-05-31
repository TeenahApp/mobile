//
//  TEventMedia.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TEventMedia.h"

@implementation TEventMedia

-(id) initWithJson: (NSDictionary *) json
{
    self = [super init];
    
    if(self)
    {
        self.eventMediaId = [[json objectForKey:@"id"] integerValue];
        
        self.eventId = [[json objectForKey:@"event_id"] integerValue];
        self.mediaId = [[json objectForKey:@"media_id"] integerValue];
        
        self.media = [[TMedia alloc] initWithJson:[json objectForKey:@"media"]];

        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
    }
    
    return self;
}

@end
