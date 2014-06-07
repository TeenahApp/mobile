//
//  UpdateMemberFirstTimeForm.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/4/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface UpdateMemberFirstTimeForm : NSObject <FXForm>

@property (nonatomic, strong) NSString * gender;
@property (nonatomic, strong) NSString * firstName;
@property (nonatomic, strong) NSDate * dob;

@end
