//
//  AddRelationForm.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/22/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddRelationForm.h"

@implementation AddRelationForm

-(NSArray *)fields
{
    NSLog(@"Fields have been called.");
    
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    
    [temp addObject:@{FXFormFieldKey: @"name", FXFormFieldHeader: @"Snippet"}];
    [temp addObject:@{FXFormFieldKey: @"mobile", FXFormFieldPlaceholder: @"Optional"}];
    [temp addObject:@{FXFormFieldKey: @"dob", FXFormFieldHeader: @"History/Present"}];
    [temp addObject:@{FXFormFieldKey: @"isAlive", FXFormFieldAction: @"updateFields"}];
    
    // TODO: Show or hide the dod.
    if (self.isAlive == NO)
    {
        [temp addObject:@{FXFormFieldKey: @"dod"}];
    }
    
    if ([self.relationship isEqual: @"father"])
    {
        [temp addObject:@{FXFormFieldKey: @"isRoot", FXFormFieldHeader: @"Root"}];
    }
    
    return temp;
}

@end
