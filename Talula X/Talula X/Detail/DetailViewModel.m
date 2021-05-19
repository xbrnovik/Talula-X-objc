//
//  DetailViewModel.m
//  Talula X
//
//  Created by Diana Brnovik on 17/05/2021.
//

#import "DetailViewModel.h"
#import "DetailViewController.h"

@interface DetailViewModel ()

@property (weak, nonatomic) DetailViewController * controller;
@property (readwrite, strong) NSArray<SeenMeteoriteCellModel *> * meteoriteCellModels;
@property (strong, nonatomic) NSArray<CDMeteorite *> * seenCDMeteorites;

@end

@implementation DetailViewModel

- (instancetype)initWithMeteoriteService:(MeteoriteService *)meteoriteService
                         locationService:(LocationService *)locationService
                                 storage:(MeteoriteStorage *)storage
                              controller:(DetailViewController *)controller
                               meteorite:(Meteorite *)meteorite
{
    _meteoriteService = meteoriteService;
    _locationService = locationService;
    _storage = storage;
    _controller = controller;
    _meteorite = meteorite;
    self = [super init];
    if (self) {
        NSMutableArray<SeenMeteoriteCellModel *> * models = [NSMutableArray new];
        _seenCDMeteorites = [_storage seenMeteoritesWithoutMeteoriteWithIdentifier:meteorite.identifier];
        for (CDMeteorite *seenCDMeteorite in _seenCDMeteorites) {
            SeenMeteoriteCellModel *model = [[SeenMeteoriteCellModel alloc] initFromCDMeteorite:seenCDMeteorite];
            [models addObject:model];
        }
        _meteoriteCellModels = models;
        [self setCellHandlers];
        [_storage setSeenById:_meteorite.identifier];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCurrentPlace) name:@"didUpdateLocations" object:nil];
    }
    return self;
}

- (NSString *)currentPlaceName
{
    return _locationService.lastKnownLocationName;
}

- (NSString *)distanceToCurrentPlace
{
    MKDistanceFormatter *distanceFormatter = [[MKDistanceFormatter alloc]init];
    distanceFormatter.unitStyle = MKDistanceFormatterUnitStyleFull;
    NSString *distancePretty = [distanceFormatter stringFromDistance:[_meteorite.lastDistance doubleValue]];
    return distancePretty;
}

- (NSString *)year
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    return [dateFormatter stringFromDate:_meteorite.year];

}

- (NSString *)coordinates
{
    return [NSString stringWithFormat:@"%@, %@", _meteorite.latitude, _meteorite.longitude];
}

- (void)placePinFromGesture:(CLLocation *)location
{
    [_meteoriteService placemarkFromLocation:location success:^(CLPlacemark * _Nonnull placemark) {
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        NSNumber *distance = [weakSelf.meteorite distanceFromLocation:location];
        [weakSelf.controller setPinnedPlaceName:placemark.name
                                    andDistance:[weakSelf prettyFormatDistance:distance]];
    } failure:^(NSError * _Nonnull error) {
        //TODO: Error state.
    } always:^{
        //NOTE: Happens always.
    }];
}

- (NSString *)prettyFormatDistance:(NSNumber *)distance
{
    MKDistanceFormatter *distanceFormatter = [[MKDistanceFormatter alloc]init];
    distanceFormatter.unitStyle = MKDistanceFormatterUnitStyleFull;
    NSString *distancePretty = [distanceFormatter stringFromDistance:[distance doubleValue]];
    return distancePretty;
}

#pragma mark - Navigate

- (void)showDetailWithMeteorite:(CDMeteorite *)seenCDMeteorite
{
    UINavigationController *navigationController = _controller.navigationController;
    Meteorite *seenMeteorite = [Meteorite new];
    [seenMeteorite setupFromCDMeteorite:seenCDMeteorite];
    if ((navigationController) && (seenMeteorite)) {
        [[AppCoordinator shared] showDetailFromNavigationController:navigationController withMeteorite:seenMeteorite];
    }
}

- (void)setCellHandlers
{
    SelectedRowHandler selectedRowHandler = ^(NSIndexPath *indexPath) {
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        [weakSelf showDetailWithMeteorite:weakSelf.seenCDMeteorites[indexPath.row]];
        
        NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: weakSelf.controller.navigationController.viewControllers];
        [navigationArray removeObjectAtIndex: navigationArray.count-2];
        weakSelf.controller.navigationController.viewControllers = navigationArray;
    };
    
    for (SeenMeteoriteCellModel *model in _meteoriteCellModels) {
        model.handler = selectedRowHandler;
    }
}

// gps
- (void)reloadCurrentPlace
{
    NSString *lastKnownLocationName = _locationService.lastKnownLocationName;
    
    MKDistanceFormatter *distanceFormatter = [[MKDistanceFormatter alloc]init];
    distanceFormatter.unitStyle = MKDistanceFormatterUnitStyleFull;
    NSString *distancePretty = [distanceFormatter stringFromDistance:[_meteorite.lastDistance doubleValue]];
    [_controller setCurrentPlaceName:lastKnownLocationName andDistance:distancePretty];
}

@end
