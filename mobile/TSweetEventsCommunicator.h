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
             startDatetime: (NSDate *) startDatetime
            finishDatatime: (NSDate *) finishDatatime
                  location: (NSString *) location
                   circles: (NSArray *) circles
                  latitude: (NSNumber *) latitude
                 longitude: (NSNumber *) longitude;

-(TSweetResponse *) getEvents;

-(TSweetResponse *) getEvent: (NSInteger) eventId;

-(TSweetResponse *) update: (NSInteger) eventId
                     title: (NSString *) title
             startDatetime: (NSDate *) startDatetime
            finishDatatime: (NSDate *) finishDatatime
                  location: (NSString *) location
                  latitude: (NSNumber *) latitude
                 longitude: (NSNumber *) longitude;

-(TSweetResponse *) deleteEvent: (NSInteger) eventId;

-(TSweetResponse *) createMedia: (NSInteger) eventId
                       category: (NSString *) category // image, video, sound
                           data: (NSData *) data
                      extension: (NSString *) extension;

-(TSweetResponse *) makeDecision: (NSInteger) eventId
                        decision: (NSString *) decision; // notyet, willcome, apologize

-(TSweetResponse *) getDecision: (NSInteger) eventId;


-(TSweetResponse *) like: (NSInteger) eventId;

-(TSweetResponse *) comment: (NSInteger) eventId
                    comment: (NSString *) comment;

-(TSweetResponse *) likeComment: (NSInteger) eventId
                      commentId: (NSInteger) commentId;

@end
