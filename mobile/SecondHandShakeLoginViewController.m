//
//  SecondHandShakeLoginViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "SecondHandShakeLoginViewController.h"
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
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityView.center=self.view.center;
    
    [activityView startAnimating];
    NSLog(@"start animating...");
    
    [self.view addSubview:activityView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"mobile: %@", _mobile);
        
        TSweetResponse * tsr = [[UsersCommunicator shared] login:_mobile smsToken:smsToken];
        
        NSLog(@"%@", tsr);
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            NSLog(@"stop animating...");
            [activityView stopAnimating];
            
            UIAlertView * responseAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:tsr.json[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [responseAlert show];
            
            // TODO: For test only.
            tsr.code = 204;
            
            if (tsr.code == 204)
            {
                UITabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
                
                [self presentViewController:tbc animated:YES completion:nil];
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
