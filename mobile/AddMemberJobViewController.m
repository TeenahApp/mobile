//
//  AddMemberJobViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddMemberJobViewController.h"

@interface AddMemberJobViewController ()

@end

@implementation AddMemberJobViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
        NSMutableDictionary * statuses = [[NSMutableDictionary alloc] init];
        
        statuses = [@{
                      @"ongoing": @"On Going", @"finished": @"Finished", @"pending": @"Pending", @"dropped": @"Dropped"
                      }
        mutableCopy];
        
        self.form = [[AddMemberJobForm alloc] initWithStatuses:statuses];
        
        self.form.status = @"ongoing";
        
        self.formController.form = self.form;
    }
    return self;
}

-(void)submitAddingJobForm
{
    NSLog(@"submitAddingJobForm");
    NSLog(@"s = %d, f = %d", self.form.startYear, self.form.finishYear);
    
    // TODO: Validation.
    
    TSweetResponse * tsr = [[MembersCommunicator shared] createJob:self.memberId title:self.form.title startYear:self.form.startYear finishYear:self.form.finishYear status:self.form.status company:self.form.company];
    
    if (tsr.code == 201)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
