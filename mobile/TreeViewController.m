//
//  TreeViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TreeViewController.h"

@interface TreeViewController ()

@end

@implementation TreeViewController

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
    // Do any additional setup after loading the view.
    //[self view draw];
    //[self.view
     
    //UITreeView * treeView = (UITreeView *)self.view;
    //[treeView getMember:@"2"];
    //self.treeView.delegate = self;
    
    self.treeView = (UITreeView *)self.view;
    self.treeView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    //NSLog(@"helloworld");
    self.treeView.member.photo = @"zee";
    [self.treeView getMember:@"2"];
}

-(void)didAddFather
{
    NSLog(@"Add Father");
    
    self.relation = @"father";
    
    [self showAddRelations];
}

-(void)showAddRelations
{
    [self.treeView.relationsView removeFromSuperview];
    [self performSegueWithIdentifier:@"AddRelation" sender:self];
}

-(void)didUpdateMember:(NSString *)memberId
{
    self.memberId = memberId;
    NSLog(@"---------------------------- called: %@", memberId);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"AddRelation"])
    {
        // Get reference to the destination view controller
        //YourViewController *vc = [segue destinationViewController];
        AddRelationViewController *vc = (AddRelationViewController *) [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:object];
        vc.relation = self.relation;
        vc.memberA = self.memberId;
        
        NSLog(@"%d", vc.isRootSegmented.selectedSegmentIndex);
    }
}

@end
