//
//  AddMemberEducationForm.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/25/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddMemberEducationForm.h"

@implementation AddMemberEducationForm

-(id)initWithDegrees:(NSMutableDictionary *)degrees statuses:(NSMutableDictionary *)statuses
{   
    self = [super init];
    
    if(self)
    {
        // Degrees
        self.degreeKeys = [[NSMutableArray alloc] init];
        self.degreeValues = [[NSMutableArray alloc] init];
        
        self.degreeKeys = [degrees allKeys];
        self.degreeValues = [degrees allValues];
        
        // Statuses
        self.statusKeys = [[NSMutableArray alloc] init];
        self.statusValues = [[NSMutableArray alloc] init];
        
        self.statusKeys = [statuses allKeys];
        self.statusValues = [statuses allValues];
        
        // Years
        self.years = [NSMutableArray array];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
        
        for (NSInteger i = [components year]; i >= 1900 ; i--)
        {
            [self.years addObject:@(i)];
        }
    }
    
    return self;
}

- (NSArray *)fields
{
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    
    [temp addObject:@{FXFormFieldKey: @"degree", FXFormFieldTitle: @"الدرجة العلمية", FXFormFieldOptions: self.degreeKeys, FXFormFieldValueTransformer: ^(id input)
                      {
        NSInteger index = (NSInteger)[self.degreeKeys indexOfObject:input];
        return [self.degreeValues objectAtIndex:index];
        
    }, FXFormFieldHeader: @"الدرجة العلمية و التخصّص", FXFormFieldAction: @"updateFields"}];
    
    
    if (![self.degree isEqual:@"none"] && ![self.degree isEqual:@"elementary"] && ![self.degree isEqual:@"intermediate"])
    {
        [temp addObject:@{FXFormFieldKey: @"major", FXFormFieldTitle: @"التخصّص"}];
    }
    
    [temp addObject:@{FXFormFieldKey: @"startYear", FXFormFieldOptions: self.years, FXFormFieldHeader: @"سنوات الدراسة", FXFormFieldPlaceholder: @"-", FXFormFieldTitle: @"سنة البدء"}];
    
    [temp addObject:@{FXFormFieldKey: @"status", FXFormFieldOptions: self.statusKeys, FXFormFieldValueTransformer: ^(id input)
    {
        NSInteger index = (NSInteger)[self.statusKeys indexOfObject:input];
                         return [self.statusValues objectAtIndex:index];
                         
    }, FXFormFieldAction: @"updateFields", FXFormFieldTitle: @"حالة الدراسة"}];
    
    if (![self.status isEqual:@"ongoing"])
    {
        [temp addObject:@{FXFormFieldKey: @"finishYear", FXFormFieldOptions: self.years, FXFormFieldPlaceholder: @"-", FXFormFieldTitle: @"سنة الانتهاء"}];
    }
    
    return temp;
}

-(NSArray *)extraFields
{
    return @[ @{FXFormFieldTitle: @"إضافة التعليم", FXFormFieldHeader: @"", FXFormFieldAction: @"submitAddingEducationForm", @"textLabel.color": [UIColor colorWithRed:8./255.0 green:188/255.0 blue:0 alpha:1]} ];
}


@end
