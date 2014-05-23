//
//  TMemberEducation.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMemberEducation : NSObject

@property NSInteger memberEducationId;

@property NSInteger memberId;
@property NSInteger majorId;

@property (nonatomic, strong) NSString * degree;
@property (nonatomic, strong) NSString * status;

@property NSInteger startYear;
@property NSInteger finishYear;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

// TODO: member.
// TODO: major.

@end
