//
//  TAction.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAction : NSObject

@property NSInteger actionId;
@property NSInteger createdBy;
@property NSInteger affectedId;

@property (nonatomic, strong) NSString * area;
@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * content;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

// TODO: creator.
// TODO: affected.

@end
