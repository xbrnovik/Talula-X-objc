//
//  Meteorite.h
//  Talula X
//
//  Created by Diana Brnovik on 12/05/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Meteorite : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSNumber *mass;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *place;

@end

NS_ASSUME_NONNULL_END