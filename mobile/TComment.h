//
//  TComment.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/29/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMember.h"

@interface TComment : NSObject

@property NSInteger commentId;

@property NSInteger affectedId;
@property NSInteger createdBy;

@property (nonatomic, strong) NSString * content;

@property (nonatomic, strong) TMember * creator;

@property NSInteger likesCount;

@property BOOL hasLiked;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

-(id) initWithJson: (NSDictionary *) json;

@end
