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
    
    self.degrees = @{
                     @"elementary": @"إبتدائي", @"intermediate": @"متوسّط", @"secondary": @"ثانوي",
                     @"diploma": @"دبلوم", @"licentiate": @"إجازة", @"bachelor": @"بكالوريوس",
                     @"master": @"ماجستير", @"doctorate": @"دكتوراه",
    };
    
    // Get the stats from the API.
    TSweetResponse * getCircleStatsResponse = [[CirclesCommunicator shared] getStats:self.circleId];
    NSDictionary * stats = getCircleStatsResponse.json;
    
    self.sections = @[@"التعداد", @"الفئات العمرية", @"", @"أسماء الذكور", @"أسماء الإناث", @"أماكن الإقامة", @"التعليم", @"التخصّصات", @"الوظائف", @"جهات العمل"];
    
    NSMutableArray * numbers1 = [[NSMutableArray alloc]init];
    NSMutableArray * ages = [[NSMutableArray alloc]init];
    NSMutableArray * numbers2 = [[NSMutableArray alloc]init];
    NSMutableArray * maleNames = [[NSMutableArray alloc]init];
    NSMutableArray * femaleNames = [[NSMutableArray alloc]init];
    NSMutableArray * locations = [[NSMutableArray alloc]init];
    NSMutableArray * educations = [[NSMutableArray alloc]init];
    NSMutableArray * educationMajors = [[NSMutableArray alloc]init];
    NSMutableArray * jobs = [[NSMutableArray alloc]init];
    NSMutableArray * companies = [[NSMutableArray alloc]init];
    
    self.data = [@[
                   
                   // Section 0: Numbers1:
                   numbers1,
                   
                   // Section 1: Ages:
                   @[@{@"ages": ages}],
                   
                   // Section 2: Numbers2:
                   numbers2,
                   
                   // Section 3: Male names.
                   @[@{@"males": maleNames}],
                   
                   // Section 4: Female names.
                   @[@{@"females": femaleNames}],
                   
                   // Section 5: Locations.
                   locations,
                   
                   // Section 6: Educations.
                   @[@{@"educations": educations}],
                   
                   // Section 7: Education majors.
                   educationMajors,

                   // Section 8: Jobs.
                   jobs,
                   
                   // Section 9: Companies.
                   companies,
                   
    ] mutableCopy];
    
    // 0. Numbers 1
    [numbers1 addObject:
    @{@"Numbers1.Row1":
           @[
               @{@"label": @"الأفراد", @"count": [stats objectForKey:@"members_count"]},
               @{@"label": @"الذكور", @"count": [stats objectForKey:@"males_count"]},
               @{@"label": @"الإناث", @"count": [stats objectForKey:@"females_count"]},
            ]
    }];
    
    [numbers1 addObject:
     @{@"Numbers1.Row2":
           @[
               @{@"label": @"الأحياء الأفراد", @"count": [stats objectForKey:@"alive_members_count"]},
               @{@"label": @"الأحياء الذكور", @"count": [stats objectForKey:@"alive_males_count"]},
               @{@"label": @"الأحياء الإناث", @"count": [stats objectForKey:@"alive_females_count"]},
            ]
    }];
    
    // 1. Ages.
    for (NSDictionary * tempAge in [stats objectForKey:@"ages"])
    {
        [ages addObject:@{@"label": [tempAge objectForKey:@"ranges"], @"value": [tempAge objectForKey:@"counts"], @"color": PNGreen}];
    }
    
    // 2. Numbers 2
    [numbers2 addObject:
     @{@"Numbers2":
           @[
               @{@"label": @"مناسبة", @"count": [stats objectForKey:@"events_count"]},
               @{@"label": @"رسالة", @"count": [stats objectForKey:@"messages_count"]},
               @{@"label": @"صورة", @"count": [stats objectForKey:@"medias_count"]},
            ]
    }];
    
    // 3. Male names.
    for (NSDictionary * tempMName in [stats objectForKey:@"male_names"])
    {
        [maleNames addObject:@{@"label": [tempMName objectForKey:@"name"], @"value": [tempMName objectForKey:@"members_count"], @"color": PNBlue}];
    }
    
    // 4. Female names.
    for (NSDictionary * tempFName in [stats objectForKey:@"female_names"])
    {
        [femaleNames addObject:@{@"label": [tempFName objectForKey:@"name"], @"value": [tempFName objectForKey:@"members_count"], @"color": PNRed}];
    }
    
    // 5. Locations.
    for (NSDictionary * tempLocation in [stats objectForKey:@"locations"])
    {
        NSString * location = [[tempLocation objectForKey:@"location"] isKindOfClass:[NSNull class]] ? @"غير محدّد" : [tempLocation objectForKey:@"location"];
        [locations addObject:@{location: [NSString stringWithFormat:@"%@", [tempLocation objectForKey:@"members_count"]]}];
    }

    // 6. Educations.
    for (NSDictionary * tempEducation in [stats objectForKey:@"educations"])
    {
        [educations addObject:@{@"label": self.degrees[[tempEducation objectForKey:@"degree"]], @"value": [tempEducation objectForKey:@"members_count"], @"color": PNLightBlue}];
    }

    // 7. Education majors.
    for (NSDictionary * tempEMajor in [stats objectForKey:@"education_majors"])
    {
        NSDictionary * major = [tempEMajor objectForKey:@"major"];
        
        NSString * majorName = [major isKindOfClass:[NSNull class]] ? @"غير محدّد" : [NSString stringWithFormat:@"%@", [major objectForKey:@"name"]];
        NSString * membersCount = [NSString stringWithFormat:@"%@", [tempEMajor objectForKey:@"members_count"]];
        
        [educationMajors addObject:@{majorName: membersCount}];
    }

    // 8. Jobs.
    for (NSDictionary * tempJob in [stats objectForKey:@"jobs"])
    {
        [jobs addObject:@{[NSString stringWithFormat:@"%@", [tempJob objectForKey:@"title"]]: [NSString stringWithFormat:@"%@", [tempJob objectForKey:@"members_count"]]}];
    }

    // 9. Companies.
    for (NSDictionary * tempCompany in [stats objectForKey:@"companies"])
    {
        NSDictionary * company = [tempCompany objectForKey:@"company"];
        
        NSString * companyName = [company isKindOfClass:[NSNull class]] ? @"غير محدّد" : [NSString stringWithFormat:@"%@", [company objectForKey:@"name"]];
        NSString * membersCount = [NSString stringWithFormat:@"%@", [tempCompany objectForKey:@"members_count"]];
        
        [companies addObject:@{companyName: membersCount}];
    }
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

    if (indexPath.section == 0 || indexPath.section == 2)
    {
        NSString * key = [[info allKeys] objectAtIndex:0];
        NSArray * columns = [info objectForKey:key];

        UIMultiColumnsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"multiColumnsCell" forIndexPath:indexPath];

        [cell setColumns:columns];
        
        return cell;
    }
    else if (indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 6)
    {
        NSString * key = [[info allKeys] objectAtIndex:0];
        NSArray * items = [info objectForKey:key];
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"chartCell" forIndexPath:indexPath];
        
        [cell.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        
        PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(cell.contentView.frame.origin.x + kChartCellPadding, cell.contentView.frame.origin.y + kChartCellPadding, cell.contentView.frame.size.width - kChartCellPadding, cell.contentView.frame.size.height - kChartCellPadding)];
        
        barChart.backgroundColor = [UIColor clearColor];
        
        barChart.yLabelFormatter = ^(CGFloat yValue)
        {
            CGFloat yValueParsed = yValue;
            NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
            return labelText;
        };
        
        barChart.labelMarginTop = 5.0;

        NSMutableArray * xLables = [[NSMutableArray alloc]init];
        NSMutableArray * yLables = [[NSMutableArray alloc]init];
        NSMutableArray * colors = [[NSMutableArray alloc]init];

        for (NSDictionary * item in items)
        {
            [xLables addObject:[item objectForKey:@"label"]];
            [yLables addObject:[item objectForKey:@"value"]];
            [colors addObject:[item objectForKey:@"color"]];
        }

        [barChart setXLabels:xLables];
        [barChart setYValues:yLables];
        [barChart setStrokeColors:colors];
        
        [barChart strokeChart];
        
        [cell.contentView addSubview:barChart];

        return cell;
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    NSString * key = [[info allKeys] objectAtIndex:0];
    NSString * value = [info objectForKey:key];

    cell.textLabel.text = key;
    cell.detailTextLabel.text = value;
    
    info;

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
