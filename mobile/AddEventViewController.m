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
        
        //[circles setObject:@"Family and close" forKey:@"1"];
        //[circles setObject:@"Kids" forKey:@"2"];
        TSweetResponse * tsr = [[CirclesCommunicator shared] get];
        
        for (NSDictionary * tempCircle in tsr.json)
        {
            [circles setObject:tempCircle[@"name"] forKey:tempCircle[@"id"]];
        }
        
        self.formController.form = [[AddEventForm alloc] initWithCircles: circles];
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

- (IBAction)addEvent:(id)sender {
    //self.formController
    //NSLog(@"%@", self.formController.form);
    
    AddEventForm * form = (AddEventForm *)self.formController.form;
    
    // TODO: Validation.
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString * circlesString = [NSString stringWithFormat:@"[%@]", [form.circles componentsJoinedByString:@","]];
    
    // Send the adding request.
    // TODO: Remember to make latitude and longitude.
    TSweetResponse * tsr = [[EventsCommunicator shared] create:form.title startDatetime:[dateFormatter stringFromDate:form.startDate] finishDatatime:[dateFormatter stringFromDate:form.finishDate] location:form.location circles:circlesString latitude:@"0.0" longitude:@"0.0"];

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
