//
//  MembersCommunicator.h
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/1/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSweetResponse.h"
#import "TSweetRest.h"

@interface MembersCommunicator : NSObject

+(id) shared;

-(TSweetResponse *) getMember: (NSInteger) memberId;

-(TSweetResponse *) update: (NSInteger) memberId
             maritalStatus: (NSString *) maritalStatus
                       dob: (NSDate *) dob
                       pob: (NSString *) pob
                       dod: (NSDate *) dod
                       pod: (NSString *) pod
                     email: (NSString *) email;

-(TSweetResponse *) uploadPhoto: (NSInteger) memberId
                           data: (NSData *) data
                      extension: (NSString *) extension;

-(TSweetResponse *) createRelation: (NSInteger) memberA
                           isAlive: (BOOL) isAlive
                              name: (NSString *) name
                          relation: (NSString *) relation
                            isRoot: (BOOL) isRoot
                            mobile: (NSString *) mobile
                               dob: (NSDate *) dob
                               dod: (NSDate *) dod;

-(TSweetResponse *) deleteRelation: (NSInteger) memberA
                           memberB: (NSInteger) memberB;

-(TSweetResponse *) createEducation: (NSInteger) memberId
                             degree: (NSString *) degree
                          startYear: (NSInteger) startYear
                         finishYear: (NSInteger) finishYear
                             status: (NSString *) status
                              major: (NSString *) major;

-(TSweetResponse *) getEducations: (NSInteger) memberId;

-(TSweetResponse *) updateEducation: (NSInteger) memberId
                        educationId: (NSInteger) educationId
                             degree: (NSString *) degree
                          startYear: (NSInteger) startYear
                         finishYear: (NSInteger) finishYear
                             status: (NSString *) status
                              major: (NSString *) major;

-(TSweetResponse *) deleteEducation: (NSInteger) memberId
                        educationId: (NSInteger) educationId;

-(TSweetResponse *) createJob: (NSInteger) memberId
                        title: (NSString *) title
                    startYear: (NSInteger) startYear
                   finishYear: (NSInteger) finishYear
                       status: (NSString *) status
                      company: (NSString *) company;

-(TSweetResponse *) getJobs: (NSInteger) memberId;

-(TSweetResponse *) updateJob: (NSInteger) memberId
                        jobId: (NSInteger) jobId
                        title: (NSString *) title
                    startYear: (NSInteger) startYear
                   finishYear: (NSInteger) finishYear
                       status: (NSString *) status
                        company: (NSString *) company;

-(TSweetResponse *) deleteJob: (NSInteger) memberId
                        jobId: (NSInteger) jobId;

-(TSweetResponse *) like: (NSInteger) memberId;

-(TSweetResponse *) comment: (NSInteger) memberId
                    comment: (NSString *) comment;

-(TSweetResponse *) likeComment: (NSInteger) memberId
                      commentId: (NSInteger) commentId;

-(TSweetResponse *) getSocialMedias: (NSInteger) memberId;

@end
