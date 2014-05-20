//
//  AddEventForm.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/19/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface AddEventForm : NSObject <FXForm>

-(id)initWithCircles: (NSMutableDictionary *) circles;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *location;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *finishDate;

@property (nonatomic, strong) NSArray * circles;
@property (nonatomic, strong) NSArray * circleKeys;
@property (nonatomic, strong) NSArray * circleValues;

@end
