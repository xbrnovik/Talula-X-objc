//
//  MeteoriteModel.h
//  Talula X
//
//  Created by Diana Brnovik on 12/05/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteModel : NSObject

@property (readonly, strong) NSString *name;
@property (readonly, assign) NSInteger mass;
@property (readonly, strong) NSString *place;

@property (readonly, strong) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
