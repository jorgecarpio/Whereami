//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Jorge Carpio on 6/27/13.
//  Copyright (c) 2013 Jorge Carpio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "BNRMapPoint.h"

@interface WhereamiViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextViewDelegate>
{
    CLLocationManager *locationManager;
    
    // Instance variables needed for MapView
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
    
    // For segmented control...
    IBOutlet UISegmentedControl *segmentedControl;
    
}

-(void)findLocation;
-(void)foundLocation: (CLLocation *)loc;

// For segmented control...
-(IBAction)changeSegment:(id)sender;

@end
