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

@end
