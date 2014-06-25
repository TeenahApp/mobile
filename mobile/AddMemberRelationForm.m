//
//  AddMemberRelationForm.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/22/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddMemberRelationForm.h"

@implementation AddMemberRelationForm

-(id)initWithRelations:(NSMutableDictionary *)relations
{
    self = [super init];
    
    if(self)
    {
        NSDictionary * secondRelations = @{@"full": @"شقيق", @"father": @"من طرف الأب", @"mother": @"من طرف الأم"};
        
        // Relations
        self.relationKeys = [[NSMutableArray alloc] init];
        self.relationValues = [[NSMutableArray alloc] init];
        
        self.relationKeys = [relations allKeys];
        self.relationValues = [relations allValues];
        
        // Second relations.
        self.secondRelationKeys = [[NSMutableArray alloc] init];
        self.secondRelationValues = [[NSMutableArray alloc] init];
        
        self.secondRelationKeys = [secondRelations allKeys];
        self.secondRelationValues = [secondRelations allValues];
    }

    return self;
}


-(NSArray *)fields
{

    NSMutableArray * temp = [[NSMutableArray alloc] init];
    
    [temp addObject:@{FXFormFieldKey: @"relationship", FXFormFieldHeader: @"معلومات العلاقة", FXFormFieldOptions: self.relationKeys,
                      FXFormFieldValueTransformer: ^(id input){
                            NSInteger index = (NSInteger)[self.relationKeys indexOfObject:input];
                            return [self.relationValues objectAtIndex:index];
                        }, FXFormFieldTitle: @"العلاقة", FXFormFieldAction: @"updateFields"
    }];
    
    // Add the corresponding relationship field.
    if ([self.relationship isEqual: @"father"])
    {
        [temp addObject:@{FXFormFieldKey: @"isRoot", FXFormFieldTitle: @"اسم هذا الفرد تُنسب إليه العائلة"}];
    }
    
    if ([self.relationship isEqual:@"brother"] || [self.relationship isEqual:@"sister"])
    {
        [temp addObject:@{FXFormFieldKey: @"secondRelationship", FXFormFieldOptions: self.secondRelationKeys,
            FXFormFieldValueTransformer: ^(id input){
                NSInteger index = (NSInteger)[self.secondRelationKeys indexOfObject:input];
                return [self.secondRelationValues objectAtIndex:index];
            }, FXFormFieldTitle: @"نوع الأخوّة", FXFormFieldAction: @"updateFields"
        }];
    }

    [temp addObject:@{FXFormFieldTitle: @"جلب فرد من جهات الإتصال", FXFormFieldType: FXFormFieldTypeLabel, @"textLabel.color": [UIColor colorWithRed:0./255.0 green:122/255.0 blue:255.0/255.0 alpha:1], @"textLabel.textAlignment": @(NSTextAlignmentCenter), FXFormFieldHeader: @"معلومات أوّليّة", FXFormFieldAction: @"showContacts"}];
    
    [temp addObject:@{FXFormFieldKey: @"name", FXFormFieldTitle: @"الاسم الأوّل", FXFormFieldPlaceholder: @"باللغة العربيّة"}];
    [temp addObject:@{FXFormFieldKey: @"mobile", FXFormFieldTitle: @"الجوّال", FXFormFieldPlaceholder: @"اختياري"}];
    
    [temp addObject:@{FXFormFieldKey: @"dob", FXFormFieldTitle: @"تاريخ الميلاد", FXFormFieldHeader: @"الماضي وَ الحاضر"}];
    [temp addObject:@{FXFormFieldKey: @"isAlive", FXFormFieldTitle: @"حيّ يرزق؟", FXFormFieldAction: @"updateFields"}];
    
    // Show or hide the dod.
    if (self.isAlive == NO)
    {
        [temp addObject:@{FXFormFieldKey: @"dod", FXFormFieldTitle: @"تاريخ الوفاة"}];
    }
    
    return temp;
}

-(NSArray *)extraFields
{
    return @[ @{FXFormFieldTitle: @"إضافة الفرد و العلاقة", FXFormFieldHeader: @"", FXFormFieldAction: @"submitAddingMemberRelationForm", @"textLabel.color": [UIColor colorWithRed:8./255.0 green:188/255.0 blue:0 alpha:1]} ];
}

@end
