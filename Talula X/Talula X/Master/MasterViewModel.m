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
@property (readwrite, strong) NSMutableArray<MeteoriteCellModel *> * meteoriteCellModels;
@property (strong, nonatomic) NSMutableArray<Meteorite *> * meteorites;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMeteorites) name:@"didUpdateLocations" object:nil];
    return self;
}

- (void)updateCellModels
{
    NSMutableArray<MeteoriteCellModel *> * models = [NSMutableArray new];
    for (Meteorite* meteorite in _meteorites) {
        MeteoriteCellModel *model = [MeteoriteCellModel new];
        [model setupFromMeteorite:meteorite];
        [models addObject:model];
    }
    _meteoriteCellModels = models;
}

#pragma mark - Load

// offline
- (void)loadMeteorites
{
    NSMutableArray<Meteorite *> * newMeteorites = [NSMutableArray new];
    NSArray<CDMeteorite*>* storedMeteorites = [_storage storedMeteorites];
    for (CDMeteorite* storedMeteorite in storedMeteorites) {
        Meteorite *newMeteorite = [Meteorite new];
        [newMeteorite setupFromCDMeteorite:storedMeteorite];
        [newMeteorites addObject:newMeteorite];
    }
    _meteorites = newMeteorites;
    [_controller reloadMeteoritesWithSuccess:NO];
}

// online
- (void)updateMeteorites
{
    [_locationService requestPermission];
    NSMutableArray<Meteorite *> * newMeteorites = [NSMutableArray new];
    [_meteoriteService meteorites:^(MeteoriteResponse * _Nonnull meteoriteResponse) {
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        [weakSelf.storage storeMeteorites:meteoriteResponse.meteorites];
        weakSelf.meteorites = meteoriteResponse.meteorites;
        [self sortMeteorites];
        [self updateCellModels];
        [self setCellHandlers];
        [weakSelf.controller reloadMeteoritesWithSuccess:YES];
    } failure:^(NSError * _Nonnull error) {
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        NSArray<CDMeteorite*>* storedMeteorites = [weakSelf.storage storedMeteorites];
        for (CDMeteorite* storedMeteorite in storedMeteorites) {
            Meteorite *newMeteorite = [Meteorite new];
            [newMeteorite setupFromCDMeteorite:storedMeteorite];
            [newMeteorites addObject:newMeteorite];
        }
        weakSelf.meteorites = newMeteorites;
        [self sortMeteorites];
        [self updateCellModels];
        [self setCellHandlers];
        [weakSelf.controller reloadMeteoritesWithSuccess:NO];
    } always:^{
        //NOTE: Happens always.
    }];
}

// gps
- (void)reloadMeteorites
{
    [self sortMeteorites];
    [self updateCellModels];
    [self setCellHandlers];
    [_controller reloadMeteorites];
}

#pragma mark - Adjust (sort, handler)

- (void)sortMeteorites
{
    NSArray<Meteorite*>* sortedArray;
    sortedArray = [_meteorites sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(Meteorite*)a distanceFromLocation:_locationService.lastKnownLocation];
        NSNumber *second = [(Meteorite*)b distanceFromLocation:_locationService.lastKnownLocation];
        return [first compare:second];
    }];
    _meteorites = [sortedArray mutableCopy];
}

- (void)setCellHandlers
{
    SelectedRowHandler selectedRowHandler = ^(NSIndexPath *indexPath) {
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        [weakSelf showDetailWithMeteorite:weakSelf.meteorites[indexPath.row]];
    };
    
    for (MeteoriteCellModel *model in _meteoriteCellModels) {
        model.handler = selectedRowHandler;
    }
}

#pragma mark - Navigate

- (void)showDetailWithMeteorite:(Meteorite *)meteorite
{
    UINavigationController *navigationController = _controller.navigationController;
    if ((navigationController) && (meteorite)) {
        [[AppCoordinator new] showDetailFromNavigationController:navigationController withMeteorite:meteorite];
    }
}

@end
