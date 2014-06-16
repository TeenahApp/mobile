//
//  TMessageMedia.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TMessageMedia.h"

@implementation TMessageMedia

-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    
    if(self)
    {
        self.messageMediaId = [[json objectForKey:@"id"] integerValue];
        self.messageId = [[json objectForKey:@"id"] integerValue];
        self.mediaId = [[json objectForKey:@"id"] integerValue];
        
        self.media = [[TMedia alloc] initWithJson:[json objectForKey:@"media"]];

        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
    }

    return self;
}

@end
