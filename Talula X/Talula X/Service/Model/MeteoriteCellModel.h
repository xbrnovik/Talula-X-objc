//
//  MeteoriteCellModel.h
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteCellModel : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSDate *year;
@property (strong, nonatomic) NSNumber *mass;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *place;

@end

NS_ASSUME_NONNULL_END
