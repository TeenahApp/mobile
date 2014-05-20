//
//  TCircle.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/10/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TCircle.h"

@implementation TCircle

-(id)fromJson:(NSDictionary *)json
{
    self.circleId = json[@"id"];
    self.name = json[@"name"];
    self.membersCount = json[@"members_count"];
    self.isActive = json[@"active"];
    
    return self;
}

@end
