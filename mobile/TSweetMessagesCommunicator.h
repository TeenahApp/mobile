//
//  MessagesCommunicator.h
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSweetResponse.h"
#import "TSweetRest.h"

@interface MessagesCommunicator : NSObject

+(id) shared;

-(TSweetResponse *) sendText: (NSString *) content
                     circles: (NSString *) circles;

-(TSweetResponse *) sendMedia: (NSString *) category
                    data: (NSString *) data
                    extension: (NSString *) extension
                      circles: (NSString *) circles;

@end
