//
//  AppStarter.m
//  Talula X
//
//  Created by Diana Brnovik on 11/05/2021.
//

#import "AppCoordinator.h"

@interface AppCoordinator ()

@property (strong, nonatomic) MeteoriteService * meteoriteService;
@property (strong, nonatomic) LocationService * locationService;
@property (strong, nonatomic) MeteoriteStorage * storage;

@end

@implementation AppCoordinator

+ (AppCoordinator *) shared
{
    static AppCoordinator *appCoordinator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appCoordinator = [[AppCoordinator alloc] init];
        appCoordinator.meteoriteService = [MeteoriteService new];
        appCoordinator.locationService = [LocationService new];
        appCoordinator.storage = [MeteoriteStorage new];
    });
    return appCoordinator;
}


- (void)showMasterFromNavigationController:(UINavigationController *)navigationController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MasterView" bundle:nil];
    MasterViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"MasterViewIdentifier"];
    MasterViewModel *viewModel = [[MasterViewModel alloc] initWithMeteoriteService:_meteoriteService
                                                                   locationService:_locationService
                                                                           storage:_storage
                                                                        controller:controller];
    controller.viewModel = viewModel;
    [navigationController pushViewController:controller animated:YES];
}

- (void)showDetailFromNavigationController:(UINavigationController *)navigationController
                             withMeteorite:(Meteorite *)meteorite
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DetailView" bundle:nil];
    DetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewIdentifier"];
    DetailViewModel *viewModel = [[DetailViewModel alloc] initWithMeteoriteService:_meteoriteService
                                                                   locationService:_locationService
                                                                           storage:_storage
                                                                        controller:controller
                                                                         meteorite:meteorite];
    controller.viewModel = viewModel;
    [navigationController pushViewController:controller animated:YES];
}

@end
