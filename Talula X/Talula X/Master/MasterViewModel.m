//
//  MasterViewModel.m
//  Talula X
//
//  Created by Diana Brnovik on 11/05/2021.
//

#import "MasterViewModel.h"
#import "MasterViewController.h"

@interface MasterViewModel ()

@property (weak, nonatomic) MasterViewController * controller;
@property (readwrite, assign) NSMutableArray<MeteoriteCellModel *> * meteorites;

@end

@implementation MasterViewModel

- (instancetype)initWithMeteoriteService:(MeteoriteService *)service
                                 storage:(MeteoriteStorage *)storage
                              controller:(MasterViewController *)controller
{
    _service = service;
    _storage = storage;
    _controller = controller;
    self = [super init];
    return self;
}

- (void)updateMeteorites
{
    // TODO: UI start loading
    [_service meteorites:^(MeteoriteResponse * _Nonnull meteoriteResponse) {
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        NSMutableArray<MeteoriteCellModel *> * newMeteorites = [NSMutableArray new];
        [weakSelf.storage storeMeteorites:meteoriteResponse.meteorites];
        for (NSArray<CDMeteorite*>* downloadedMeteorite in meteoriteResponse.meteorites) {
            MeteoriteCellModel *model = [MeteoriteCellModel new];
            [model setupFromMeteorite:downloadedMeteorite];
            [newMeteorites addObject:model];
        }
        weakSelf.meteorites = newMeteorites;
        [weakSelf.controller reloadMeteorites];
    } failure:^(NSError * _Nonnull error) {
        // TODO: UI show error
        [self loadMeteorites];
    } always:^{
        // TODO: UI stop loading
    }];
}


- (void)loadMeteorites
{
    NSMutableArray<MeteoriteCellModel *> * newMeteorites = [NSMutableArray new];
    NSArray<CDMeteorite*>* storedMeteorites = [_storage loadMeteorites];
    for (NSArray<CDMeteorite*>* storedMeteorite in storedMeteorites) {
        MeteoriteCellModel *model = [MeteoriteCellModel new];
        [model setupFromCDMeteorite:storedMeteorite];
        [newMeteorites addObject:model];
    }
    _meteorites = newMeteorites;
    [_controller reloadMeteorites];
}

@end
