//
//  TCircle.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/10/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TCircle.h"

@implementation TCircle

-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    
    if(self)
    {
        self.circleId = [[json objectForKey:@"id"] integerValue];
        self.name = [json objectForKey:@"name"];
        self.isActive = [[json objectForKey:@"is_active"] boolValue];
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        // Get some stats.
        self.membersCount = [[json objectForKey:@"members_count"] integerValue];
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
    }
    
    return self;
}

@end
