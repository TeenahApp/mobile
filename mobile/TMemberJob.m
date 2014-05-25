//
//  TMemberJob.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TMemberJob.h"

@implementation TMemberJob

-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    
    if(self)
    {
        self.memberJobId = [[json objectForKey:@"id"] integerValue];
        
        self.memberId = [[json objectForKey:@"member_id"] integerValue];
        
        NSString * companyId = [json objectForKey:@"company_id"];
        
        if (![companyId isKindOfClass:[NSNull class]])
        {
            self.companyId = [[json objectForKey:@"company_id"] integerValue];
        }
        
        self.title = [json objectForKey:@"title"];
        self.status = [json objectForKey:@"status"];
        
        self.startYear = [[json objectForKey:@"start_year"] integerValue];
        self.finishYear = [[json objectForKey:@"finish_year"] integerValue];
        
        NSDictionary * company = [json objectForKey:@"company"];
        
        if (![company isKindOfClass:[NSNull class]])
        {
            self.company = [[TJobCompany alloc] initWithJson:company];
        }

        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
    }
    
    return self;
}


@end
