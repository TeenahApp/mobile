//
//  TCircleMessageMember.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMember.h"
#import "TMessage.h"

@interface TCircleMessageMember : NSObject

@property NSInteger circleMessageMemberId;

@property NSInteger circleId;
@property NSInteger messageId;
@property NSInteger memberId;

@property (nonatomic, strong) NSString * status;

@property (nonatomic, strong) TMessage * message;
@property (nonatomic, strong) TMember * member;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

-(id)initWithJson: (NSDictionary *) json;

@end
