//
//  MeteoriteResponse.h
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import <Foundation/Foundation.h>
#import "Meteorite.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteResponse : NSObject

@property (readonly, nonatomic) NSMutableArray<Meteorite *> * meteorites;

- (instancetype)initFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
