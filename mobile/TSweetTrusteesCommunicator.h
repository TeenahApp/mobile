//
//  TrusteesCommunicator.h
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSweetResponse.h"
#import "TSweetRest.h"

@interface TrusteesCommunicator : NSObject

+(id) shared;

-(TSweetResponse *) getTrustees;

-(TSweetResponse *) create: (NSInteger) memberId;

-(TSweetResponse *) deactivate: (NSInteger) memberId;

-(TSweetResponse *) activate: (NSInteger) memberId;

@end
