//
//  UpdateInfoFirstTimeViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UpdateInfoFirstTimeViewController.h"

#import "TSweetResponse.h"
#import "TSweetUsersCommunicator.h"

@interface UpdateInfoFirstTimeViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmented;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *dobTextField;
@end

@implementation UpdateInfoFirstTimeViewController

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
}
- (IBAction)updateInfo:(id)sender {
    
    NSString * gender = @"male";
    NSString * name = _firstNameTextField.text;
    NSString * dob = _dobTextField.text;
    
    if (_genderSegmented.selectedSegmentIndex == 1)
    {
        gender = @"female";
    }
    
    TSweetResponse * tsr = [[UsersCommunicator shared] initialize:gender name:name dob:dob];

    //"member_id" = 2;
    //"user_token" = "$2y$10$cHmOiWliDZpb2UhfCwcPrenQgoWhHj0l.Dy.DbK7zYjLfOze5Bz2m";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
