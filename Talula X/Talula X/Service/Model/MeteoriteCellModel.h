//
//  MeteoriteCellModel.h
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CDMeteorite+CoreDataProperties.h"
#import "CDMeteorite+CoreDataClass.h"
#import "Meteorite.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteCellModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *massRounded;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *lastDistance;

- (void)setupFromCDMeteorite:(CDMeteorite *)meteorite;
- (void)setupFromMeteorite:(Meteorite *)meteorite;
- (NSNumber *)distanceFromLocation:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
