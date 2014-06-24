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
}

-(void)viewDidAppear:(BOOL)animated
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Get the member information.
        TSweetResponse * getCirclesResponse = [[CirclesCommunicator shared] getCircles];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // TODO: Check if the response code is not successful.
            if (getCirclesResponse.code == 200)
            {
                [self.circles removeAllObjects];
                
                for (NSDictionary * tempCircle in getCirclesResponse.json)
                {
                    TCircle * circle = [[TCircle alloc] initWithJson:tempCircle];
                    [self.circles addObject:circle];
                }
            }
            
            [self.tableView reloadData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
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
