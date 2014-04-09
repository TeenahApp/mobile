//
//  UsersCommunicator.h
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/1/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSweetResponse.h"
#import "TSweetRest.h"

@interface UsersCommunicator : NSObject

+(id) shared;

-(TSweetResponse *) tokenize: (NSString *) mobile;

-(TSweetResponse *) login: (NSString *) mobile
                 smsToken: (NSString *) smsToken;

-(TSweetResponse *) logout;

-(TSweetResponse *) initialize: (NSString *) gender
                          name: (NSString *) name
                           dob: (NSString *) dob;

-(TSweetResponse *) dashboard;

@end
