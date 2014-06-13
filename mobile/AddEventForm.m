//
//  AddEventForm.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/19/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddEventForm.h"

@implementation AddEventForm

-(id)initWithCircles: (NSMutableDictionary *) circles
{
    NSLog(@"AddEventForm created.");
    
    self = [super init];
    
    if(self)
    {
        // Invite all circles by default.
        self.circles = [[NSMutableArray alloc] init];
        self.circles = [circles allKeys];
        
        self.circleKeys = [[NSMutableArray alloc] init];
        self.circleValues = [[NSMutableArray alloc] init];
        
        self.circleKeys = [circles allKeys];
        self.circleValues = [circles allValues];
    }
    
    return self;
}

- (NSArray *)fields
{
    return @[
             
             //we want to add a group header for the field set of fields
             //we do that by adding the header key to the first field in the group
             
             @{FXFormFieldKey: @"title", FXFormFieldTitle: @"عنوان المناسبة", FXFormFieldHeader: @"نبذة"},
             
             @{FXFormFieldKey: @"location", FXFormFieldTitle: @"المدينة", FXFormFieldHeader: @"الموقع"},
             
             @{FXFormFieldKey: @"coordinates", FXFormFieldTitle: @"الإحداثيات", FXFormFieldViewController: @"LocationMapViewController"},
             
             @{FXFormFieldKey: @"startDate", FXFormFieldTitle: @"وقت البدء", FXFormFieldHeader: @"الوقت", FXFormFieldType: FXFormFieldTypeDateTime},
             @{FXFormFieldKey: @"finishDate", FXFormFieldTitle: @"وقت الإنتهاء", FXFormFieldType: FXFormFieldTypeDateTime},

  
             @{FXFormFieldKey: @"circles", FXFormFieldTitle: @"الدوائر", FXFormFieldOptions: self.circleKeys, FXFormFieldValueTransformer: ^(id input)
               {
                   NSInteger index = (NSInteger)[self.circleKeys indexOfObject:input];
                   return [self.circleValues objectAtIndex:index];

               }, FXFormFieldHeader: @"المدعوون"},
    ];
}

-(NSString *)coordinatesFieldDescription
{
    return self.coordinates? [NSString stringWithFormat:@"%f, %f", self.coordinates.coordinate.latitude, self.coordinates.coordinate.longitude] : nil;
}

-(NSArray *)extraFields
{
    return @[ @{FXFormFieldTitle: @"إضافة المناسبة", FXFormFieldHeader: @"", FXFormFieldAction: @"submitAddingEventForm", @"textLabel.color": [UIColor colorWithRed:8./255.0 green:188/255.0 blue:0 alpha:1]} ];
}

@end
