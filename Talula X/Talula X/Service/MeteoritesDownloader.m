//
//  MeteoritesDownloader.m
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import "MeteoritesDownloader.h"

@implementation MeteoritesDownloader

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

- (void)meteorites:(void(^)(MeteoriteResponse *meteoriteResponse))success
           failure:(void(^)(NSError * error))failure
            always:(void(^)(void))always
{

    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
      dataTaskWithURL:[self createURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            MeteoriteResponse *meteoriteResponse = [[MeteoriteResponse alloc] initFromData:data];
            success(meteoriteResponse);
        } else {
            failure(error);
        }
        always();
    }];
    [downloadTask resume];
}

@end
