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

-(TSweetResponse *)getMember:(NSInteger)memberId
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld", (long)memberId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)updateMember:(NSInteger)memberId maritalStatus:(NSString *)maritalStatus dob:(NSDate *)dob pob:(NSString *)pob dod:(NSDate *)dod pod:(NSString *)pod email:(NSString *)email
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld", (long)memberId];
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

-(TSweetResponse *)uploadPhoto:(NSInteger)memberId data:(NSData *)data extension:(NSString *)extension
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/photos", (long)memberId];
    NSDictionary * parameters = @{
                                  @"data": data,
                                  @"extension": extension
                                  };
    
    return [[TSweetRest shared] put:route parameters: parameters];
}

-(TSweetResponse *)createRelation:(NSInteger)memberA isAlive:(BOOL)isAlive name:(NSString *)name relation:(NSString *)relation secondRelation:(NSString *)secondRelation mobile:(NSString *)mobile dob:(NSDate *)dob dod:(NSDate *)dod
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/relations", (long)memberA];
    NSDictionary * parameters = @{
                                  @"is_alive": [NSNumber numberWithBool:isAlive],
                                  @"name": name,
                                  @"relation": relation,
                                  @"second_relation": secondRelation,
                                  @"mobile": mobile,
                                  @"dob": dob,
                                  @"dod": dod
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)deleteRelation:(NSInteger)memberA memberB:(NSInteger)memberB
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/relations", (long)memberA];
    NSDictionary * parameters = @{ @"member_b": [NSNumber numberWithInteger:memberB] };
    
    return [[TSweetRest shared] delete:route parameters: parameters];
}

-(TSweetResponse *)createEducation:(NSInteger)memberId degree:(NSString *)degree startYear:(NSInteger)startYear finishYear:(NSInteger)finishYear status:(NSString *)status major:(NSString *)major
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/educations", (long)memberId];
    NSDictionary * parameters = @{
                                  @"degree": degree,
                                  @"start_year": [NSNumber numberWithInteger:startYear],
                                  @"finish_year": [NSNumber numberWithInteger:finishYear],
                                  @"status": status,
                                  @"major": major
                                  };
    
    NSLog(@"%@", [parameters allValues]);
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)getEducations:(NSInteger)memberId
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/educations", (long)memberId];

    return [[TSweetRest shared] get:route];
}

- (TSweetResponse *)updateEducation:(NSInteger)memberId educationId:(NSInteger)educationId degree:(NSString *)degree startYear:(NSInteger)startYear finishYear:(NSInteger)finishYear status:(NSString *)status major:(NSString *)major
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/educations/%ld", (long)memberId, (long)educationId];
    NSDictionary * parameters = @{
                                  @"degree": degree,
                                  @"start_year": [NSNumber numberWithInteger:startYear],
                                  @"finish_year": [NSNumber numberWithInteger:finishYear],
                                  @"status": status,
                                  @"major": major
                                  };
    
    return [[TSweetRest shared] put:route parameters: parameters];
}

-(TSweetResponse *)deleteEducation:(NSInteger)memberId educationId:(NSInteger)educationId
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/educations/%ld", (long)memberId, (long)educationId];

    return [[TSweetRest shared] delete:route parameters: nil];
}

-(TSweetResponse *)createJob:(NSInteger)memberId title:(NSString *)title startYear:(NSInteger)startYear finishYear:(NSInteger)finishYear status:(NSString *)status company:(NSString *)company
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/jobs", (long)memberId];
    NSDictionary * parameters = @{
                                  @"title": title,
                                  @"start_year": [NSNumber numberWithInteger:startYear],
                                  @"finish_year": [NSNumber numberWithInteger:finishYear],
                                  @"status": status,
                                  @"company": company
                                  };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)getJobs:(NSInteger)memberId
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/jobs", (long)memberId];
    
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)updateJob:(NSInteger)memberId jobId:(NSInteger)jobId title:(NSString *)title startYear:(NSInteger)startYear finishYear:(NSInteger)finishYear status:(NSString *)status company:(NSString *)company
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/jobs/%ld", (long)memberId, (long)jobId];
    NSDictionary * parameters = @{
                                  @"title": title,
                                  @"start_year": [NSNumber numberWithInteger:startYear],
                                  @"finish_year": [NSNumber numberWithInteger:finishYear],
                                  @"status": status,
                                  @"company": company
                                  };
    
    return [[TSweetRest shared] put:route parameters: parameters];
}

-(TSweetResponse *)deleteJob:(NSInteger)memberId jobId:(NSInteger)jobId
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/jobs/%ld", (long)memberId, (long)jobId];
    return [[TSweetRest shared] delete:route parameters: nil];
}

-(TSweetResponse *) getMemberComments:(NSInteger)memberId
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/comments", (long)memberId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)likeMember:(NSInteger)memberId
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/like", (long)memberId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)commentOnMember:(NSInteger)memberId comment:(NSString *)comment
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/comment", (long)memberId];
    NSDictionary * parameters = @{ @"comment": comment };
    
    return [[TSweetRest shared] post:route parameters: parameters];
}

-(TSweetResponse *)likeCommentOnMember:(NSInteger)memberId commentId:(NSInteger)commentId
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/comments/%ld/like", (long)memberId, (long)commentId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)getSocialMedias:(NSInteger)memberId
{
    NSString * route = [NSString stringWithFormat:@"/members/%ld/socialmedias", (long)memberId];
    return [[TSweetRest shared] get:route];
}

-(TSweetResponse *)getMemberIdByMobile:(NSString *)mobile
{
    NSString * route = [NSString stringWithFormat:@"/mobiles/%@/member", mobile];
    return [[TSweetRest shared] get:route];
}

@end
