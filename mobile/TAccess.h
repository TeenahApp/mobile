//
//  TAccess.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAccess : NSObject

@property NSInteger accessId;
@property NSInteger userId;

@property (nonatomic, strong) NSString * category;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

// TODO: user.

@end
