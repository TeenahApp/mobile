//
//  TMedia.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TMedia.h"

@implementation TMedia

-(id) initWithJson: (NSDictionary *) json
{
    self = [super init];
    
    if(self)
    {
        self.mediaId = [[json objectForKey:@"id"] integerValue];
        
        self.createdBy = [[json objectForKey:@"created_by"] integerValue];
        self.creator = [[TMember alloc] initWithJson:[json objectForKey:@"creator"]];
        
        self.category = [json objectForKey:@"category"];
        
        self.url = [json objectForKey:@"url"];
        self.taste = [json objectForKey:@"taste"];
        self.signature = [json objectForKey:@"signature"];
        
        self.hasLiked = [[json objectForKey:@"has_liked"] boolValue];
        
        self.viewsCount = [[json objectForKey:@"views_count"] integerValue];
        self.likesCount = [[json objectForKey:@"likes_count"] integerValue];
        self.commentsCount = [[json objectForKey:@"comments_count"] integerValue];
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
    }

    return self;
}

@end
