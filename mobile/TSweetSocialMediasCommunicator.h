//
//  SocialMediasCommunicator.h
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSweetResponse.h"
#import "TSweetRest.h"

@interface SocialMediasCommunicator : NSObject

+(id) shared;

-(TSweetResponse *) create: (NSString *) name
                   account: (NSString *) account;

-(TSweetResponse *) update: (NSString *) socialMediaId
                   account: (NSString *) account;

-(TSweetResponse *) delete: (NSString *) socialMediaId;

@end
