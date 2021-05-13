//
//  MeteoriteCellModel.h
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteCellModel : NSObject


@property (readonly, strong) NSString *identifier;
@property (readonly, strong) NSString *latitude;
@property (readonly, strong) NSString *longitude;
@property (readonly, strong) NSString *category;
@property (readonly, strong) NSString *year;
@property (readonly, strong) NSNumber *mass;
@property (readonly, strong) NSString *name;
@property (readonly, strong) NSString *place;

@end

NS_ASSUME_NONNULL_END
