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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // TODO: Handling errors and/or warnings.
    TSweetResponse * getCirclesResponse = [[CirclesCommunicator shared] getCircles];
    
    self.circles = [[NSMutableArray alloc] init];
    
    for (NSDictionary * tempCircle in getCirclesResponse.json)
    {
        TCircle * circle = [[TCircle alloc] initWithJson:tempCircle];
        [self.circles addObject:circle];
    }
    
    UIColor * teenahAppBlueColor = [UIColor colorWithRed:(138/255.0) green:(174/255.0) blue:(223/255.0) alpha:1];
    
    self.navigationController.navigationBar.barTintColor = teenahAppBlueColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
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
}

@end
