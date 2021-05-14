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

- (instancetype)initWithMeteoriteService:(MeteoriteService *)meteoriteService
                         locationService:(LocationService *)locationService
                                 storage:(MeteoriteStorage *)storage
                              controller:(MasterViewController *)controller
{
    _meteoriteService = meteoriteService;
    _locationService = locationService;
    _storage = storage;
    _controller = controller;
    self = [super init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortMeteorites) name:@"didUpdateLocations" object:nil];
    return self;
}

- (void)loadMeteorites
{
    NSMutableArray<MeteoriteCellModel *> * newMeteorites = [NSMutableArray new];
    NSArray<CDMeteorite*>* storedMeteorites = [_storage storedMeteorites];
    for (CDMeteorite* storedMeteorite in storedMeteorites) {
        MeteoriteCellModel *model = [MeteoriteCellModel new];
        [model setupFromCDMeteorite:storedMeteorite];
        [newMeteorites addObject:model];
    }
    _meteorites = newMeteorites;
    [_controller reloadMeteoritesWithSuccess:NO];
}

- (void)updateMeteorites
{
    [_locationService requestPermission];
    NSMutableArray<MeteoriteCellModel *> * newMeteorites = [NSMutableArray new];
    [_meteoriteService meteorites:^(MeteoriteResponse * _Nonnull meteoriteResponse) {
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        [weakSelf.storage storeMeteorites:meteoriteResponse.meteorites];
        for (Meteorite* downloadedMeteorite in meteoriteResponse.meteorites) {
            MeteoriteCellModel *model = [MeteoriteCellModel new];
            [model setupFromMeteorite:downloadedMeteorite];
            [newMeteorites addObject:model];
        }
        weakSelf.meteorites = newMeteorites;
        [weakSelf sortMeteorites];
        [weakSelf.controller reloadMeteoritesWithSuccess:YES];
    } failure:^(NSError * _Nonnull error) {
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        NSArray<CDMeteorite*>* storedMeteorites = [weakSelf.storage storedMeteorites];
        for (CDMeteorite* storedMeteorite in storedMeteorites) {
            MeteoriteCellModel *model = [MeteoriteCellModel new];
            [model setupFromCDMeteorite:storedMeteorite];
            [newMeteorites addObject:model];
        }
        weakSelf.meteorites = newMeteorites;
        [weakSelf sortMeteorites];
        [weakSelf.controller reloadMeteoritesWithSuccess:NO];
    } always:^{
        //NOTE: Happens always.
    }];
}

- (void)sortMeteorites
{
    NSArray<MeteoriteCellModel*>* sortedArray;
    sortedArray = [_meteorites sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(MeteoriteCellModel*)a distanceFromLocation:_locationService.lastKnownLocation];
        NSNumber *second = [(MeteoriteCellModel*)b distanceFromLocation:_locationService.lastKnownLocation];
        return [first compare:second];
    }];
    _meteorites = sortedArray;
    [_controller reloadMeteoritesWithSuccess:YES];
}

@end
