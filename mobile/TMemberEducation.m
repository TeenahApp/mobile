//
//  TMemberEducation.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TMemberEducation.h"

@implementation TMemberEducation

-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    
    if(self)
    {
        self.memberEducationId = [[json objectForKey:@"id"] integerValue];
        
        self.memberId = [[json objectForKey:@"member_id"] integerValue];
        
        NSString * majorId = [json objectForKey:@"major_id"];
        
        if (![majorId isKindOfClass:[NSNull class]])
        {
            self.majorId = [[json objectForKey:@"major_id"] integerValue];
        }
        
        self.degree = [json objectForKey:@"degree"];
        self.status = [json objectForKey:@"status"];
        
        self.startYear = [[json objectForKey:@"start_year"] integerValue];
        self.finishYear = [[json objectForKey:@"finish_year"] integerValue];
        
        NSDictionary * major = [json objectForKey:@"major"];
        
        if (![major isKindOfClass:[NSNull class]])
        {
            self.major = [[TEducationMajor alloc] initWithJson:major];
        }

        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
    }
    
    return self;
}

@end
