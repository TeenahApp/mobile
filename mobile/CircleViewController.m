//
//  CircleViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/8/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "CircleViewController.h"

@interface CircleViewController ()

@end

@implementation CircleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locations = [[NSMutableArray alloc] init];
    self.pages = @[@"Members", @"Ages", @"Male Names", @"Female Names", @"Educations", @"Education Majors", @"Companies", @"Locations"];
    
    // Do any additional setup after loading the view.
    [self.innerView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    TSweetResponse * tsr = [[CirclesCommunicator shared] getStats: self.circle[@"id"]];
   
    [self.mainLabel setText:self.pages[0]];
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame: CGRectMake(0, 0, self.innerView.frame.size.width, self.innerView.frame.size.height)];
    
    barChart.backgroundColor = [UIColor clearColor];
    
    [barChart setXLabels:@[@"Mbrs",@"A.Mbrs",@"Mls",@"A.Mls",@"Fmls",@"A.Fmls"]];
    
    [barChart setYValues:@[tsr.json[@"members_count"], tsr.json[@"alive_members_count"], tsr.json[@"males_count"], tsr.json[@"alive_males_count"], tsr.json[@"females_count"], tsr.json[@"alive_females_count"]]];

    barChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    
    [barChart setStrokeColors:@[PNYellow,PNGreen,PNYellow,PNGreen,PNYellow,PNGreen]];
    [barChart strokeChart];
    
    //barChart.delegate = self;

    [self.innerView addSubview:barChart];
    
    // Ages.
    
    PNBarChart * bar2Chart = [[PNBarChart alloc] initWithFrame: CGRectMake(self.innerView.frame.size.width, 0, self.innerView.frame.size.width, self.innerView.frame.size.height)];
    
    bar2Chart.backgroundColor = [UIColor clearColor];
    
    NSMutableArray * ageLabels = [[NSMutableArray alloc] init];
    NSMutableArray * ageValues = [[NSMutableArray alloc] init];
    NSMutableArray * ageColors = [[NSMutableArray alloc] init];
    
    for (NSDictionary * temp in tsr.json[@"ages"])
    {
        [ageLabels addObject:temp[@"ranges"]];
        [ageValues addObject:temp[@"counts"]];
        [ageColors addObject:PNBlue];
    }
    
    [bar2Chart setXLabels:ageLabels];
    [bar2Chart setYValues:ageValues];
    
    bar2Chart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    
    [bar2Chart setStrokeColors:ageColors];
    [bar2Chart strokeChart];
    
    // Male Names.
    PNBarChart * maleNamesChart = [[PNBarChart alloc] initWithFrame: CGRectMake(self.innerView.frame.size.width * 2, 0, self.innerView.frame.size.width, self.innerView.frame.size.height)];
    
    maleNamesChart.backgroundColor = [UIColor clearColor];
    
    NSMutableArray * maleNameLabels = [[NSMutableArray alloc] init];
    NSMutableArray * maleNameValues = [[NSMutableArray alloc] init];
    NSMutableArray * maleNameColors = [[NSMutableArray alloc] init];
    
    for (NSDictionary * temp in tsr.json[@"male_names"])
    {
        [maleNameLabels addObject:temp[@"name"]];
        [maleNameValues addObject:temp[@"members_count"]];
        [maleNameColors addObject:PNRed];
    }
    
    [maleNamesChart setXLabels:maleNameLabels];
    [maleNamesChart setYValues:maleNameValues];
    
    maleNamesChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    
    [maleNamesChart setStrokeColors:maleNameColors];
    [maleNamesChart strokeChart];
    
    // Female Names.
    PNBarChart * femaleNamesChart = [[PNBarChart alloc] initWithFrame: CGRectMake(self.innerView.frame.size.width * 3, 0, self.innerView.frame.size.width, self.innerView.frame.size.height)];
    
    femaleNamesChart.backgroundColor = [UIColor clearColor];
    
    NSMutableArray * femaleNameLabels = [[NSMutableArray alloc] init];
    NSMutableArray * femaleNameValues = [[NSMutableArray alloc] init];
    NSMutableArray * femaleNameColors = [[NSMutableArray alloc] init];
    
    for (NSDictionary * temp in tsr.json[@"female_names"])
    {
        [femaleNameLabels addObject:temp[@"name"]];
        [femaleNameValues addObject:temp[@"members_count"]];
        [femaleNameColors addObject:PNRed];
    }
    
    [femaleNamesChart setXLabels:femaleNameLabels];
    [femaleNamesChart setYValues:femaleNameValues];
    
    femaleNamesChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    
    [femaleNamesChart setStrokeColors:femaleNameColors];
    [femaleNamesChart strokeChart];
    
    // Educations
    PNBarChart * educationsChart = [[PNBarChart alloc] initWithFrame: CGRectMake(self.innerView.frame.size.width * 4, 0, self.innerView.frame.size.width, self.innerView.frame.size.height)];
    
    educationsChart.backgroundColor = [UIColor clearColor];
    
    NSMutableArray * educationLabels = [[NSMutableArray alloc] init];
    NSMutableArray * educationValues = [[NSMutableArray alloc] init];
    NSMutableArray * educationColors = [[NSMutableArray alloc] init];
    
    for (NSDictionary * temp in tsr.json[@"educations"])
    {
        [educationLabels addObject:temp[@"name"]];
        [educationValues addObject:temp[@"members_count"]];
        [educationColors addObject:PNRed];
    }
    
    [educationsChart setXLabels:educationLabels];
    [educationsChart setYValues:educationValues];
    
    educationsChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    
    [educationsChart setStrokeColors:educationColors];
    [educationsChart strokeChart];
    
    // Locations.
    for (NSDictionary * temp in tsr.json[@"locations"])
    {
        [self.locations addObject:temp];
    }
    
    UITableView * locationsTable = [[UITableView alloc] initWithFrame: CGRectMake(self.innerView.frame.size.width * 5, 0, self.innerView.frame.size.width, self.innerView.frame.size.height)];
    
    locationsTable.dataSource = self;
    locationsTable.delegate = self;
    
    self.pager.numberOfPages = self.pages.count;
    self.innerView.contentSize = CGSizeMake(self.pager.numberOfPages * self.innerView.frame.size.width, self.innerView.frame.size.height);
    
    self.innerView.delegate = self;
    
    [self.innerView addSubview:barChart];
    [self.innerView addSubview:bar2Chart];
    [self.innerView addSubview:maleNamesChart];
    [self.innerView addSubview:femaleNamesChart];
    [self.innerView addSubview:educationsChart];
    [self.innerView addSubview:locationsTable];
    
    [self.membersLabel setTitle:[NSString stringWithFormat:@"Members (%@)", tsr.json[@"members_count"]] forState:UIControlStateNormal];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView: %d", 1);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection: %d", self.locations.count);
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LocationCell"];
    
    // Set up the cell...
    NSDictionary * temp = [self.locations objectAtIndex:indexPath.row];
    
    NSLog(@"--------------\n\n%@", temp.description);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [temp objectForKey:@"location"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [temp objectForKey:@"members_count"]];
    
    return cell;
}

- (IBAction)moreClicked:(id)sender {
    self.menuView.hidden = !self.menuView.hidden;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.innerView.frame.size.width;
    
    int page = floor((self.innerView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.mainLabel setText:self.pages[page]];
    self.pager.currentPage = page;
}

- (IBAction)leaveCircle:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Leaving" message:@"Are you sure to leave this circle?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
    
    [alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //NSLog(@"%@", segue.description);
}
 */

@end
