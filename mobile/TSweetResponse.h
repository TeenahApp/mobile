//
//  TSweetResponse.h
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 3/30/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSweetResponse : NSObject

@property NSInteger code;
@property NSData * body;
@property NSDictionary * json;

-(id)  initWithParameters: (NSInteger) code
                      body: (NSData *) body;

-(NSString *) description;

@end
