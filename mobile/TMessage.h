//
//  TMessage.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMember.h"
#import "TMessageMedia.h"

@interface TMessage : NSObject

@property NSInteger messageId;

@property (strong, nonatomic) NSString * category; // text, update
@property (strong, nonatomic) NSString * content;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

@property NSInteger createdBy;
@property (nonatomic, strong) TMember * creator;

@property (nonatomic, strong) NSMutableArray * medias;

-(id) initWithJson: (NSDictionary *) json;

@end
