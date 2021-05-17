//
//  MasterViewModel.h
//  Talula X
//
//  Created by Diana Brnovik on 11/05/2021.
//

#import <Foundation/Foundation.h>
#import "MeteoriteCellModel.h"
#import "MeteoriteService.h"
#import "MeteoriteStorage.h"
#import "LocationService.h"


@class MasterViewController;


@interface MasterViewModel : NSObject

@property (strong, nonatomic) MeteoriteService * meteoriteService;
@property (strong, nonatomic) LocationService * locationService;
@property (strong, nonatomic) MeteoriteStorage * storage;
@property (readonly, nonatomic) NSMutableArray<MeteoriteCellModel *> * meteorites; //NOTE: private(set) => readonly + writeonly

- (instancetype)initWithMeteoriteService:(MeteoriteService *)meteoriteService
                         locationService:(LocationService *)locationService
                                 storage:(MeteoriteStorage *)storage
                              controller:(MasterViewController *)controller;
- (void)updateMeteorites;
- (void)sortMeteorites;

@end
