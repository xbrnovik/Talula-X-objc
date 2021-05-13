//
//  MeteoriteService.h
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MeteoriteResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteService : NSObject

- (void)meteorites:(void(^)(MeteoriteResponse *meteoriteResponse))success
           failure:(void(^)(NSError *error))failure
            always:(void(^)(void))always;

- (void)placemarkFromLocation:(CLLocation *)location
                    success:(void(^)(CLPlacemark *))success
                    failure:(void(^)(NSError * error))failure
                     always:(void(^)(void))always;

@end

NS_ASSUME_NONNULL_END
