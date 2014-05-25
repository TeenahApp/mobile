//
//  AddMemberEducationViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/25/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddMemberEducationViewController.h"

@interface AddMemberEducationViewController ()

@end

@implementation AddMemberEducationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        // TODO: Consider removing none from education.
        
        NSMutableDictionary * degrees = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * statuses = [[NSMutableDictionary alloc] init];
        
        degrees = [
                   @{
                        @"elementary": @"Elementary", @"intermediate": @"Intermediate", @"secondary": @"Secondary",
                        @"diploma": @"Diploma", @"licentiate": @"Licentiate", @"bachelor": @"Bachelor",
                        @"master": @"Master", @"doctorate": @"Doctorate",
                    }
        mutableCopy];
        
        statuses = [@{
                      @"ongoing": @"On Going", @"finished": @"Finished", @"pending": @"Pending", @"dropped": @"Dropped"
                    }
        mutableCopy];

        self.form = [[AddMemberEducationForm alloc] initWithDegrees:degrees statuses:statuses];
        
        self.form.degree = @"elementary";
        self.form.status = @"ongoing";
        
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

- (void)updateFields
{
    //refresh the form
    self.formController.form = self.formController.form;
    [self.tableView reloadData];
}

-(void)submitAddingEducationForm
{
    NSLog(@"submitAddingEducationForm");
    NSLog(@"s = %d, f = %d", self.form.startYear, self.form.finishYear);
    
    // TODO: Validation.
    
    NSString * major = @"";
    
    if (self.form.major != nil)
    {
        major = self.form.major;
    }
    
    TSweetResponse * tsr = [[MembersCommunicator shared] createEducation:self.memberId degree:self.form.degree startYear:self.form.startYear finishYear:self.form.finishYear status:self.form.status major:major];
    
    if (tsr.code == 201)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
