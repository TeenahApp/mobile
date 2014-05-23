//
//  TJobCompany.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/24/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJobCompany : NSObject

@property NSInteger jobCompanyId;

@property (nonatomic, strong) NSString * logo;

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * category;

@property (nonatomic, strong) NSString * link;

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSDate * updatedAt;

@end
