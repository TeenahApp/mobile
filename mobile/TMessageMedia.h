//
//  TMessageMedia.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMedia.h"

@interface TMessageMedia : NSObject

@property NSInteger messageMediaId;
@property NSInteger messageId;
@property NSInteger mediaId;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

@property (nonatomic, strong) TMedia * media;

-(id) initWithJson: (NSDictionary *) json;

@end
