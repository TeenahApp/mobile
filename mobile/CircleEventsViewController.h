//
//  CircleEventsViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MNCalendarView/MNCalendarView.h>

@interface CircleEventsViewController : UIViewController <MNCalendarViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *calendarView;

@end
