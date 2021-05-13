//
//  MeteoritesDownloader.h
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import <Foundation/Foundation.h>
#import "MeteoriteResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeteoritesDownloader : NSObject

- (void)meteorites:(void(^)(MeteoriteResponseModel *meteorite))success
           failure:(void(^)(NSError *error))failure
            always:(void(^)(void))always;

@end

NS_ASSUME_NONNULL_END
