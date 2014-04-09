//
//  TSweetResponse.m
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 3/30/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import "TSweetResponse.h"

@implementation TSweetResponse

-(id)initWithParameters:(NSInteger)code body:(NSData *)body {
    
    if (self = [super init])
    {
        NSError* error;
        
        self.code = code;
        self.body = body;
        self.json = [NSJSONSerialization JSONObjectWithData:self.body options:kNilOptions error:&error];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat: @"Code: %ld, Body: %@", (long)self.code, self.json.description];
}

@end
