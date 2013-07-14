//
//  BNRMapPoint.m
//  Whereami
//
//  Created by Jorge Carpio on 6/28/13.
//  Copyright (c) 2013 Jorge Carpio. All rights reserved.
//

#import "BNRMapPoint.h"

@implementation BNRMapPoint

@synthesize coordinate, title, subtitle;

-(id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(37.46, 122.26)
                              title:@"Home"];
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];

    if (self) {
        coordinate = c;
        [self setTitle:t];
        // Set subtitle to today's date
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        // NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        NSDate *today = [NSDate date];
        NSLog(@"today is %@", today);
        // Setting the style is important
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        NSLog(@"date is %@", [dateFormatter stringFromDate:today]);
        
        [self setSubtitle:[dateFormatter stringFromDate:today]];


        
    }
    
    return self;
}

@end
