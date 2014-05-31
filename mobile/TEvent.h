//
//  TEvent.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/21/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMember.h"
#import "TEventMedia.h"

@interface TEvent : NSObject

@property NSInteger eventId;

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * location;

@property NSInteger createdBy;
@property (nonatomic, strong) TMember * creator;

@property (nonatomic, strong) NSDate * startsAt;
@property (nonatomic, strong) NSDate * finishesAt;

@property NSNumber * latitude;
@property NSNumber * longitude;

@property BOOL hasLiked;

@property NSInteger viewsCount;
@property NSInteger comingsCount;
@property NSInteger likesCount;
@property NSInteger commentsCount;

@property (nonatomic, strong) NSMutableArray * medias;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

-(id) initWithJson: (NSDictionary *) json;

@end
