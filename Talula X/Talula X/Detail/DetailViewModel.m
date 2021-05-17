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
{
    _meteoriteService = meteoriteService;
    _locationService = locationService;
    _storage = storage;
    _controller = controller;
    self = [super init];
    return self;
}

@end
