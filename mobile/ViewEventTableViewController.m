//
//  ViewEventTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/27/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "ViewEventTableViewController.h"

@interface ViewEventTableViewController ()

@end

@implementation ViewEventTableViewController

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
    
    TSweetResponse * tsr = [[EventsCommunicator shared] getEvent:1];
    
    if (tsr.code == 200)
    {
        self.event = [[TEvent alloc] initWithJson:tsr.json];
    }
    
    // Set some initial values.
    self.title = self.event.title;
    
    CLLocation * coordinates = [[CLLocation alloc] initWithLatitude:[self.event.latitude floatValue] longitude:[self.event.longitude floatValue]];
    self.mapView.centerCoordinate = coordinates.coordinate;
    
    NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
    [longDateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    
    NSString * eventTime = [NSString stringWithFormat:@"%@ - %@", [longDateFormatter stringFromDate:self.event.startsAt], [longDateFormatter stringFromDate:self.event.finishesAt]];
    
    NSString * eventStats = [NSString stringWithFormat:@"L %d, C %d", self.event.likesCount, self.event.commentsCount];
    
    self.sections = @[@"Main Info", @"Comments"];
    
    self.data = [@[
                   @[
                       @{eventTime: eventStats},
                       @{@"Decision": @"willcome"}
                    ],
                   
                   @[
                       @{@"1": @"Hello world"},
                    ],
    ] mutableCopy];
    
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
    // Return the number of rows in the section.
    NSArray * rows = [self.data objectAtIndex:section];
    return rows.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * temp = [self.sections objectAtIndex:section];
    return temp;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * rows = [self.data objectAtIndex:indexPath.section];
    NSDictionary * info = [rows objectAtIndex:indexPath.row];
    
    NSString * key = [[info allKeys] objectAtIndex:0];
    NSString * value = [info objectForKey:key];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell" forIndexPath:indexPath];
        
            cell.textLabel.text = key;
            cell.detailTextLabel.text = value;
            
            return cell;
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DecisionCell" forIndexPath:indexPath];
            
            return cell;
        }
    }

    // It is a comment then.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell"];
        return cell.bounds.size.height;
    }
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        return cell.bounds.size.height;
    }
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
