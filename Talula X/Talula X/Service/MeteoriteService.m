//
//  MeteoriteService.m
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import "MeteoriteService.h"

@implementation MeteoriteService

- (NSURL *)createURL
{
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [components setHost:@"data.nasa.gov"];
    [components setPath:@"/resource/y77d-th95.json"];
    [components setQuery:@"shva=1"];
    NSURLQueryItem *appToken = [NSURLQueryItem queryItemWithName:@"$$app_token" value:@"vkpZsq6vJE0i7wvOkP2ybNIbm"];
    NSURLQueryItem *fromDate= [NSURLQueryItem queryItemWithName:@"$where" value:@"year>=\"2011-01-01T00:00:00\""];
    NSURLQueryItem *fall = [NSURLQueryItem queryItemWithName:@"fall" value:@"Fell"];
    NSURLQueryItem *params = [NSURLQueryItem queryItemWithName:@"$select" value:@"id,reclat,reclong,recclass,mass,year,name"];
    [components setQueryItems:@[appToken, fromDate, fall, params]];
    return components.URL;
}

- (void)placemarkFromLocation:(CLLocation *)location
                   success:(void(^)(CLPlacemark *))success
                   failure:(void(^)(NSError * error))failure
                    always:(void(^)(void))always
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
         if(placemarks && placemarks.count > 0) {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             success(placemark);
         } else {
             failure(error);
         }
        always();
     }];
}

- (void)meteorites:(void(^)(MeteoriteResponse *meteoriteResponse))success
           failure:(void(^)(NSError * error))failure
            always:(void(^)(void))always
{
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
      dataTaskWithURL:[self createURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            MeteoriteResponse *meteoriteResponse = [[MeteoriteResponse alloc] initFromData:data];
            
            dispatch_group_t group = dispatch_group_create();
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            
            for (Meteorite *meteorite in meteoriteResponse.meteorites) {
                CLLocationDegrees latitude = [meteorite.latitude doubleValue];
                CLLocationDegrees longitude = [meteorite.longitude doubleValue];
                CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
                
                dispatch_group_enter(group);
                [self placemarkFromLocation:location success:^(CLPlacemark * _Nonnull placemark) {
                    NSString *name = placemark.name;
                    NSString *country = placemark.country;
                    NSString *administrativeArea = (placemark.name != placemark.administrativeArea)
                                                    ? placemark.administrativeArea
                                                    : nil;
                    meteorite.place = [[NSArray arrayWithObjects:name, country, administrativeArea, nil] componentsJoinedByString:@","];
                } failure:^(NSError * _Nonnull error) {
                    NSLog(@"Meteorite location unavailable with error: %@", error);
                } always:^{
                    dispatch_group_leave(group);
                }];
                
                dispatch_group_notify(group, mainQueue, ^{
                    success(meteoriteResponse);
                });
            }
            
        } else {
            failure(error);
        }
        always();
    }];
    [downloadTask resume];
}

@end
