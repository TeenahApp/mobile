//
//  TCircleMessageMember.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCircleMessageMember : NSObject

@property NSInteger circleMessageMemberId;

@property NSInteger circleId;
@property NSInteger messageId;
@property NSInteger memberId;

@property (nonatomic, strong) NSString * status;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

@end
