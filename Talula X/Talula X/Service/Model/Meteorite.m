//
//  Meteorite.m
//  Talula X
//
//  Created by Diana Brnovik on 12/05/2021.
//

#import "Meteorite.h"

@interface Meteorite ()

@end

@implementation Meteorite

- (NSString *)place
{
    return _place ? _place : @"-";
}

#pragma mark - Setup

- (void)setupFromCDMeteorite:(CDMeteorite *)meteorite
{
    _name = meteorite.name;
    _mass = [NSNumber numberWithDouble:meteorite.mass];
    _place = meteorite.place;
    _latitude = [[NSNumber alloc] initWithDouble:meteorite.latitude];
    _longitude = [[NSNumber alloc] initWithDouble:meteorite.longitude];
}

#pragma mark - Calculate

- (NSNumber *)distanceFromLocation:(CLLocation *)location
{
    CLLocation *meteoriteLocation = [[CLLocation alloc] initWithLatitude:[_latitude doubleValue] longitude:[_longitude doubleValue]];
    double distanceDouble = [meteoriteLocation distanceFromLocation:location];
    NSNumber *distance = [[NSNumber alloc] initWithDouble:distanceDouble];
    _lastDistance = distance;
    return distance;
}

@end
