//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Jorge Carpio on 6/27/13.
//  Copyright (c) 2013 Jorge Carpio. All rights reserved.
//

#import "WhereamiViewController.h"

@interface WhereamiViewController ()

@end

@implementation WhereamiViewController

// For segmented control...
-(IBAction)changeSegment:(id)sender
{

switch ([segmentedControl selectedSegmentIndex]) {
    case 0:
        [worldView setMapType:MKMapTypeStandard];
        break;
    case 1:
        [worldView setMapType:MKMapTypeSatellite];
        break;
    case 2:
        [worldView setMapType:MKMapTypeHybrid];
        break;
        
    default:
        break;
}
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // Construct region for zooming
    // Get coordinate from MKUserLocation which conforms to the MKAnnotation protocol
    // which dictates that it must reply with a coordinate to the property coordinate
    
    CLLocationCoordinate2D loc = [userLocation coordinate];
    
    // MKCoordinateRegion makes a region with a coordinate (see above) and meters n/s and e/w
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    
    // worldView gets a message telling it to set a region (MKCoordinateRegion) and animate!
    
    [worldView setRegion:region animated:YES];
    
}

// Method that shows a users location on the map after mapview interface loads
-(void)viewDidLoad
{
    [worldView setShowsUserLocation:YES];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Create the location manager object
        locationManager = [[CLLocationManager alloc] init];
        
        
        // Set delegate for locationManager
        [locationManager setDelegate:self];
        
        // Set it to max accuracy; batt life be damned.
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        // Bronze challenge; only report after moving 50 meters
        [locationManager setDistanceFilter:50.0];
        
        // No longer needed because viewDidLoad handles it
        // Tell our manager to start looking for its location immediately
        // [locationManager startUpdatingLocation];
        
        // Let's get the heading
        
        // First check if it's available
        
        if ([CLLocationManager headingAvailable]) {
            // Tell the instance to start collecting heading data
            [locationManager startUpdatingHeading];
            
            
            
        }
        
    }
    return self;
}

// Implement the instance method for this delegate that CLLocationManager calls
// when it sends heading information
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"heading: %@", newHeading);
}

// Because CLLocationManager sends the locationManager:didUpdateToLocation:fromLocation to its delegate(self)
// this method must be implemented.
-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
    
    // How many seconds ago was this new location created.
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    // CLLocationManagers will return the last found location of the device first
    // you don't want that data in this case.
    // So, you check if the last found location is more than 3 min old.
    if (t < -180) {
        return;
    }
    [self foundLocation:newLocation];
}

// If CLLocationManager fails, it sends another message to its delegate so we need to catch it.
-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location.  Failed with error %@", error);
}

// Override dealloc to release reference to delegate; only called when WhereamiViewController is destroyed.
// This is not done automatically.
-(void)dealloc
{
    [locationManager setDelegate:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // This method isn't implemented yet.
    [self findLocation];
    
    [textField resignFirstResponder];
    return YES;
}


-(void)findLocation
{
    // Tell locationManater to start Updating Location, haha.
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}
-(void)foundLocation: (CLLocation *)loc
{
    // Create an instance of BNRMapoint using loc
    CLLocationCoordinate2D coord = [loc coordinate];
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];
    
    // Add to map view
    [worldView addAnnotation:mp];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
    
    // Reset the UI
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
    
}

@end
