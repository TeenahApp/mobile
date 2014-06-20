//
//  AddCircleTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/23/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddCircleTableViewController.h"

@interface AddCircleTableViewController ()

@end

@implementation AddCircleTableViewController

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
    
    self.members = [[NSMutableArray alloc] init];
    self.secondSectionData = [[NSMutableArray alloc] init];
    
    self.sections = @[@"اسم الدائرة", @"الأفراد", @""];
    
    self.data = [@[
                   @[@"circlename"],
                   
                   self.secondSectionData,
                   
                   @[@"done"],
    ] mutableCopy];
    
    // Add the (add) button to the second section.
    [self.secondSectionData addObject:@{@"add": @"member"}];
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
    if (indexPath.section == 2)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 0)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addCell" forIndexPath:indexPath];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sections objectAtIndex:section];
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
