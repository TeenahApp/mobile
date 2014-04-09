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

-(TSweetResponse *) like: (NSString *) mediaId;

-(TSweetResponse *) comment: (NSString *) mediaId
                    comment: (NSString *) comment;

-(TSweetResponse *) likeComment: (NSString *) mediaId
                      commentId: (NSString *) commentId;

@end
