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

- (void)loadMeteorites
{
    NSMutableArray<MeteoriteCellModel *> * newMeteorites = [NSMutableArray new];
    NSArray<CDMeteorite*>* storedMeteorites = [_storage storedMeteorites];
    for (NSArray<CDMeteorite*>* storedMeteorite in storedMeteorites) {
        MeteoriteCellModel *model = [MeteoriteCellModel new];
        [model setupFromCDMeteorite:storedMeteorite];
        [newMeteorites addObject:model];
    }
    _meteorites = newMeteorites;
    [_controller reloadMeteorites];
}

- (void)updateMeteorites
{
    [_service meteorites:^(MeteoriteResponse * _Nonnull meteoriteResponse) {
        NSMutableArray<MeteoriteCellModel *> * newMeteorites = [NSMutableArray new];
        _meteorites = newMeteorites;
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        [weakSelf.storage storeMeteorites:meteoriteResponse.meteorites];
        for (Meteorite* downloadedMeteorite in meteoriteResponse.meteorites) {
            MeteoriteCellModel *model = [MeteoriteCellModel new];
            [model setupFromMeteorite:downloadedMeteorite];
            [newMeteorites addObject:model];
        }
        [weakSelf.controller endLoadingWithSuccess:YES];
        [weakSelf.controller reloadMeteorites];
    } failure:^(NSError * _Nonnull error) {
        NSMutableArray<MeteoriteCellModel *> * newMeteorites = [NSMutableArray new];
        _meteorites = newMeteorites;
        NSArray<CDMeteorite*>* storedMeteorites = [_storage storedMeteorites];
        for (CDMeteorite* storedMeteorite in storedMeteorites) {
            MeteoriteCellModel *model = [MeteoriteCellModel new];
            [model setupFromCDMeteorite:storedMeteorite];
            [newMeteorites addObject:model];
        }
        [_controller endLoadingWithSuccess:NO];
    } always:^{
        //NOTE: Happens always.
    }];
}

@end
