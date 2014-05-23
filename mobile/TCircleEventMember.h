//
//  TCircleEventMember.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCircleEventMember : NSObject

@property NSInteger circleEventMemberId;

@property NSInteger circleId;
@property NSInteger eventId;
@property NSInteger memberId;

@property (nonatomic, strong) NSString * decision;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

@end
