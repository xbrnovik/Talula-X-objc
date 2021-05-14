//
//  LocationService.m
//  Talula X
//
//  Created by Diana Brnovik on 14/05/2021.
//

#import "LocationService.h"

@implementation LocationService

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count > 0 ) {
        CLLocation *currentLocation = locations[0];
        NSLog(@"New location latitude %f and longitude %f.", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        _lastKnownLocation = currentLocation;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didUpdateLocations" object:nil];    }
}

- (void)requestPermission
{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

@end
