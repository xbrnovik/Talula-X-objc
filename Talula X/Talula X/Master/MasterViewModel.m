//
//  MasterViewModel.m
//  Talula X
//
//  Created by Diana Brnovik on 11/05/2021.
//

#import "MasterViewModel.h"

@interface MasterViewModel ()

@property (weak, nonatomic) MasterViewController * controller;

@end

@implementation MasterViewModel

@synthesize meteorites = _meteorites;

- (NSArray<MeteoriteModel *> *) meteorites
{
    return  @[[MeteoriteModel new], [MeteoriteModel new], [MeteoriteModel new]];
}

- (instancetype)initWithServiceHolder:(MasterViewController *)serviceHolder //TODO serviceHolder
                           controller:(MasterViewController *)controller
{
    _downloader = [MeteoritesDownloader new];
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
    [_downloader meteorites:^(MeteoriteResponseModel * _Nonnull meteorite) {
        // TODO: store CD + get UI models
    } failure:^(NSError * _Nonnull error) {
        // TODO: UI show error
    } always:^{
        // TODO: UI stop loading
    }];
    // controller reload
}


@end
