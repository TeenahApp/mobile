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
    NSLog(@"=============== RECEIVED %@", json.description);
    
    self.name = json[@"name"];
    self.photo = json[@"photo"];
    
    
    return self;
}

@end
