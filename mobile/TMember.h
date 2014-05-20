//
//  TMember.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMemberRelation.h"

@class TMemberRelation;

@interface TMember : NSObject

@property NSInteger memberId;

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * mobile;
@property (strong, nonatomic) NSString * fullname;

@property (strong, nonatomic) NSString * photo;

@property (strong, nonatomic) NSString * gender; // male, female

@property (strong, nonatomic) NSDate * dob;
@property NSInteger dobYear;

@property (strong, nonatomic) NSDate * dod;
@property NSInteger dodYear;

@property (strong, nonatomic) NSString * location;

@property BOOL isAlive;
@property BOOL isRoot;

@property (strong, nonatomic) TMember * father;

@property (strong, nonatomic) NSMutableArray * relations;
@property (strong, nonatomic) NSMutableArray * children;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

-(id) initWithJson: (NSDictionary *) json;

@end
