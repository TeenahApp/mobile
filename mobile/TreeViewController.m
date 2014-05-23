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
    // TODO: Get the real member (the logged in member).
    //NSLog(@"helloworld");

    [self.treeView getMember:1];
}

-(void)didAddFather
{
    NSLog(@"Add Father");
    self.relation = @"father";
    [self showAddRelations];
}

-(void)didAddMother
{
    self.relation = @"mother";
    [self showAddRelations];
}

-(void)didAddBrother
{
    self.relation = @"brother";
    [self showAddRelations];
}

-(void)didAddSister
{
    self.relation = @"sister";
    [self showAddRelations];
}

-(void)didAddDaughter
{
    self.relation = @"daughter";
    [self showAddRelations];
}

-(void)didAddSon
{
    self.relation = @"son";
    [self showAddRelations];
}

-(void)didAddWife
{
    self.relation = @"wife";
    [self showAddRelations];
}

-(void)didAddHusband
{
    self.relation = @"husband";
    [self showAddRelations];
}

-(void)showAddRelations
{
    [self.treeView.relationsView removeFromSuperview];
    [self performSegueWithIdentifier:@"AddRelation" sender:self];
}

-(void)didUpdateMember:(TMember *)member
{
    self.member = member;
    //NSLog(@"---------------------------- called: %d", self.member.memberId);
}

-(void)didViewMember
{
    [self performSegueWithIdentifier:@"ViewMember" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Make sure your segue name in storyboard is the same as this line

    NSLog(@"member is being segued: %@", self.member);
    
    if ([[segue identifier] isEqualToString:@"AddRelation"])
    {
        // Get reference to the destination view controller
        AddRelationViewController *vc = (AddRelationViewController *) [segue destinationViewController];
        
        vc.relation = self.relation;
        vc.memberA = self.member.memberId;
        
        [vc initWithNibName:nil bundle:nil];
        
        vc.hidesBottomBarWhenPushed = YES;
    }
    
    else if ([[segue identifier] isEqualToString:@"ViewMember"])
    {
        ViewMemberTableViewController * vc = (ViewMemberTableViewController *) [segue destinationViewController];
        vc.member = self.member;
        
        vc.hidesBottomBarWhenPushed = YES;
    }

}

@end
