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
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSLog(@"%@", self.relation);
    
    if ([self.relation isEqual: @"father"]) {
        self.isRootSegmented.hidden = false;
    }
    else
    {
        self.isRootSegmented.hidden = true;
    }
    
    //NSLog(@"zeee");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addRelation:(id)sender {
    
    NSLog(@"%@", self.memberA);
    NSLog(@"%@", self.relation);
    
    // TODO: Do some validation.
    
    NSString * isAlive = @"1";
    NSString * isRoot = @"0";
    
    if (self.isAliveSegmented.selectedSegmentIndex == 1)
    {
        isAlive = @"0";
    }
    
    if (self.isRootSegmented.selectedSegmentIndex == 1)
    {
        isRoot = @"1";
    }
    
    // Try to send the request.
    TSweetResponse * tsr = [[MembersCommunicator shared] createRelation:self.memberA isAlive:isAlive name:self.firstNameTextField.text relation:self.relation isRoot: isRoot mobile:self.mobileTextField.text dob:self.dobTextField.text];
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
