//
//  TMember.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TMember.h"

@implementation TMember

-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    
    if(self)
    {
        // TODO: MemberRealtion.
        
        self.memberId = [[json objectForKey:@"id"] integerValue];
        
        self.name = [json objectForKey:@"name"];
        self.mobile = [json objectForKey:@"mobile"];
        self.fullname = [json objectForKey:@"fullname"];
        
        self.photo = [json objectForKey:@"photo"];
        
        self.gender = [json objectForKey:@"gender"]; // male, female
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.dob = [json objectForKey:@"dob"]; //[longDateFormatter dateFromString:[json objectForKey:@"dob"]];
        self.dod = [json objectForKey:@"dob"]; //[longDateFormatter dateFromString:[json objectForKey:@"dob"]];
        
        if (self.dob == nil)
        {
            
        }
        
        NSLog(@"Passsssssssed");
        
        // TODO: self.dobYear;
        // TODO: self.dodYear;
        
        self.location = [json objectForKey:@"location"];
        
        self.isAlive = (BOOL)[json objectForKey:@"is_alive"];
        self.isRoot = (BOOL)[json objectForKey:@"is_root"];
        
        // Init empty.
        self.father = nil;
        self.children = [[NSMutableArray alloc] init];
        
        // Get the relations.
        self.relations = [[NSMutableArray alloc] init];
        self.relations = [json objectForKey:@"in_relations"];
        
        for (NSDictionary * tempMemberRelation in self.relations)
        {
            TMemberRelation * memberRelation = [[TMemberRelation alloc] initWithJson:tempMemberRelation];
            
            // Check if this relation is a father.
            if ([memberRelation.relationship isEqual: @"father"])
            {
                self.father = memberRelation.firstMember;
            }
            
            // Check if the relation is son or daughter.
            if ([memberRelation.relationship isEqual: @"son"] || [memberRelation.relationship isEqual: @"daughter"])
            {
                [self.children addObject:memberRelation.firstMember];
            }
        }
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
        
    }
    
    return self;
}

@end
