//
//  TEducationMajor.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEducationMajor : NSObject

@property NSInteger educationMajorId;

@property (nonatomic, strong) NSString * name;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

-(id) initWithJson: (NSDictionary *) json;

@end
