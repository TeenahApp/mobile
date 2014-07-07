//
//  ViewMediasViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/1/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "ViewMediasViewController.h"

@interface ViewMediasViewController ()

@end

@implementation ViewMediasViewController

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
    
    self.noRowsLabel.text = @"لم يتم إضافة صور، يُمكنك إضافة صورة من خلال أيقونة (+) في أعلى اليمين.";
    
    [self.noRowsView addSubview:self.noRowsLabel];
    self.noRowsView.hidden = YES;
    
    [self.collectionView insertSubview:self.noRowsView belowSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.medias.count == 0)
    {
        self.noRowsView.hidden = NO;
    }
    else
    {
        self.noRowsView.hidden = YES;
    }
    
    return self.medias.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mediaCell" forIndexPath:indexPath];
    
    TEventMedia * eventMedia = (TEventMedia *)[self.medias objectAtIndex:indexPath.row];

    // TODO: Show wait indicator.
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
        NSURL * photoUrl = [NSURL URLWithString:eventMedia.media.taste];
            
        // Get the member photo.
        NSData * data = [NSData dataWithContentsOfURL:photoUrl];
        UIImage * photo = [[UIImage alloc]initWithData:data];
            
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView * imageView = (UIImageView *)[cell viewWithTag:11];
            [imageView setImage:photo];
        });
    });
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMediaId = indexPath.row;
    
    TEventMedia * tempSelectedEventMedia = [self.medias objectAtIndex:indexPath.row];
    
    // Set the media to be selected.
    self.selectedMedia = tempSelectedEventMedia.media;
    
    [self performSegueWithIdentifier:@"ViewMedia" sender:collectionView];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.chosenImage = info[UIImagePickerControllerOriginalImage];
    
    UIImage * compressedImage = [self compressImage:self.chosenImage scale:0.8];
    
    // Upload the media.
    NSData * data = [NSData dataWithData:UIImagePNGRepresentation(compressedImage)];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Get the member information.
        TSweetResponse * createMediaResponse = [[EventsCommunicator shared] createMedia:self.eventId category:@"image" data:data extension:@"png"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check if the response code is not successful.
            if (createMediaResponse.code == 200)
            {
                //self.member = [[TMember alloc] initWithJson:memberResponse.json];
                TMedia * newMedia = [[TMedia alloc] initWithJson:createMediaResponse.json];
                TEventMedia * newEventMedia = [[TEventMedia alloc] init];
                
                newEventMedia.media = newMedia;
                
                [self.medias addObject:newEventMedia];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshEventMedias" object:nil];

                self.alert = [[UIAlertView alloc] initWithTitle:@"تم" message:@"تمّ إضافة الصورة بنجاح." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            else
            {
                self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"حدث خطأ أثناء إضافة الصورة، الرجاء المحاولة لاحقاً." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.collectionView reloadData];
    
        });
    });
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)addMediaDidClicked:(id)sender {

    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
   
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}

-(UIImage *)compressImage: (UIImage *) original scale: (CGFloat)scale
{
    // Calculate new size given scale factor.
    CGSize originalSize = original.size;
    CGSize newSize = CGSizeMake(originalSize.width * scale, originalSize.height * scale);
    
    // Scale the original image to match the new size.
    UIGraphicsBeginImageContext(newSize);
    [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage* compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compressedImage;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"ViewMedia"])
    {
        ViewMediaTableViewController *vc = (ViewMediaTableViewController *) [segue destinationViewController];
        
        // Set the event id to be opened.
        vc.media = self.selectedMedia;
        
        //[vc initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
    }
}

@end
