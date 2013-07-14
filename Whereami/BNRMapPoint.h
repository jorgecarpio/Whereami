//
//  BNRMapPoint.h
//  Whereami
//
//  Created by Jorge Carpio on 6/28/13.
//  Copyright (c) 2013 Jorge Carpio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BNRMapPoint : NSObject <MKAnnotation>
{
    
}

// A new initializer for instances of BNRMapPoint
-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;

// This is a required property for MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

// This is an optional property for MKAnnotation
@property (nonatomic, copy) NSString* title;

// This is another optional property for MKAnnotation
// we will use it to store the date
// removing the readonly attribute
@property (nonatomic, copy) NSString* subtitle;

@end
