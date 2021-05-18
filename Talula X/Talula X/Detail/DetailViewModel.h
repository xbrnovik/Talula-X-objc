//
//  DetailViewModel.h
//  Talula X
//
//  Created by Diana Brnovik on 17/05/2021.
//

#import <Foundation/Foundation.h>
#import "MeteoriteService.h"
#import "MeteoriteStorage.h"
#import "LocationService.h"

@class DetailViewController;

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewModel : NSObject

@property (strong, nonatomic) MeteoriteService * meteoriteService;
@property (strong, nonatomic) LocationService * locationService;
@property (strong, nonatomic) MeteoriteStorage * storage;
@property (strong, nonatomic) Meteorite * meteorite;

@property (readonly, nonatomic) NSString * currentPlace;
@property (readonly, nonatomic) NSString * pinnedPlace;
@property (readonly, nonatomic) NSString * distanceToCurrentPlaceLabel;
@property (readonly, nonatomic) NSString * distanceToPinnedPlaceLabel;
@property (readonly, nonatomic) NSString * year;
@property (readonly, nonatomic) NSString * name;
@property (readonly, nonatomic) NSString * place;
@property (readonly, nonatomic) NSString * coordinates;

- (instancetype)initWithMeteoriteService:(MeteoriteService *)meteoriteService
                         locationService:(LocationService *)locationService
                                 storage:(MeteoriteStorage *)storage
                              controller:(DetailViewController *)controller
                               meteorite:(Meteorite *)meteorite;

@end

NS_ASSUME_NONNULL_END
