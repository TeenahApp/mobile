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

-(TSweetResponse *) get;

-(TSweetResponse *) create: (NSString *) memberId;

-(TSweetResponse *) deactivate: (NSString *) memberId;

-(TSweetResponse *) activate: (NSString *) memberId;

@end
