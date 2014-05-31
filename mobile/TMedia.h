//
//  TMedia.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMember.h"

@interface TMedia : NSObject

@property NSInteger mediaId;

@property NSInteger createdBy;
@property (nonatomic, strong) TMember * creator;

@property (nonatomic, strong) NSString * category;

@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * taste;
@property (nonatomic, strong) NSString * signature;

@property BOOL hasLiked;

@property NSInteger viewsCount;
@property NSInteger likesCount;
@property NSInteger commentsCount;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

// TODO: creator.

-(id) initWithJson: (NSDictionary *) json;

@end
