//
//  TMember.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMemberRelation.h"
#import "TMemberEducation.h"
#import "TMemberJob.h"

@class TMemberRelation;

@interface TMember : NSObject

@property NSInteger memberId;
@property NSInteger tribeId;

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * fullname;
@property (strong, nonatomic) NSString * nickname;
@property (strong, nonatomic) NSString * displayName;

@property (strong, nonatomic) NSString * photo;

@property (strong, nonatomic) NSString * mobile;
@property (strong, nonatomic) NSString * email;
@property (strong, nonatomic) NSString * homePhone;
@property (strong, nonatomic) NSString * workPhone;

@property (strong, nonatomic) NSString * gender; // male, female

@property (strong, nonatomic) NSString * pob;
@property (strong, nonatomic) NSDate * dob;
@property NSInteger dobYear;

@property (strong, nonatomic) NSString * pod;
@property (strong, nonatomic) NSDate * dod;
@property NSInteger dodYear;

@property (strong, nonatomic) NSString * displayYears;

@property NSInteger age;

@property (strong, nonatomic) NSString * location;

@property BOOL isAlive;
@property BOOL isRoot;

@property (strong, nonatomic) NSString * maritalStatus;
@property (strong, nonatomic) NSString * bloodType;

@property (strong, nonatomic) TMember * father;
@property (strong, nonatomic) TMember * mother;

@property (strong, nonatomic) NSMutableArray * relations;
@property (strong, nonatomic) NSMutableArray * children;

@property (strong, nonatomic) NSMutableArray * educations;
@property (strong, nonatomic) NSMutableArray * jobs;

@property BOOL hasLiked;

@property NSInteger viewsCount;
@property NSInteger likesCount;
@property NSInteger commentsCount;
@property NSInteger mediasCount;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

// TODO: user.
// TODO: circles.
// TODO: createdActions.
// TODO: affectedActions.
// TODO: educationMajors.
// TODO: jobCompanies.
// TODO: privacies.
// TODO: outRelations.
// TODO: inRelations.
// TODO: socialMedias.
// TODO: trustees.

-(id) initWithJson: (NSDictionary *) json;
-(NSString *)sanitize: (NSString *)fullname;

@end
