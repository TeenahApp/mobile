//
//  AutoCompletesCommunicator.h
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSweetResponse.h"
#import "TSweetRest.h"

@interface AutoCompletesCommunicator : NSObject

+(id) shared;

-(TSweetResponse *) majors: (NSString *) query;

-(TSweetResponse *) companies: (NSString *) query;

@end
