//
//  AddRelationViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/22/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddRelationViewController.h"

@interface AddRelationViewController ()

@end

@implementation AddRelationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
        
        self.form = [[AddRelationForm alloc] init];
        
        // Set the variables.
        self.form.relationship = self.relation;
        self.form.isAlive = YES;

        self.formController.form = self.form;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addRelation:(id)sender {
    
    NSLog(@"Member A: %d", self.memberA);
    NSLog(@"Relation: %@", self.relation);

    // TODO: Do some validation.
    
    if (self.form.mobile == nil)
    {
        self.form.mobile = [NSNull null];
    }
    
    if (self.form.dob == nil)
    {
        self.form.dob = [NSNull null];
    }
    
    if (self.form.dod == nil)
    {
        self.form.dod = [NSNull null];
    }
    
    NSLog(@"name = %@, is_alive = %d, relation = %@, is_root = %d, mobile = %@, dob = %@, dod = %@", self.form.name, self.form.isAlive, self.relation, self.form.isRoot, self.form.mobile, self.form.dob, self.form.dod);
    
    // Try to send the request.
    // TODO: Make the waiting indicator later.
    TSweetResponse * tsr = [[MembersCommunicator shared] createRelation:self.memberA isAlive:self.form.isAlive name:self.form.name relation:self.relation isRoot: self.form.isRoot mobile:self.form.mobile dob:self.form.dob dod:self.form.dod];
    
    if (tsr.code == 201)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
