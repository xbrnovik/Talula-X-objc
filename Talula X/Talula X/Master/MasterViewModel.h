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

@class MasterViewController;


@interface MasterViewModel : NSObject

@property (strong, nonatomic) MeteoriteService * service;
@property (strong, nonatomic) MeteoriteStorage * storage;
@property (readonly, nonatomic) NSMutableArray<MeteoriteCellModel *> * meteorites; //NOTE: private(set) => readonly + writeonly

- (instancetype)initWithMeteoriteService:(MeteoriteService *)service
                                 storage:(MeteoriteStorage *)storage
                              controller:(MasterViewController *)controller;
- (void)updateMeteorites;

@end
