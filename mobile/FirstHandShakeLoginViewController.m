//
//  FirstHandShakeLoginViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/10/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "FirstHandShakeLoginViewController.h"

@interface FirstHandShakeLoginViewController ()

@end

@implementation FirstHandShakeLoginViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)attempt:(id)sender {
    
    // TODO: Validate user inputs.

    NSString * mobile = [NSString stringWithFormat:@"%@%@", _keyTextField.text, _mobileTextField.text];
    
    NSLog(@"Full mobile = %@", mobile);
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    activityView.center=self.view.center;
    
    [activityView startAnimating];
    NSLog(@"start animating...");
    
    [self.view addSubview:activityView];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"mobile: %@", mobile);
        
        TSweetResponse * tsr = [[UsersCommunicator shared] tokenize: mobile];
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
                SecondHandShakeLoginViewController * secondHandShakeLoginVC = (SecondHandShakeLoginViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"SecondHandShakeLogin"];
                
                secondHandShakeLoginVC.mobile = mobile;
                
                [self presentViewController:secondHandShakeLoginVC animated:NO completion:nil];
            }
            
        });
        
    });
    
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
