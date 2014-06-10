//
//  UpdateMemberInfoForm.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UpdateMemberInfoForm.h"

@implementation UpdateMemberInfoForm

-(id)initWithMaritalStatuses:(NSMutableDictionary *)maritalStatuses
{
    self = [super init];
    
    if (self)
    {
        // Statuses
        self.maritalStatusKeys = [[NSMutableArray alloc] init];
        self.maritalStatusValues = [[NSMutableArray alloc] init];
        
        self.maritalStatusKeys = [maritalStatuses allKeys];
        self.maritalStatusValues = [maritalStatuses allValues];
    }
    
    return self;
}

-(NSArray *)fields
{
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    
    [temp addObject:@{FXFormFieldKey: @"isAlive", FXFormFieldTitle: @"حيّ يرزق", FXFormFieldHeader: self.displayName, FXFormFieldAction: @"updateFields"}];
    
    [temp addObject:@{FXFormFieldKey: @"maritalStatus", FXFormFieldOptions: self.maritalStatusKeys, FXFormFieldValueTransformer: ^(id input)
    {
        NSInteger index = (NSInteger)[self.maritalStatusKeys indexOfObject:input];
        
        return [self.maritalStatusValues objectAtIndex:index];
        
    }, FXFormFieldTitle: @"الحالة الاجتماعيّة", FXFormFieldPlaceholder: @"-"}];
    
    [temp addObject:@{FXFormFieldKey: @"dob", FXFormFieldTitle: @"تاريخ الميلاد", FXFormFieldHeader: @"التاريخ/الحاضر"}];
    [temp addObject:@{FXFormFieldKey: @"pob", FXFormFieldTitle: @"مكان الميلاد"}];
    
    if (self.isAlive == NO)
    {
        [temp addObject:@{FXFormFieldKey: @"dod", FXFormFieldTitle: @"تاريخ الوفاة"}];
        [temp addObject:@{FXFormFieldKey: @"pod", FXFormFieldTitle: @"مكان الوفاة"}];
    }
    else
    {
        self.dod = nil;
        self.pod = nil;
    }

    [temp addObject:@{FXFormFieldKey: @"email", FXFormFieldTitle: @"البريد الإلكتروني", FXFormFieldHeader: @"التواصل الاختياري"}];
    
    return temp;
}

-(NSArray *)extraFields
{
    return
    @[
      @{FXFormFieldTitle: @"تحديث البيانات", FXFormFieldHeader: @"", FXFormFieldAction: @"submitUpdatingMemberInfoForm", @"textLabel.color": [UIColor colorWithRed:8./255.0 green:188/255.0 blue:0 alpha:1]}
      ];
}

@end
