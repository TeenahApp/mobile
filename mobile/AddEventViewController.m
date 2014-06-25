//
//  AddEventViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/19/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddEventViewController.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"initWithNibName: %@, %@", nibBundleOrNil, nibBundleOrNil);
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        
        NSMutableDictionary * circles = [[NSMutableDictionary alloc] init];

        // Reach out for the circles.
        TSweetResponse * getCirclesResponse = [[CirclesCommunicator shared] getCircles];
        
        for (NSDictionary * tempCircle in getCirclesResponse.json)
        {
            [circles setObject:tempCircle[@"name"] forKey:tempCircle[@"id"]];
        }
        
        self.form = [[AddEventForm alloc] initWithCircles:circles];
        
        self.form.startDate = [NSDate date];
        
        self.formController.form = self.form;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //reload the table
    //[self.tableView reloadData];
}

-(void)submitAddingEventForm
{  
    // Validation.
    if (self.form.title == nil)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء إدخال عنوان المناسبة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        [self.alert show];
        return;
    }
    
    if (self.form.location == nil)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء إدخال موقع المناسبة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        [self.alert show];
        return;
    }
    
    if (self.form.coordinates == nil)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء تحديد إحداثيات المناسبة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        [self.alert show];
        return;
    }
    
    if (self.form.startDate == nil || self.form.finishDate == nil)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء تحديد وقت بدء و انتهاء المناسبة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        [self.alert show];
        return;
    }

    
    if (self.form.circles.count == 0)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء إدخال موقع المناسبة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        [self.alert show];
        return;
    }

    // Send the adding request.
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Get the member information.
        TSweetResponse * addEventResponse = [[EventsCommunicator shared] create:self.form.title startDatetime:self.form.startDate finishDatatime:self.form.finishDate location:self.form.location circles:self.form.circles latitude:[NSNumber numberWithFloat:self.form.coordinates.coordinate.latitude] longitude:[NSNumber numberWithFloat:self.form.coordinates.coordinate.longitude]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check if the response code is not successful.
            if (addEventResponse.code == 201)
            {
                NSInteger eventId = [addEventResponse.json[@"event_id"] integerValue];

                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    
                    // Get the event.
                    TSweetResponse * getEventResponse = [[EventsCommunicator shared] getEvent:eventId];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        // Check if the response code is not successful.
                        if (getEventResponse.code == 200)
                        {
                            self.event = [[TEvent alloc] initWithJson:getEventResponse.json];
                            
                            // Done
                            [self performSegueWithIdentifier:@"showEvent" sender:nil];
                        }
                        else
                        {
                            self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطـأ في جلب المناسبة، الرجاء المحاولة مرّة أخرى." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                        }
                        
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                });

            }
            else
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"لا يًمكن إضافة المناسبة، الرجاء التأكد من إدخال الحقول بشكل صحيح." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }

            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqual:@"showEvent"])
    {
        ViewEventTableViewController * vc = (ViewEventTableViewController *)[segue destinationViewController];
        vc.event = self.event;
    }
}

@end
