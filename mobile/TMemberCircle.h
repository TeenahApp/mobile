//
//  TMemberCircle.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMemberCircle : NSObject

@property NSInteger memberCircleId;

@property NSInteger memberId;
@property NSInteger circleId;

@property (nonatomic, strong) NSString * status;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

// TODO: member.
// TODO: circle.

@end
