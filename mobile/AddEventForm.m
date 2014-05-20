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
             
             @{FXFormFieldKey: @"title", FXFormFieldHeader: @"Snippet"},
             @{FXFormFieldKey: @"location"},
             
             @{FXFormFieldKey: @"startDate", FXFormFieldHeader: @"Time"},
             @{FXFormFieldKey: @"finishDate"},
             
             //@{FXFormFieldKey: @"circles", FXFormFieldOptions: self.circles, FXFormFieldHeader: @"Circles/Invited"},
             
  
            @{FXFormFieldKey: @"circles", FXFormFieldOptions: self.circleKeys, FXFormFieldValueTransformer: ^(id input)
               {
                   NSInteger index = (NSInteger)[self.circleKeys indexOfObject:input];
                   return [self.circleValues objectAtIndex:index];

               }, FXFormFieldHeader: @"Invited"},
    ];
}

@end
