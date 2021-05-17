//
//  MeteoriteResponseModel.h
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import <Foundation/Foundation.h>
#import "Meteorite.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteResponse : NSObject

@property (readonly, nonatomic) NSArray<Meteorite *> * meteorites;

@end

NS_ASSUME_NONNULL_END
