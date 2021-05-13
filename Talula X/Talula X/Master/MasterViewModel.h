//
//  MasterViewModel.h
//  Talula X
//
//  Created by Diana Brnovik on 11/05/2021.
//

#import <Foundation/Foundation.h>
#import "MeteoriteModel.h"
#import "MasterViewController.h"
#import "MeteoritesDownloader.h"


@interface MasterViewModel : NSObject

@property (strong, nonatomic) MeteoritesDownloader * downloader;
@property (readonly, nonatomic) NSArray<MeteoriteModel *> * meteorites;

- (void)updateMeteorites;

@end
