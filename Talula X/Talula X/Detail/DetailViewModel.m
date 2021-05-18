//
//  DetailViewModel.m
//  Talula X
//
//  Created by Diana Brnovik on 17/05/2021.
//

#import "DetailViewModel.h"

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

- (NSString *)currentPlace
{
    return _locationService.lastKnownLocationName;
}

- (NSString *)pinnedPlace
{
    return @"to Brno";
}

- (NSString *)distanceToCurrentPlaceLabel
{
    MKDistanceFormatter *distanceFormatter = [[MKDistanceFormatter alloc]init];
    distanceFormatter.unitStyle = MKDistanceFormatterUnitStyleFull;
    NSString *distancePretty = [distanceFormatter stringFromDistance:[_meteorite.lastDistance doubleValue]];
    return distancePretty;
}

- (NSString *)distanceToPinnedPlaceLabel
{
    return @"966687 miles";
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

@end
