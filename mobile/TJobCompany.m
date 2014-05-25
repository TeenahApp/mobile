//
//  TJobCompany.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TJobCompany.h"

@implementation TJobCompany

-(id) initWithJson: (NSDictionary *) json
{
    self = [super init];
    
    if(self)
    {
        // TODO: category, link, logo.
        
        self.jobCompanyId = [[json objectForKey:@"id"] integerValue];
        self.name = [json objectForKey:@"name"];
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
    }
    
    return self;
}

@end
