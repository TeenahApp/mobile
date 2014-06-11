//
//  ViewEventMediasViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/1/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "ViewEventMediasViewController.h"

@interface ViewEventMediasViewController ()

@end

@implementation ViewEventMediasViewController

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
    
    NSLog(@"mediasCount = %d", self.medias.count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.medias.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIMediaCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MediaCell" forIndexPath:indexPath];
    
    TEventMedia * eventMedia = (TEventMedia *)[self.medias objectAtIndex:indexPath.row];
    
    [cell loadImage:[NSURL URLWithString:eventMedia.media.url]];
    
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
    
    //[self.imageView setImage:compressedImage];
    
    //NSString * base64image = [self encodeToBase64String:compressedImage];
    
    //NSLog(@"%@", base64image);
    
    //int size = [base64image length];
    
    // TODO: Check if the chosen file is an image.
    // TODO: Check the size if appropriate.
    //NSLog(@"%d", size);
    
    // Set the image data to be uploaded.
    //self.data = base64image;
    //NSLog(@"%@\n\n---------------------------", self.data);
    
    // Upload the media.
    NSData * data = [NSData dataWithData:UIImagePNGRepresentation(compressedImage)];
    TSweetResponse * tsr = [[EventsCommunicator shared] createMedia:self.eventId category:@"image" data:data extension:@"png"];
    
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
