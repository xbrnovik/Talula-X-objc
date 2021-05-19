//
//  LocationService.h
//  Talula X
//
//  Created by Diana Brnovik on 14/05/2021.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationService : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocation * lastKnownLocation;
@property (strong, nonatomic) NSString * lastKnownLocationName;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (void)requestPermission;

@end

NS_ASSUME_NONNULL_END
