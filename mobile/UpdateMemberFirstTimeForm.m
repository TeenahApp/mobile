//
//  UpdateMemberFirstTimeForm.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/4/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UpdateMemberFirstTimeForm.h"

@implementation UpdateMemberFirstTimeForm

-(NSArray *)fields
{
    return
    @[
      @{FXFormFieldKey: @"gender", FXFormFieldTitle: @"الجنس", FXFormFieldHeader: @"معلومات أساسيّة", FXFormFieldOptions: @[@"ذكر", @"أنثى"]},
      @{FXFormFieldKey: @"firstName", FXFormFieldTitle: @"الاسم الأوّل", FXFormFieldPlaceholder: @"الاسم الأوّل باللغة العربيّة"},
      @{FXFormFieldKey: @"dob", FXFormFieldTitle: @"تاريخ الميلاد"},
    ];
}

-(NSArray *)extraFields
{
    return
    @[
      @{FXFormFieldTitle: @"استكمال التسجيل", FXFormFieldHeader: @"", FXFormFieldAction: @"submitUpdatingMemberInfoForm", @"textLabel.color": [UIColor colorWithRed:8./255.0 green:188/255.0 blue:0 alpha:1]}
    ];
}

@end
