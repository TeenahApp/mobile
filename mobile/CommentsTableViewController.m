//
//  CommentsTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "CommentsTableViewController.h"

@interface CommentsTableViewController ()

@end

@implementation CommentsTableViewController

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
    
    self.noRowsLabel.text = @"لم يتم إضافة تعليقات حتّى الآن.";
    
    [self.noRowsView addSubview:self.noRowsLabel];
    self.noRowsView.hidden = YES;
    
    [self.tableView insertSubview:self.noRowsView belowSubview:self.tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [self loadComments];

    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"ddMMyyHHmmss"];
}

-(void)loadComments
{
    // Define the comments array.
    self.comments = [[NSMutableArray alloc] init];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        TSweetResponse * tsr;
        
        if ([self.area isEqual:@"event"])
        {
            tsr = [[EventsCommunicator shared] getEventComments:self.affectedId];
        }
        
        else if ([self.area isEqual:@"media"])
        {
            tsr = [[MediasCommunicator shared] getMediaComments:self.affectedId];
        }
        
        else if ([self.area isEqual:@"member"])
        {
            tsr = [[MembersCommunicator shared] getMemberComments:self.affectedId];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (tsr.code == 200)
            {
                for (NSDictionary * tempComment in tsr.json)
                {
                    TComment * comment = [[TComment alloc] initWithJson:tempComment];
                    [self.comments addObject:comment];
                }
            }
            else
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطأ أثناء قراءة التعليقات، الرجاء المحاولة مرّة أخرى." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
        });
    });
}

-(void)viewDidAppear:(BOOL)animated
{
    self.tabInput = [[UITabInputView alloc] initWithDelegate:self hasAttachButton:NO];
    
    [self.view.superview addSubview:self.tabInput];
    
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, (self.tableView.contentSize.height - self.tableView.frame.size.height) + 20);
        [self.tableView setContentOffset:offset animated:YES];
    }
}

-(void)dismissKeyboard
{
    [self.tabInput.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.comments.count == 0)
    {
        self.noRowsView.hidden = NO;
    }
    else
    {
        self.noRowsView.hidden = YES;
    }
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    TComment * comment = [self.comments objectAtIndex:indexPath.row];

    UILabel * contentLabel = (UILabel *)[cell viewWithTag:44];
    contentLabel.text = comment.content;
    
    UIButton * creatorButton = (UIButton *)[cell viewWithTag:22];
    [creatorButton setTitle:comment.creator.displayName forState:UIControlStateNormal];
    
    UILabel * createdAtLabel = (UILabel *)[cell viewWithTag:33];
    [createdAtLabel setText:[self.dateFormatter stringFromDate:comment.createdAt]];
    
    UILabel * likesLabel = (UILabel *)[cell viewWithTag:55];
    likesLabel.text = [NSString stringWithFormat:@"%ld",(long)comment.likesCount];

    UILikeButton * likeButton = (UILikeButton *)[cell viewWithTag:66];
    
    if (comment.hasLiked == YES)
    {
        [likeButton setEnabled:NO];
    }
    else
    {
        likeButton.affectedId = self.affectedId;
        likeButton.commentId = comment.commentId;
        likeButton.indexPath = indexPath;
        
        [likeButton addTarget:self action:@selector(likeComment:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //likeButton.
    
    UIImageView * imageView = (UIImageView *)[cell viewWithTag:11];
    
    if (comment.creator.photo != nil)
    {
        // TODO: Show wait indicator.
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            NSURL * photoUrl = [NSURL URLWithString:comment.creator.photo];
            
            // Get the member photo.
            NSData * data = [NSData dataWithContentsOfURL:photoUrl];
            UIImage * photo = [[UIImage alloc]initWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [imageView setImage:photo];
            });
        });
    }
    
    return cell;
}

-(void)didTouchDoneButton
{
    NSString * trimmedText = [self.tabInput.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([trimmedText isEqual:@""])
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء كتابة نص لتتمكن من إرساله." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        [self.alert show];
        return;
    }

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        TSweetResponse * tsr;
        
        if ([self.area isEqual:@"event"])
        {
            tsr = [[EventsCommunicator shared] commentOnEvent:self.affectedId comment:self.tabInput.textField.text];
        }
        else if ([self.area isEqual:@"media"])
        {
            tsr = [[MediasCommunicator shared] commentOnMedia:self.affectedId comment:self.tabInput.textField.text];
        }
        else if ([self.area isEqual:@"member"])
        {
            tsr = [[MembersCommunicator shared] commentOnMember:self.affectedId comment:self.tabInput.textField.text];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (tsr.code == 204)
            {
                self.tabInput.textField.text = @"";
                
                // Dismiss the keyboard.
                [self dismissKeyboard];
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [self loadComments];
                [self.tableView reloadData];
                
                if ([self.area isEqual:@"event"])
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshEventComments" object:nil];
                }
                else if ([self.area isEqual:@"media"])
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMediaComments" object:nil];
                }
                else if ([self.area isEqual:@"member"])
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMemberComments" object:nil];
                }
                
                self.alert = [[UIAlertView alloc] initWithTitle:@"تم" message:@"تمّ إضافة التعليق بنجاح." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            else
            {
                self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"حدث خطأ أثناء إرسال الرسالة، الرجاء المحاولة لاحقاً." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }

            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

-(void)didTouchAttachButton
{
    // Not allowed.
}

-(void)likeComment:(id)sender
{
    // Notice: There is probably no need for drawing the comment again.
    
    UILikeButton * temp = (UILikeButton *) sender;

    TComment * comment = [self.comments objectAtIndex:temp.indexPath.row];
    
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:temp.indexPath];
    
    UILabel * contentLabel = (UILabel *)[cell viewWithTag:44];
    contentLabel.text = comment.content;
    
    UIButton * creatorButton = (UIButton *)[cell viewWithTag:22];
    [creatorButton setTitle:comment.creator.displayName forState:UIControlStateNormal];
    
    UILabel * createdAtLabel = (UILabel *)[cell viewWithTag:33];
    [createdAtLabel setText:[self.dateFormatter stringFromDate:comment.createdAt]];
    
    UILabel * likesLabel = (UILabel *)[cell viewWithTag:55];
    likesLabel.text = [NSString stringWithFormat:@"%ld",(long)comment.likesCount];
    
    UIImageView * imageView = (UIImageView *)[cell viewWithTag:11];
    
    UILikeButton * likeButton = (UILikeButton *)[cell viewWithTag:66];
    
    if (comment.creator.photo != nil)
    {
        // TODO: Show wait indicator.
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            NSURL * photoUrl = [NSURL URLWithString:comment.creator.photo];
            
            // Get the member photo.
            NSData * data = [NSData dataWithContentsOfURL:photoUrl];
            UIImage * photo = [[UIImage alloc]initWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [imageView setImage:photo];
            });
        });
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Get the member information.
        TSweetResponse * tsr;
        
        if ([self.area isEqual:@"event"])
        {
            tsr = [[EventsCommunicator shared] likeCommentOnEvent:temp.affectedId commentId:temp.commentId];
        }
        else if ([self.area isEqual:@"media"])
        {
            tsr = [[MediasCommunicator shared] likeCommentOnMedia:temp.affectedId commentId:temp.commentId];
        }
        else if ([self.area isEqual:@"member"])
        {
            tsr = [[MembersCommunicator shared] likeCommentOnMember:temp.affectedId commentId:temp.commentId];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check if the response code is not successful.
            if (tsr.code == 204)
            {
                comment.likesCount++;

                [likesLabel setText:[NSString stringWithFormat:@"%ld", (long)comment.likesCount]];
                [likeButton setEnabled:NO];
                
                // Show an alert saying thanks.
                self.alert = [[UIAlertView alloc] initWithTitle:@"تم" message:@"شكراً لك، تم تسجيل إعجابك بالتعليق." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            else
            {
                self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"لا يمكنك الإعجاب بهذا التعليق." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TComment * comment = [self.comments objectAtIndex:indexPath.row];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 100)];
    
    label.numberOfLines = 0;
    
    //label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = comment.content;
    label.backgroundColor = [UIColor redColor];
    
    [label sizeToFit];
    
    // Return.
    return label.frame.size.height + 40 + 20;
}

@end
