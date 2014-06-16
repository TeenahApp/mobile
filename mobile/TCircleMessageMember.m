//
//  TCircleMessageMember.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TCircleMessageMember.h"

@implementation TCircleMessageMember

-(id)initWithJson: (NSDictionary *) json
{
    self = [super init];
    
    if(self)
    {
        self.circleId = [[json objectForKey:@"circle_id"] integerValue];
        self.messageId = [[json objectForKey:@"message_id"] integerValue];
        self.memberId = [[json objectForKey:@"member_id"] integerValue];
        
        self.message = [[TMessage alloc] initWithJson:[json objectForKey:@"message"]];
        self.member = [[TMember alloc] initWithJson:[json objectForKey:@"member"]];

        self.status = [json objectForKey:@"status"];
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
    }
    
    return self;
}

@end
