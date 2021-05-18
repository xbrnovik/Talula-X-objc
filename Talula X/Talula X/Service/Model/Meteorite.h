//
//  Meteorite.h
//  Talula X
//
//  Created by Diana Brnovik on 12/05/2021.
//

#import <Foundation/Foundation.h>
#import "CDMeteorite+CoreDataClass.h"
#import "CDMeteorite+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface Meteorite : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSDate *year;
@property (strong, nonatomic) NSNumber *mass;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) NSNumber *lastDistance;

- (void)setupFromCDMeteorite:(CDMeteorite *)meteorite;
- (NSNumber *)distanceFromLocation:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
