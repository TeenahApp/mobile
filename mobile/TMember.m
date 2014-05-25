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
        self.memberId = [[json objectForKey:@"id"] integerValue];
        
        self.name = [json objectForKey:@"name"];
        self.mobile = [json objectForKey:@"mobile"];
        self.fullname = [json objectForKey:@"fullname"];
        
        self.photo = [json objectForKey:@"photo"];
        
        self.gender = [json objectForKey:@"gender"]; // male, female
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDateFormatter * shortDateFormatter = [[NSDateFormatter alloc] init];
        [shortDateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDateFormatter * yearDateFormatter = [[NSDateFormatter alloc] init];
        [yearDateFormatter setDateFormat:@"yyyyy"];
        
        NSString * tempDob = [json objectForKey:@"dob"];
        NSString * tempDod = [json objectForKey:@"dod"];
        
        NSLog(@"dob = %@, dod = %@", tempDob, tempDod);
        
        if (![tempDob isKindOfClass:[NSNull class]])
        {
            self.dob = [shortDateFormatter dateFromString:tempDob];
        }
        
        if (![tempDod isKindOfClass:[NSNull class]])
        {
            self.dod = [shortDateFormatter dateFromString:tempDod];
        }
        
        if (self.dob != nil)
        {
            self.dobYear = [[yearDateFormatter stringFromDate:self.dob] integerValue];
        }

        if (self.dod != nil)
        {
            self.dodYear = [[yearDateFormatter stringFromDate:self.dod] integerValue];
        }
        
        self.location = [json objectForKey:@"location"];
        
        self.isAlive = [[json objectForKey:@"is_alive"] boolValue];
        self.isRoot = [[json objectForKey:@"is_root"] boolValue];
        
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
        
        // Educations.
        self.educations = [[NSMutableArray alloc] init];
        
        for (NSDictionary * tempEducation in [json objectForKey:@"educations"])
        {
            TMemberEducation * education = [[TMemberEducation alloc] initWithJson:tempEducation];
            [self.educations addObject:education];
        }
        
        // Jobs.
        self.jobs = [[NSMutableArray alloc] init];
        
        for (NSDictionary * tempJob in [json objectForKey:@"jobs"])
        {
            TMemberJob * job = [[TMemberJob alloc] initWithJson:tempJob];
            [self.jobs addObject:job];
        }
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
        
    }
    
    return self;
}

// TODO: Fullfill the description with the correct variable names and values.
-(NSString *)description
{
    return [NSString stringWithFormat:@"{id: %ld, dobYear: %ld}", (long)self.memberId, (long)self.dobYear];
}

@end
