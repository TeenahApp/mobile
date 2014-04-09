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

-(TSweetResponse *) get: (NSString *) memberId;

-(TSweetResponse *) update: (NSString *) memberId
             maritalStatus: (NSString *) maritalStatus
                       dob: (NSString *) dob
                       pob: (NSString *) pob
                       dod: (NSString *) dod
                       pod: (NSString *) pod
                     email: (NSString *) email;

-(TSweetResponse *) uploadPhoto: (NSString *) memberId
                           data: (NSString *) data
                      extension: (NSString *) extension;

-(TSweetResponse *) createRelation: (NSString *) memberA
                           isAlive: (NSString *) isAlive
                              name: (NSString *) name
                          relation: (NSString *) relation
                            isRoot: (NSString *) isRoot
                            mobile: (NSString *) mobile
                               dob: (NSString *) dob;

-(TSweetResponse *) deleteRelation: (NSString *) memberA
                           memberB: (NSString *) memberB;

-(TSweetResponse *) createEducation: (NSString *) memberId
                             degree: (NSString *) degree
                          startYear: (NSString *) startYear
                         finishYear: (NSString *) finishYear
                             status: (NSString *) status
                              major: (NSString *) major;

-(TSweetResponse *) getEducations: (NSString *) memberId;

-(TSweetResponse *) updateEducation: (NSString *) memberId
                        educationId: (NSString *) educationId
                             degree: (NSString *) degree
                          startYear: (NSString *) startYear
                         finishYear: (NSString *) finishYear
                             status: (NSString *) status
                              major: (NSString *) major;

-(TSweetResponse *) deleteEducation: (NSString *) memberId
                        educationId: (NSString *) educationId;

-(TSweetResponse *) createJob: (NSString *) memberId
                        title: (NSString *) title
                    startYear: (NSString *) startYear
                   finishYear: (NSString *) finishYear
                       status: (NSString *) status
                      company: (NSString *) company;

-(TSweetResponse *) getJobs: (NSString *) memberId;

-(TSweetResponse *) updateJob: (NSString *) memberId
                        jobId: (NSString *) jobId
                        title: (NSString *) title
                    startYear: (NSString *) startYear
                   finishYear: (NSString *) finishYear
                       status: (NSString *) status
                        company: (NSString *) company;

-(TSweetResponse *) deleteJob: (NSString *) memberId
                        jobId: (NSString *) jobId;

-(TSweetResponse *) like: (NSString *) memberId;

-(TSweetResponse *) comment: (NSString *) memberId
                    comment: (NSString *) comment;

-(TSweetResponse *) likeComment: (NSString *) memberId
                      commentId: (NSString *) commentId;

-(TSweetResponse *) getSocialMedias: (NSString *) memberId;

@end
