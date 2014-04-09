//
//  MembersCommunicator.m
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 4/1/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import "TSweetMembersCommunicator.h"

@implementation MembersCommunicator

+(id)shared
{
    static MembersCommunicator * shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

-(TSweetResponse *)get:(NSString *)memberId
{
    NSString * route = [NSString stringWithFormat:@"/members/%@", memberId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)update:(NSString *)memberId maritalStatus:(NSString *)maritalStatus dob:(NSString *)dob pob:(NSString *)pob dod:(NSString *)dod pod:(NSString *)pod email:(NSString *)email
{
    NSString * route = [NSString stringWithFormat:@"/members/%@", memberId];
    NSDictionary * parameters = @{
                                    @"marital_status": maritalStatus,
                                    @"dob": dob,
                                    @"pob": pob,
                                    @"dod": dod,
                                    @"pod": pod,
                                    @"email": email
                                  };
    
    return [[TSweetRest shared] put:route parameters: parameters];
}

-(TSweetResponse *)uploadPhoto:(NSString *)memberId data:(NSString *)data extension:(NSString *)extension
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/photos", memberId];
    NSDictionary * parameters = @{
                                  @"data": data,
                                  @"extension": extension
                                  };
    
    return [[TSweetRest shared] put:route parameters: parameters];
}

-(TSweetResponse *)createRelation:(NSString *)memberA isAlive:(NSString *)isAlive name:(NSString *)name relation:(NSString *)relation isRoot:(NSString *)isRoot mobile:(NSString *)mobile dob:(NSString *)dob
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/relations", memberA];
    NSDictionary * parameters = @{
                                  @"is_alive": isAlive,
                                  @"name": name,
                                  @"relation": relation,
                                  @"is_root": isRoot,
                                  @"mobile": mobile,
                                  @"dob": dob
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)deleteRelation:(NSString *)memberA memberB:(NSString *)memberB
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/relations", memberA];
    NSDictionary * parameters = @{ @"member_b": memberB };
    
    return [[TSweetRest shared] delete:route parameters: parameters];
}

-(TSweetResponse *)createEducation:(NSString *)memberId degree:(NSString *)degree startYear:(NSString *)startYear finishYear:(NSString *)finishYear status:(NSString *)status major:(NSString *)major
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/educations", memberId];
    NSDictionary * parameters = @{
                                  @"degree": degree,
                                  @"start_year": startYear,
                                  @"finish_year": finishYear,
                                  @"status": status,
                                  @"major": major
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)getEducations:(NSString *)memberId
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/educations", memberId];

    return [[TSweetRest shared] get:route];
}

- (TSweetResponse *)updateEducation:(NSString *)memberId educationId:(NSString *)educationId degree:(NSString *)degree startYear:(NSString *)startYear finishYear:(NSString *)finishYear status:(NSString *)status major:(NSString *)major
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/educations/%@", memberId, educationId];
    NSDictionary * parameters = @{
                                  @"degree": degree,
                                  @"start_year": startYear,
                                  @"finish_year": finishYear,
                                  @"status": status,
                                  @"major": major
                                  };
    
    return [[TSweetRest shared] put:route parameters: parameters];
}

-(TSweetResponse *)deleteEducation:(NSString *)memberId educationId:(NSString *)educationId
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/educations/%@", memberId, educationId];

    return [[TSweetRest shared] delete:route parameters: nil];
}

-(TSweetResponse *)createJob:(NSString *)memberId title:(NSString *)title startYear:(NSString *)startYear finishYear:(NSString *)finishYear status:(NSString *)status company:(NSString *)company
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/jobs", memberId];
    NSDictionary * parameters = @{
                                  @"title": title,
                                  @"start_year": startYear,
                                  @"finish_year": finishYear,
                                  @"status": status,
                                  @"company": company
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)getJobs:(NSString *)memberId
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/jobs", memberId];
    
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)updateJob:(NSString *)memberId jobId:(NSString *)jobId title:(NSString *)title startYear:(NSString *)startYear finishYear:(NSString *)finishYear status:(NSString *)status company:(NSString *)company
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/jobs/%@", memberId, jobId];
    NSDictionary * parameters = @{
                                  @"title": title,
                                  @"start_year": startYear,
                                  @"finish_year": finishYear,
                                  @"status": status,
                                  @"company": company
                                  };
    
    return [[TSweetRest shared] put:route parameters: parameters];
}

-(TSweetResponse *)deleteJob:(NSString *)memberId jobId:(NSString *)jobId
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/jobs/%@", memberId, jobId];
    return [[TSweetRest shared] delete:route parameters: nil];
}

-(TSweetResponse *)like:(NSString *)memberId
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/like", memberId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)comment:(NSString *)memberId comment:(NSString *)comment
{
    NSString * route = [NSString stringWithFormat:@"/members/%@/comment", memberId];
    NSDictionary * parameters = @{ @"comment": comment };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)likeComment:(NSString *)memberId commentId:(NSString *)commentId
{
    NSString * route = [NSString stringWithFormat:@"members/%@/comments/%@/like", memberId, commentId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)getSocialMedias:(NSString *)memberId
{
    NSString * route = [NSString stringWithFormat:@"members/%@/socialmedias", memberId];
    return [[TSweetRest shared] get:route];
}

@end
