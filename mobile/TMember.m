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
        self.fullname = [json objectForKey:@"fullname"];
        
        self.photo = [json objectForKey:@"photo"];
        
        self.gender = [json objectForKey:@"gender"];
        self.maritalStatus = [json objectForKey:@"marital_status"];
        
        self.mobile = [json objectForKey:@"mobile"];
        self.email = [json objectForKey:@"email"];
        self.homePhone = [json objectForKey:@"home_phone"];
        self.workPhone = [json objectForKey:@"work_phone"];
        
        if ([self.photo isKindOfClass:[NSNull class]] || [self.photo isEqual:@""])
        {
            self.photo = nil;
        }
        
        if ([self.mobile isKindOfClass:[NSNull class]] || [self.mobile isEqual:@""])
        {
            self.mobile = nil;
        }
        
        if ([self.email isKindOfClass:[NSNull class]] || [self.email isEqual:@""])
        {
            self.email = nil;
        }
        
        if ([self.homePhone isKindOfClass:[NSNull class]] || [self.homePhone isEqual:@""])
        {
            self.homePhone = nil;
        }
        
        if ([self.workPhone isKindOfClass:[NSNull class]] || [self.workPhone isEqual:@""])
        {
            self.workPhone = nil;
        }
        
        if ([self.maritalStatus isKindOfClass:[NSNull class]])
        {
            self.maritalStatus = nil;
        }
        
        NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDateFormatter * shortDateFormatter = [[NSDateFormatter alloc] init];
        [shortDateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDateFormatter * yearDateFormatter = [[NSDateFormatter alloc] init];
        [yearDateFormatter setDateFormat:@"yyyyy"];
        
        NSString * tempDob = [json objectForKey:@"dob"];
        NSString * tempDod = [json objectForKey:@"dod"];
        
        if (![tempDob isKindOfClass:[NSNull class]])
        {
            self.dob = [shortDateFormatter dateFromString:tempDob];
        }
        
        if (![tempDod isKindOfClass:[NSNull class]])
        {
            self.dod = [shortDateFormatter dateFromString:tempDod];
        }
        
        self.dobYear = 0;
        self.dodYear = 0;
        
        if (self.dob != nil)
        {
            self.dobYear = [[yearDateFormatter stringFromDate:self.dob] integerValue];
        }

        if (self.dod != nil)
        {
            self.dodYear = [[yearDateFormatter stringFromDate:self.dod] integerValue];
        }
        
        // TODO:
        NSMutableString * displayYears = [[NSMutableString alloc]init];
        
        if (self.dobYear != 0)
        {
            [displayYears appendFormat:@"%ld", (long)self.dobYear];
        }
        
        if (self.dodYear != 0)
        {
            [displayYears appendFormat:@" - %ld", (long)self.dodYear];
        }
        
        if ([self.fullname isKindOfClass:[NSNull class]])
        {
            self.displayName = self.name;
        }
        else
        {
            self.displayName = [self sanitize:self.fullname]; //self.fullname;
        }
        
        self.displayYears = displayYears;
        
        self.age = [[json objectForKey:@"age"] integerValue];
        
        self.pob = [json objectForKey:@"pob"];
        self.pod = [json objectForKey:@"pod"];
        
        if ([self.pob isKindOfClass:[NSNull class]] || [self.pob isEqual:@""])
        {
            self.pob = nil;
        }
        
        if ([self.pod isKindOfClass:[NSNull class]] || [self.pod isEqual:@""])
        {
            self.pod = nil;
        }

        self.location = [json objectForKey:@"location"];
        
        if ([self.location isKindOfClass:[NSNull class]])
        {
            self.location = nil;
        }
        
        self.isAlive = [[json objectForKey:@"is_alive"] boolValue];
        self.isRoot = [[json objectForKey:@"is_root"] boolValue];
        
        // Init empty.
        self.father = nil;
        self.mother = nil;
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
            
            // Check if this relation is a mother.
            if ([memberRelation.relationship isEqual: @"mother"])
            {
                self.mother = memberRelation.firstMember;
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
        
        self.hasLiked = [[json objectForKey:@"has_liked"] boolValue];
        
        self.viewsCount = [[json objectForKey:@"views_count"] integerValue];
        self.likesCount = [[json objectForKey:@"likes_count"] integerValue];
        self.commentsCount = [[json objectForKey:@"comments_count"] integerValue];
        self.mediasCount = [[json objectForKey:@"medias_count"] integerValue];
        
        self.createdAt = [longDateFormatter dateFromString: [json objectForKey:@"created_at"]];
        self.updatedAt = [longDateFormatter dateFromString: [json objectForKey:@"updated_at"]];
        
    }

    return self;
}

// TODO: Fullfill the description with the correct variable names and values.
-(NSString *)description
{
    return [NSString stringWithFormat:@"{id: %ld, dobYear: %ld, hasLiked: %d}", (long)self.memberId, (long)self.dobYear, self.hasLiked];
}

-(NSString *)sanitize:(NSString *)fullname
{
    NSArray * names = [fullname componentsSeparatedByString:@" "];

    if (names.count > 3)
    {
        NSArray * specificNames = [NSArray arrayWithObjects:[names objectAtIndex:0], [names objectAtIndex:1], [names objectAtIndex:names.count-1], nil];
        return [specificNames componentsJoinedByString:@" "];
    }

    return fullname;
}

@end
