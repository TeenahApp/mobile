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
    
    // Initialize the sections array.
    self.sections = [[NSMutableArray alloc] init];
    self.data = [[NSMutableArray alloc] init];
    
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

    self.noRowsLabel.text = @"لم يتم إضافة مناسبات حتّى الآن، يُمكنك إضافة مناسبة من خلال أيقونة (+) في أعلى اليمين.";

    [self.noRowsView addSubview:self.noRowsLabel];
    self.noRowsView.hidden = YES;

    [self.tableView insertSubview:self.noRowsView belowSubview:self.tableView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDateFormatter * shortDateFormatter = [[NSDateFormatter alloc] init];
    [shortDateFormatter setDateFormat:@"dd MMM yyyy"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        TSweetResponse * getEventsResponse;
        
        if (self.circleId == 0)
        {
            getEventsResponse = [[EventsCommunicator shared] getEvents];
        }
        else
        {
            getEventsResponse = [[CirclesCommunicator shared] getEvents:self.circleId];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check if the response code is not successful.
            if (getEventsResponse.code == 200)
            {
                [self.sections removeAllObjects];
                [self.data removeAllObjects];
                
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
            }
            else
            {
                self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"ينبغي عليك الانضمام إلى دائرة واحدة على الأقل لتتمكّن من استعراض المناسبات." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.alert show];
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
    NSLog(@"self.data.count = %d", self.data.count);
    
    if (self.data.count == 0)
    {
        self.noRowsView.hidden = NO;
    }
    else
    {
        self.noRowsView.hidden = YES;
    }
    
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

        id tempVC = [vc initWithNibName:nil bundle:nil];
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
