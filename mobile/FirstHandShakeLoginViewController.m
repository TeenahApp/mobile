//
//  FirstHandShakeLoginViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/10/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "FirstHandShakeLoginViewController.h"

@interface FirstHandShakeLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;

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

    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"mobile: %@", mobile);
        
        TSweetResponse * tsr = [[UsersCommunicator shared] tokenize: mobile];
        NSLog(@"%@", tsr);
        
        [activityView stopAnimating];
        NSLog(@"stop animating...");
        
        if (tsr.code == 403)
        {
            UIAlertView * notAuthorizedAlert = [[UIAlertView alloc] initWithTitle:@"No network connection" message:@"You must be connected to the internet to use this app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [notAuthorizedAlert show];
            
            SecondHandShakeLoginViewController * secondHandShakeLoginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondHandShakeLogin"];
            
            [self presentViewController:secondHandShakeLoginVC animated:NO completion:nil];
        }
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
