//
//  TMember.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMember : NSObject

@property (strong, nonatomic) NSString * memberId;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * fullname;
@property (strong, nonatomic) NSString * photo;
@property (strong, nonatomic) NSString * gender;
@property (strong, nonatomic) NSString * dob;
@property (strong, nonatomic) NSString * dobYear;
@property int isAlive;

@property (strong, nonatomic) TMember * father;
@property (strong, nonatomic) NSMutableDictionary * children;

-(id) fromJson: (NSDictionary *) json;

@end
