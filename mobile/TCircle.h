//
//  TCircle.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/10/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCircle : NSObject

@property (strong, nonatomic) NSString * circleId;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * membersCount;
@property (strong, nonatomic) NSString * isActive;

-(id) fromJson: (NSDictionary *) json;

@end
