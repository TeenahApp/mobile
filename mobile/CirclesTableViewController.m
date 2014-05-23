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
    TSweetResponse * tsr = [[CirclesCommunicator shared] getCircles];
    
    self.circles = [[NSMutableArray alloc] init];
    
    for (NSDictionary * tempCircle in tsr.json)
    {
        TCircle * circle = [[TCircle alloc] initWithJson:tempCircle];
        [self.circles addObject:circle];
    }
    
    self.titleNavigationItem.title = [NSString stringWithFormat:@"Circles (%lu)", (unsigned long)self.circles.count];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    TCircle * current = [self.circles objectAtIndex:indexPath.row];
    
    cell.textLabel.text = current.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld Members", (long)current.membersCount];

    self.currentCircle = current;
    
    NSLog(@"Cell has been called");
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"ViewCircle"])
    {
        // Get reference to the destination view controller
        //YourViewController *vc = [segue destinationViewController];
        CircleViewController *vc = (CircleViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:object];
        //vc.relation = self.relation;
        //vc.memberA = self.member.memberId;
        
        vc.circle = self.currentCircle;

        NSLog(@"prepareForSegue: %@", self.currentCircle);
    }
}

@end
