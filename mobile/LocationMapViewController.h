//
//  LocationMapViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/27/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "FXForms.h"

@interface LocationMapViewController : UIViewController <FXFormFieldViewController, MKMapViewDelegate>

@property (nonatomic, strong) FXFormField * field;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) MKPointAnnotation * annotation;

@end
