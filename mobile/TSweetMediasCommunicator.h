//
//  MediasCommunicator.h
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/2/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSweetResponse.h"
#import "TSweetRest.h"

@interface MediasCommunicator : NSObject

+(id) shared;

-(TSweetResponse *) like: (NSInteger) mediaId;

-(TSweetResponse *) comment: (NSInteger) mediaId
                    comment: (NSString *) comment;

-(TSweetResponse *) likeComment: (NSInteger) mediaId
                      commentId: (NSInteger) commentId;

@end
