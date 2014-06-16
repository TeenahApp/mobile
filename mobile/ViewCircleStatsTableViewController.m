//
//  ViewCircleStatsTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/19/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "ViewCircleStatsTableViewController.h"

@interface ViewCircleStatsTableViewController ()

@end

@implementation ViewCircleStatsTableViewController

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
    
    self.sections = @[@"Numbers", @"Ages", @"Numbers", @"Male Names", @"Female Names", @"Locations", @"Educations"];//, @"Education Majors", @"Jobs", @"Companies"];
    
    NSMutableArray * numbers1 = [[NSMutableArray alloc]init];
    NSMutableArray * ages = [[NSMutableArray alloc]init];
    NSMutableArray * numbers2 = [[NSMutableArray alloc]init];
    NSMutableArray * maleNames = [[NSMutableArray alloc]init];
    NSMutableArray * femaleNames = [[NSMutableArray alloc]init];
    NSMutableArray * locations = [[NSMutableArray alloc]init];
    NSMutableArray * educations = [[NSMutableArray alloc]init];
    
    self.data = [@[
                   
                   // Section 0: Numbers1:
                   numbers1,
                   
                   // Section 1: Ages:
                   ages,
                   
                   // Section 2: Numbers2:
                   numbers2,
                   
                   // Section 3: Male names.
                   maleNames,
                   
                   // Section 4: Female names.
                   femaleNames,
                   
                   // Section 5: Locations.
                   locations,
                   
                   // Section 6: Educations.
                   educations,
                   
    ] mutableCopy];
    
    // 0. Numbers 1
    [numbers1 addObject:
    @{@"Numbers1.Row1":
           @[
               @{@"label": @"سنة", @"count": [NSString stringWithFormat:@"%ld", (long)132]},
               @{@"label": @"إعجاب", @"count": [NSString stringWithFormat:@"%ld", (long)4534]},
               @{@"label": @"زيارة", @"count": [NSString stringWithFormat:@"%ld", (long)678]},
            ]
    }];
    
    [numbers1 addObject:
     @{@"Numbers1.Row2":
           @[
               @{@"label": @"سنة", @"count": [NSString stringWithFormat:@"%ld", (long)132]},
               @{@"label": @"إعجاب", @"count": [NSString stringWithFormat:@"%ld", (long)4534]},
               @{@"label": @"زيارة", @"count": [NSString stringWithFormat:@"%ld", (long)678]},
            ]
    }];
    
    // 1. Ages.
    [ages addObject:@{@"title": @"any"}];
    
    // 2. Numbers 2
    [numbers2 addObject:
     @{@"Numbers2":
           @[
               @{@"label": @"مناسبة", @"count": [NSString stringWithFormat:@"%ld", (long)132]},
               @{@"label": @"رسالة", @"count": [NSString stringWithFormat:@"%ld", (long)4534]},
               @{@"label": @"صورة", @"count": [NSString stringWithFormat:@"%ld", (long)678]},
            ]
    }];
    
    // 3. Male names.
    [maleNames addObject:@{@"title": @"any"}];
    
    // 4. Female names.
    [femaleNames addObject:@{@"title": @"any"}];
    
    // 5. Locations.
    [locations addObject:@{@"title": @"any"}];
    
    // 6. Educations.
    [educations addObject:@{@"title": @"any"}];

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * rows = [self.data objectAtIndex:indexPath.section];
    NSDictionary * info = [rows objectAtIndex:indexPath.row];
    
    NSString * key = [[info allKeys] objectAtIndex:0];
    
    if (indexPath.section == 0 || indexPath.section == 2)
    {
        NSArray * columns = [info objectForKey:key];

        UIMultiColumnsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"multiColumnsCell" forIndexPath:indexPath];

        [cell setColumns:columns];
        
        return cell;
    }
    else if (indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 6)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"chartCell" forIndexPath:indexPath];
        
        if (cell.contentView.subviews.count == 0) // This line to prevent drawing the chart again.
        {
            // TODO: Remove the chart from the view.
            PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(cell.contentView.frame.origin.x + kChartCellPadding, cell.contentView.frame.origin.y + kChartCellPadding, cell.contentView.frame.size.width - kChartCellPadding, cell.contentView.frame.size.height - kChartCellPadding)];
        
            barChart.backgroundColor = [UIColor clearColor];
        
            barChart.yLabelFormatter = ^(CGFloat yValue)
            {
                CGFloat yValueParsed = yValue;
                NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
                return labelText;
            };
        
            barChart.labelMarginTop = 5.0;

            [barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
            [barChart setYValues:@[@1,@24,@12,@18,@30,@10,@21]];
            [barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNYellow,PNGreen]];
            [barChart strokeChart];

            [cell.contentView addSubview:barChart];
        }

        return cell;
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 2)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"multiColumnsCell"];
        return cell.frame.size.height;
    }
    else if (indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 6)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"chartCell"];
        return cell.frame.size.height;
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    return cell.frame.size.height;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * sectionTitle = [self.sections objectAtIndex:section];
    return sectionTitle;
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
