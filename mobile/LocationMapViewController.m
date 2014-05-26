//
//  LocationMapViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/27/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "LocationMapViewController.h"

@interface LocationMapViewController ()

@end

@implementation LocationMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.annotation = [[MKPointAnnotation alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.field.value)
    {
        self.mapView.centerCoordinate = ((CLLocation *)self.field.value).coordinate;
        
        self.annotation.coordinate = ((CLLocation *)self.field.value).coordinate;
        
        [self.mapView addAnnotation:self.annotation];
    }
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    self.field.value = [[CLLocation alloc] initWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    
    self.annotation.coordinate = ((CLLocation *)self.field.value).coordinate;

    [self.mapView addAnnotation:self.annotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
