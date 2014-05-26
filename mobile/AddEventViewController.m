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
        TSweetResponse * tsr = [[CirclesCommunicator shared] getCircles];
        
        for (NSDictionary * tempCircle in tsr.json)
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
    // TODO: Validation.
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //NSString * circlesString = [NSString stringWithFormat:@"[%@]", [form.circles componentsJoinedByString:@","]];
    
    // Send the adding request.
    // TODO: Remember to make latitude and longitude.
    TSweetResponse * tsr = [[EventsCommunicator shared] create:self.form.title startDatetime:self.form.startDate finishDatatime:self.form.finishDate location:self.form.location circles:self.form.circles latitude:[NSNumber numberWithFloat:self.form.coordinates.coordinate.latitude] longitude:[NSNumber numberWithFloat:self.form.coordinates.coordinate.longitude]];
    
    // TODO: Show an alert telling the user that everything is okay.
    
    // Done
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
