//
//  TMessage.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TMessage.h"

@implementation TMessage

-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    
    if(self)
    {
        self.messageId = [[json objectForKey:@"id"] integerValue];
        self.category = [json objectForKey:@"category"];
        self.content = [json objectForKey:@"content"];
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.createdBy = [[json objectForKey:@"created_by"] integerValue];
        self.creator = [[TMember alloc] initWithJson:[json objectForKey:@"creator"]];
        
        // Medias.
        self.medias = [[NSMutableArray alloc] init];
        
        for (NSDictionary * tempMessageMedia in [json objectForKey:@"medias"])
        {
            TMessageMedia * messageMedia = [[TMessageMedia alloc] initWithJson:tempMessageMedia];
            [self.medias addObject:messageMedia];
        }
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
    }
    
    return self;
}

@end
