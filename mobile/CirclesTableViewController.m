//
//  CirclesTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/27/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "CirclesTableViewController.h"

@interface CirclesTableViewController ()

@end

@implementation CirclesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.circles = [[NSMutableArray alloc] init];
    
    UIColor * teenahAppBlueColor = [UIColor colorWithRed:(138/255.0) green:(174/255.0) blue:(223/255.0) alpha:1];
    
    self.navigationController.navigationBar.barTintColor = teenahAppBlueColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    // Show the no rows message if there is none.
    self.noRowsView = [[UIView alloc] initWithFrame:self.view.frame];
    self.noRowsView.backgroundColor = [UIColor clearColor];
    
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat noRowsMessageHeight = self.noRowsView.frame.size.height - navBarHeight - tabBarHeight;
    
    self.noRowsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.noRowsView.frame.size.width, noRowsMessageHeight)];
    self.noRowsLabel.numberOfLines = 0;
    self.noRowsLabel.shadowColor = [UIColor lightTextColor];
    self.noRowsLabel.textColor = [UIColor grayColor];
    self.noRowsLabel.shadowOffset = CGSizeMake(0, 1);
    self.noRowsLabel.backgroundColor = [UIColor clearColor];
    self.noRowsLabel.textAlignment =  NSTextAlignmentCenter;

    self.noRowsLabel.text = @"لم يتم إضافة دوائر حتّى الآن، ينبغي عليك إضافة بعض العلاقات الخاصّة بك لإنشاء دائرة (الأهل).";
    
    [self.noRowsView addSubview:self.noRowsLabel];
    self.noRowsView.hidden = YES;
    
    [self.tableView insertSubview:self.noRowsView belowSubview:self.tableView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Get the member information.
        TSweetResponse * getCirclesResponse = [[CirclesCommunicator shared] getCircles];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check if the response code is not successful.
            if (getCirclesResponse.code == 200)
            {
                [self.circles removeAllObjects];
                
                for (NSDictionary * tempCircle in getCirclesResponse.json)
                {
                    TCircle * circle = [[TCircle alloc] initWithJson:tempCircle];
                    [self.circles addObject:circle];
                }
            }
            else
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطأ أثناء قراءة الدوائر، الرجاء المحاولة مرّة أخرى." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                return;
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.circles.count == 0)
    {
        self.noRowsView.hidden = NO;
    }
    else
    {
        self.noRowsView.hidden = YES;
    }
    
    // Return the number of rows in the section.
    return self.circles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    TCircle * current = [self.circles objectAtIndex:indexPath.row];
    
    cell.textLabel.text = current.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld فرد", (long)current.membersCount];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCircle * selectedCircle = (TCircle *)[self.circles objectAtIndex:indexPath.row];
    
    self.currentCircle = selectedCircle;
    
    [self performSegueWithIdentifier:@"showCircleChats" sender:tableView];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showCircleChats"])
    {
        CircleChatsTableViewController * vc = (CircleChatsTableViewController *)[segue destinationViewController];
        
        vc.circleId = self.currentCircle.circleId;

        vc.hidesBottomBarWhenPushed = YES;
    }
    
    else if ([[segue identifier] isEqualToString:@"showAddCircle"])
    {
        AddCircleTableViewController * vc = (AddCircleTableViewController *)[segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
    }
}

@end
