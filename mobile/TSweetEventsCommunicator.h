//
//  EventsCommunicator.h
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSweetResponse.h"
#import "TSweetRest.h"

@interface EventsCommunicator : NSObject

+(id) shared;

-(TSweetResponse *) create: (NSString *) title
             startDatetime: (NSString *) startDatetime
            finishDatatime: (NSString *) finishDatatime
                  location: (NSString *) location
                   circles: (NSString *) circles
                  latitude: (NSString *) latitude
                 longitude: (NSString *) longitude;

-(TSweetResponse *) get: (NSString *) eventId;

-(TSweetResponse *) update: (NSString *) eventId
                     title: (NSString *) title
             startDatetime: (NSString *) startDatetime
            finishDatatime: (NSString *) finishDatatime
                  location: (NSString *) location
                  latitude: (NSString *) latitude
                 longitude: (NSString *) longitude;

-(TSweetResponse *) delete: (NSString *) eventId;

-(TSweetResponse *) createMedia: (NSString *) eventId
                       category: (NSString *) category
                           data: (NSString *) data
                      extension: (NSString *) extension;

-(TSweetResponse *) makeDecision: (NSString *) eventId
                        decision: (NSString *) decision;

-(TSweetResponse *) getDecision: (NSString *) eventId;


-(TSweetResponse *) like: (NSString *) eventId;

-(TSweetResponse *) comment: (NSString *) eventId
                    comment: (NSString *) comment;

-(TSweetResponse *) likeComment: (NSString *) eventId
                      commentId: (NSString *) commentId;

@end
