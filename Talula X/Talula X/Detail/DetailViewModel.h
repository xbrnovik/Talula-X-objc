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

- (instancetype)initWithMeteoriteService:(MeteoriteService *)meteoriteService
                         locationService:(LocationService *)locationService
                                 storage:(MeteoriteStorage *)storage
                              controller:(DetailViewController *)controller;

@end

NS_ASSUME_NONNULL_END
