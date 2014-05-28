//
//  TComment.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/29/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TComment.h"

@implementation TComment

-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    
    if(self)
    {
        self.commentId = [[json objectForKey:@"id"] integerValue];
        
        self.affectedId = [[json objectForKey:@"affected_id"] integerValue];
        self.createdBy = [[json objectForKey:@"created_by"] integerValue];
        
        self.content = [json objectForKey:@"content"];

        self.creator = [[TMember alloc] initWithJson:[json objectForKey:@"creator"]];

        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.createdAt = [longDateFormatter dateFromString:[json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString:[json objectForKey:@"updated_at"]];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"content = %@", self.content];
}

@end
