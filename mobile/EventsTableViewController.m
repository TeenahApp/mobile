//
//  EventsTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "EventsTableViewController.h"

@interface EventsTableViewController ()



@end

@implementation EventsTableViewController

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
    
    TSweetResponse * tsr = [[EventsCommunicator shared] list];
    
    NSDateFormatter * shortDateFormatter = [[NSDateFormatter alloc] init];
    [shortDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // Initialize the sections array.
    self.sections = [[NSMutableArray alloc] init];
    self.data = [[NSMutableArray alloc] init];
    
    int section = -1;
    
    for (NSDictionary * eventJson in tsr.json)
    {
        TEvent * event = [[TEvent alloc] initWithJson:eventJson];

        NSString * startDateString = [shortDateFormatter stringFromDate:event.startsAt];
        
        if (![self.sections containsObject:startDateString])
        {
            NSLog(@"Happened");
            [self.sections addObject:startDateString];
            [self.data addObject:[[NSMutableArray alloc] init]];
            
            section++;
        }
        
        // Add rows to corresponing sections.
        NSMutableArray * temp = [self.data objectAtIndex:section];
        [temp addObject:event];
    }
    
    //NSLog(@"data = %@", self.data);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray * rows = [self.data objectAtIndex:section];
    
    // Return the number of rows in the section.
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSMutableArray * rows = [self.data objectAtIndex:indexPath.section];
    TEvent * event = (TEvent *)[rows objectAtIndex:indexPath.row];
    
    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = event.location;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sections objectAtIndex:section];
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
    if ([[segue identifier] isEqualToString:@"AddEvent"])
    {
        AddEventViewController *vc = (AddEventViewController *) [segue destinationViewController];

        [vc initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
    }
    
    
}

@end
