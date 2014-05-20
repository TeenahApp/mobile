//
//  AddEventTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddEventTableViewController.h"

@interface AddEventTableViewController ()

@end

@implementation AddEventTableViewController

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
    
    self.sections = @[@"Snippet", @"Time", @"Circles/Invited"];
    
    NSMutableArray * circles = [[NSMutableArray alloc]init];
    
    self.data = [@[
                   // Section 0: About:
                   @[
                       @{@"Title": @""},
                       @{@"Location": @""},
                    ],
                   
                   // Section 1: Time
                   @[
                       @{@"Start at": [NSDate date]},
                       @{@"End at": [NSDate date]}
                    ],
                   
                   // Section 2: Circles/Invited:
                   circles,

    ] mutableCopy];
    
    // Get the member circles.
    TSweetResponse * tsr = [[CirclesCommunicator shared] get];
    
    for (NSDictionary * temp in tsr.json)
    {
        TCircle * circle = [[TCircle alloc] init];
        [circle fromJson:temp];
        
        // Add the circle object to circles.
        [circles addObject:circle];
    }
    
    // Check the invited circles.
    if (self.invitedCircles == nil)
    {
        self.invitedCircles = circles;
    }
    
    self.mapView.delegate = self;
    
    // TODO: Get the closest place near to the user.
    CLLocationDegrees kDefaultLatitude = 24.6333;
    CLLocationDegrees kDefaultLongitude = 46.7167;
    
    self.coordinates = CLLocationCoordinate2DMake(kDefaultLatitude, kDefaultLongitude);
    
    self.span = MKCoordinateSpanMake(0.2, 0.2);
    self.region = MKCoordinateRegionMake(self.coordinates, self.span);

    [self.mapView setRegion:self.region];
    
    self.annotationPoint = [[MKPointAnnotation alloc] init];
    self.annotationPoint.coordinate = self.coordinates;
    
    [self.mapView addAnnotation:self.annotationPoint];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    // obtain the picker view cell's height, works because the cell was pre-defined in our storyboard
    UITableViewCell * pickerViewCellToCheck = [self.tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"];
    self.pickerCellRowHeight = pickerViewCellToCheck.frame.size.height;
    
    NSLog(@"%d", self.pickerCellRowHeight);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(localeChanged:)
                                                 name:NSCurrentLocaleDidChangeNotification
                                               object:nil];
}

#pragma mark - Locale

/*! Responds to region format or locale changes.
 */
- (void)localeChanged:(NSNotification *)notif
{
    // the user changed the locale (region format) in Settings, so we are notified here to
    // update the date format in the table view cells
    //
    [self.tableView reloadData];
}


#pragma mark - Utilities

/*! Returns the major version of iOS, (i.e. for iOS 6.1.3 it returns 6)
 */
NSUInteger DeviceSystemMajorVersion()
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    
    return _deviceSystemMajorVersion;
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
    NSInteger rowsCount = rows.count;
    
    if ([self hasInlineDatePicker] && section == 1)
    {
        rowsCount++;
        NSLog(@"Section: %d, Rows: %d", section, rowsCount);
    }
    
    return rowsCount;
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    self.coordinates = CLLocationCoordinate2DMake(self.mapView.region.center.latitude, self.mapView.region.center.longitude);
    self.annotationPoint.coordinate = self.coordinates;
}

- (BOOL)hasPickerForIndexPath:(NSIndexPath *)indexPath
{
    BOOL hasDatePicker = NO;
    
    NSInteger targetedRow = indexPath.row;
    targetedRow++;
    
    UITableViewCell *checkDatePickerCell =
    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:targetedRow inSection:1]];
    
    UIDatePicker *checkDatePicker = (UIDatePicker *)[checkDatePickerCell viewWithTag:99];

    hasDatePicker = (checkDatePicker != nil);
    return hasDatePicker;
}

- (void)updateDatePicker
{
    if (self.datePickerIndexPath != nil)
    {
        UITableViewCell *associatedDatePickerCell = [self.tableView cellForRowAtIndexPath:self.datePickerIndexPath];
        
        UIDatePicker *targetedDatePicker = (UIDatePicker *)[associatedDatePickerCell viewWithTag:99];
        if (targetedDatePicker != nil)
        {
            // we found a UIDatePicker in this cell, so update it's date value
            // TODO:
            //NSDictionary *itemData = self.dataArray[self.datePickerIndexPath.row - 1];
            //[targetedDatePicker setDate:[itemData valueForKey:kDateKey] animated:NO];
        }
    }
}

- (BOOL)hasInlineDatePicker
{
    return (self.datePickerIndexPath != nil);
}

- (BOOL)indexPathHasPicker:(NSIndexPath *)indexPath
{
    return ([self hasInlineDatePicker] && self.datePickerIndexPath.row == indexPath.row);
}

- (BOOL)indexPathHasDate:(NSIndexPath *)indexPath
{
    BOOL hasDate = NO;
    
    if ((indexPath.row == 0) ||
        (indexPath.row == 1 || ([self hasInlineDatePicker] && (indexPath.row == 2))))
    {
        hasDate = YES;
    }
    
    return hasDate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return ([self indexPathHasPicker:indexPath] ? self.pickerCellRowHeight : self.tableView.rowHeight);
    //return self.pickerCellRowHeight;
    
    if (indexPath.section == 1 && [self indexPathHasPicker:indexPath])
    {
        return self.pickerCellRowHeight;
    }
    else
    {
        return self.tableView.rowHeight;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * temp = [self.sections objectAtIndex:section];
    return temp;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * rows = [self.data objectAtIndex:indexPath.section];
    
    switch (indexPath.section) {
        
        case 0:
        {
            UIEditableTextTableViewCell *cell = (UIEditableTextTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"EditableTextCell" forIndexPath:indexPath];
            
            NSDictionary * info = [rows objectAtIndex:indexPath.row];
            
            NSString * key = [[info allKeys] objectAtIndex:0];
            NSString * value = [info objectForKey:key];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textField.placeholder = key;
            cell.textField.text = value;
            
            return cell;
        }
        break;
            
        case 2:
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CircleCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            TCircle * info = (TCircle *) [rows objectAtIndex:indexPath.row];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@", info.name];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Members", info.membersCount];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            return cell;
        }
        break;
            
        default:
        {
            if ([self indexPathHasPicker:indexPath])
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"];
                return cell;
            }
            
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSDictionary * info = [rows objectAtIndex:indexPath.row];
            
            NSString * key = [[info allKeys] objectAtIndex:0];
            NSString * value = [info objectForKey:key];
            
            // Fill the cell.
            cell.textLabel.text = [NSString stringWithFormat:@"%@", key];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", value];
            
            return cell;
            
        }
        break;
    }
    
    // TODO:
    // Either.
    return nil;
}

- (void)toggleDatePickerForSelectedIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:1]];
    
    // check if 'indexPath' has an attached date picker below it
    if ([self hasPickerForIndexPath:indexPath])
    {
        // found a picker below it, so remove it
        [self.tableView deleteRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        // didn't find a picker below it, so we should insert it
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView endUpdates];
}

- (void)displayInlineDatePickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // display the date picker inline with the table content
    [self.tableView beginUpdates];
    
    BOOL before = NO;   // indicates if the date picker is below "indexPath", help us determine which row to reveal
    
    if ([self hasInlineDatePicker])
    {
        before = self.datePickerIndexPath.row < indexPath.row;
    }
    
    BOOL sameCellClicked = (self.datePickerIndexPath.row - 1 == indexPath.row);
    
    // remove any date picker cell if it exists
    if ([self hasInlineDatePicker])
    {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datePickerIndexPath.row inSection:1]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.datePickerIndexPath = nil;
    }
    
    if (!sameCellClicked)
    {
        // hide the old date picker and display the new one
        NSInteger rowToReveal = (before ? indexPath.row - 1 : indexPath.row);
        NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:1];
        
        [self toggleDatePickerForSelectedIndexPath:indexPathToReveal];
        self.datePickerIndexPath = [NSIndexPath indexPathForRow:indexPathToReveal.row + 1 inSection:1];
    }
    
    // always deselect the row containing the start or end date
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tableView endUpdates];
    
    // inform our date picker of the current date to match the current cell
    [self updateDatePicker];
}

#define EMBEDDED_DATE_PICKER (DeviceSystemMajorVersion() >= 7)

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    //NSLog(@"select: %d", [self hasPickerForIndexPath:indexPath]);
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.reuseIdentifier isEqual: @"DateCell"])
    {
        NSLog(@"displayInlineDatePickerForRowAtIndexPath");
        [self displayInlineDatePickerForRowAtIndexPath:indexPath];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UIEditableTextTableViewCell *cell = (UIEditableTextTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"EditableTextCell"];
    //[cell.textField resignFirstResponder];
    NSLog(@"Happend");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
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
