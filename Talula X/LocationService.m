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
        CLLocation *currentLocation = locations.firstObject;
        NSLog(@"New location latitude %f and longitude %f.", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        _lastKnownLocation = currentLocation;
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            __weak typeof(self) weakSelf = self; // :( not great not terrible
            if(placemarks && placemarks.count > 0) {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                weakSelf.lastKnownLocationName = placemark.name;
            }
         }];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didUpdateLocations" object:nil];
    }
}

- (void)requestPermission
{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)dealloc
{
    if (_lastKnownLocation) {
        [_locationManager stopUpdatingLocation];
        [[NSNotificationCenter defaultCenter] removeObserver:@"didUpdateLocations"];
    }
}

@end
