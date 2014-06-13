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
    
    TSweetResponse * getEventsResponse = [[EventsCommunicator shared] getEvents];
    
    NSDateFormatter * shortDateFormatter = [[NSDateFormatter alloc] init];
    [shortDateFormatter setDateFormat:@"dd MMM yyyy"];
    
    // Initialize the sections array.
    self.sections = [[NSMutableArray alloc] init];
    self.data = [[NSMutableArray alloc] init];
    
    int section = -1;
    
    for (NSDictionary * tempEvent in getEventsResponse.json)
    {
        TEvent * event = [[TEvent alloc] initWithJson:tempEvent];

        NSString * startDateString = [shortDateFormatter stringFromDate:event.startsAt];
        
        if (![self.sections containsObject:startDateString])
        {
            [self.sections addObject:startDateString];
            [self.data addObject:[[NSMutableArray alloc] init]];

            section++;
        }
        
        // Add rows to corresponing sections.
        NSMutableArray * temp = [self.data objectAtIndex:section];
        [temp addObject:event];
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

#pragma mark - Navigation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showEvent" sender:tableView];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showAddEvent"])
    {
        AddEventViewController *vc = (AddEventViewController *) [segue destinationViewController];

        [vc initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
    }
    
    else if ([[segue identifier] isEqualToString:@"showEvent"])
    {
        ViewEventTableViewController *vc = (ViewEventTableViewController *) [segue destinationViewController];
        
        UITableView * table = (UITableView *)sender;
        NSIndexPath * indexPath = [table indexPathForSelectedRow];
        
        //NSLog(@"path = %@", indexPath);
        
        NSMutableArray * rows = [self.data objectAtIndex:indexPath.section];
        TEvent * event = (TEvent *)[rows objectAtIndex:indexPath.row];
        
        // Set the event id to be opened.
        vc.eventId = event.eventId;
        
        //[vc initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
    }
    
    
}

@end
