//
//  MasterViewModel.h
//  Talula X
//
//  Created by Diana Brnovik on 11/05/2021.
//

#import <Foundation/Foundation.h>
#import "Meteorite.h"
#import "MeteoriteService.h"

@class MasterViewController;


@interface MasterViewModel : NSObject

@property (strong, nonatomic) MeteoriteService * service;
@property (readonly, nonatomic) NSMutableArray<Meteorite *> * meteorites; //NOTE: private(set) => readonly + writeonly

- (instancetype)initWithMeteoriteService:(MeteoriteService *)service
                              controller:(MasterViewController *)controller;
- (void)updateMeteorites;

@end
