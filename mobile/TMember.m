//
//  TMember.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TMember.h"

@implementation TMember

-(id)fromJson:(NSDictionary *)json
{
    self.memberId = json[@"id"];
    self.name = json[@"name"];
    self.mobile = json[@"mobile"];
    self.fullname = json[@"fullname"];
    self.gender = json[@"gender"];
    self.photo = json[@"photo"];
    
    self.dob = json[@"dob"];
    self.dod = json[@"dod"];
    
    if (![self.dob isEqual:[NSNull null]])
    {
        self.dobYear = [[self.dob componentsSeparatedByString:@"-"] objectAtIndex:0];
    }
    
    if (![self.dod isEqual:[NSNull null]])
    {
        self.dodYear = [[self.dod componentsSeparatedByString:@"-"] objectAtIndex:0];
    }
    
    // Make the years empty if not set.
    if ([self.dobYear isEqual: @"0000"])
    {
        self.dobYear = @"";
    }
    
    if ([self.dodYear isEqual: @"0000"])
    {
        self.dodYear = @"";
    }
    
    self.isAlive = [json[@"is_alive"] intValue];
    
    // TODO: self.dobYear.
    
    NSLog(@"PHOTO: ---------- %@", self.photo);
    
    // TODO: Build the relations.
    
    //int relationsCount = [json[@"in_relations"] count];
    //NSDictionary * relations = json[@"in_relations"];
    
    self.relations = [[NSDictionary alloc] init];
    self.relations = json[@"in_relations"];
    
    // Reset every thing.
    self.children = [[NSMutableDictionary alloc] init];
    self.father = nil;
    
    for(NSDictionary * relatedMember in self.relations)
    {
        //NSLog(@"key=%@", key); //[relations objectForKey:key]);
        //NSLog(@"%@", relation[@"relationship"]);
        NSString * relation = relatedMember[@"relationship"];
        
        // Add father.
        if ([relation isEqual: @"father"])
        {
            self.father = [[TMember alloc] init];
            [self.father fromJson:relatedMember[@"first_member"]];
        }
        
        // Add children.
        if ([relation isEqual: @"son"] || [relation isEqual: @"daughter"])
        {
            TMember * child = [[TMember alloc] init];
            //[self.children setValue:[child fromJson:relatedMember[@"first_member"]] forKeyPath: relatedMember[@"id"]];
            [self.children setValue: [child fromJson:relatedMember[@"first_member"]] forKeyPath:[NSString stringWithFormat:@"%@", relatedMember[@"first_member"][@"id"]]];
        }
        
    }

    return self;
}

@end
