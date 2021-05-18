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

typedef void(^SelectedRowHandler)(NSIndexPath *indexPath);

@interface MeteoriteCellModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *massRounded;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *distance;
@property (nonatomic) SelectedRowHandler handler;

- (void)setupFromMeteorite:(Meteorite *)meteorite;

@end

NS_ASSUME_NONNULL_END
