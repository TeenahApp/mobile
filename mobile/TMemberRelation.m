//
//  TMemberRelation.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/21/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TMemberRelation.h"

@implementation TMemberRelation

-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    
    if(self)
    {
        self.relationId = [[json objectForKey:@"id"] integerValue];
        
        self.isActive = [[json objectForKey:@"is_active"] boolValue];
        
        self.memberA = [[json objectForKey:@"member_a"] integerValue];
        self.memberB = [[json objectForKey:@"member_b"] integerValue];
        
        self.relationship = [json objectForKey:@"relationship"];
        
        self.firstMember = [[TMember alloc] initWithJson:[json objectForKey:@"first_member"]];
        // TODO: self.secondMember;
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];

    }
    
    return self;
}

@end
