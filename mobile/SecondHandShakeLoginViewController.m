//
//  SecondHandShakeLoginViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "SecondHandShakeLoginViewController.h"
#import "UpdateInfoFirstTimeViewController.h"

#import "TreeViewController.h"
#import "TSweetResponse.h"
#import "TSweetUsersCommunicator.h"

@interface SecondHandShakeLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *smsTokenTextField;

@end

@implementation SecondHandShakeLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)login:(id)sender {
    
    // TODO: Set the user information.
    
    NSString * smsToken = _smsTokenTextField.text;
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityView.center=self.view.center;
    
    [activityView startAnimating];
    NSLog(@"start animating...");
    
    [self.view addSubview:activityView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        TSweetResponse * tsr = [[UsersCommunicator shared] login:_mobile smsToken:smsToken];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            NSLog(@"stop animating...");
            [activityView stopAnimating];
            
            UIAlertView * responseAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:tsr.json[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [responseAlert show];
            
            if (tsr.code == 200)
            {
                
                // TODO: Login the user.
                TSweetRest * tsrest = [TSweetRest shared];
                tsrest.userToken = tsr.json[@"user_token"];
                
                // Get the member id as an integer.
                int member_id = [[tsr.json objectForKey:@"member_id"] intValue];
                
                if (member_id == 0)
                {
                    NSLog(@"zero");
                    UpdateInfoFirstTimeViewController * updateInfoFirstTimeVC = (UpdateInfoFirstTimeViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"UpdateInfoFirstTime"];
                    
                    [self presentViewController:updateInfoFirstTimeVC animated:NO completion:nil];
                }
                else
                {
                    NSLog(@"non-zero");
                    UITabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
                    
                    [self presentViewController:tbc animated:YES completion:nil];
                }
            }
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self.mobile);
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
