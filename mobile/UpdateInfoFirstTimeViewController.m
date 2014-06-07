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
#import "FirstUploadPhotoViewController.h"

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

        self.form = [[UpdateMemberFirstTimeForm alloc] init];
        self.form.gender = @"ذكر";
        
        self.formController.form = self.form;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    UIColor * teenahAppBlueColor = [UIColor colorWithRed:(138/255.0) green:(174/255.0) blue:(223/255.0) alpha:1];

    self.navigationController.navigationBar.barTintColor = teenahAppBlueColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)submitUpdatingMemberInfoForm
{
    NSString * gender = @"male";
    
    if ([self.form.gender isEqual:@"أنثى"])
    {
        gender = @"female";
    }
    
    TSweetResponse * tsr = [[UsersCommunicator shared] initialize:gender name:self.form.firstName dob:self.form.dob];
    
    if (tsr.code == 201)
    {
        NSString * memberId = tsr.json[@"member_id"];
        
        [UICKeyChainStore setString:memberId forKey:@"usertoken" service:@"com.teenah-app.mobile"];
        
        if ([gender isEqual: @"male"])
        {
            [self performSegueWithIdentifier:@"showUploadPhotoView" sender:self];
        }
        else
        {
            [self performSegueWithIdentifier:@"showMainTabBarView" sender:self];
        }
    }

    // Done.
    [self performSegueWithIdentifier:@"showUploadPhotoView" sender:self];
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
