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
    self.photo = json[@"photo"];
    
    // TODO: Build the relations.
    
    //int relationsCount = [json[@"in_relations"] count];
    NSDictionary * relations = json[@"in_relations"];
    
    for(NSDictionary * relatedMember in relations)
    {
        //NSLog(@"key=%@", key); //[relations objectForKey:key]);
        //NSLog(@"%@", relation[@"relationship"]);
        NSString * relation = relatedMember[@"relationship"];
        
        if ([relation isEqual: @"father"])
        {
            self.father = [[TMember alloc] init];
            [self.father fromJson:relatedMember[@"first_member"]];
        }
    }

    return self;
}

@end
