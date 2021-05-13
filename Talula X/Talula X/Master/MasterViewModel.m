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
@property (readwrite, assign) NSMutableArray<Meteorite *> * meteorites;

@end

@implementation MasterViewModel

- (instancetype)initWithMeteoritesDownloader:(MeteoritesDownloader *)downloader
                                  controller:(MasterViewController *)controller
{
    _downloader = downloader;
    _controller = controller;
    self = [super init];
    if (self) {
        //NOTE: set delegates
    }
    return self;
}

- (void)updateMeteorites
{
    // TODO: UI start loading
    
    [_downloader meteorites:^(MeteoriteResponse * _Nonnull meteoriteResponse) {
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        // TODO: store CD + get UI models
        weakSelf.meteorites = meteoriteResponse.meteorites;
        [weakSelf.controller reloadMeteorites];
    } failure:^(NSError * _Nonnull error) {
        // TODO: UI show error
    } always:^{
        // TODO: UI stop loading
    }];
    // controller reload
}


@end
