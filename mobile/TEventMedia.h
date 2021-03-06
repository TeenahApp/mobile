//
//  TEventMedia.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMedia.h"

@interface TEventMedia : NSObject

@property NSInteger eventMediaId;
@property NSInteger eventId;
@property NSInteger mediaId;

// TODO: event.
// TODO: media.
@property (nonatomic, strong) TMedia * media;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

-(id) initWithJson: (NSDictionary *) json;

@end
