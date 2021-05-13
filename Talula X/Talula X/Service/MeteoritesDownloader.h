//
//  MeteoritesDownloader.h
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import <Foundation/Foundation.h>
#import "MeteoriteResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeteoritesDownloader : NSObject

- (void)meteorites:(void(^)(MeteoriteResponse *meteoriteResponse))success
           failure:(void(^)(NSError *error))failure
            always:(void(^)(void))always;

@end

NS_ASSUME_NONNULL_END
