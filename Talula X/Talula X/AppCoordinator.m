//
//  AppStarter.m
//  Talula X
//
//  Created by Diana Brnovik on 11/05/2021.
//

#import "AppCoordinator.h"

@interface AppCoordinator ()

@end

@implementation AppCoordinator


- (void)showMasterFromNavigationController:(UINavigationController *)navigationController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MasterView" bundle:nil];
    MasterViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"MasterViewIdentifier"];
    MasterViewModel *viewModel = [[MasterViewModel alloc] initWithMeteoriteService:[MeteoriteService new]
                                                                   locationService:[LocationService new]
                                                                           storage:[MeteoriteStorage new]
                                                                        controller:controller];
    controller.viewModel = viewModel;
    [navigationController pushViewController:controller animated:YES];
}

- (void)showDetailFromNavigationController:(UINavigationController *)navigationController
                             withMeteorite:(Meteorite *)meteorite
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DetailView" bundle:nil];
    DetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewIdentifier"];
    DetailViewModel *viewModel = [[DetailViewModel alloc] initWithMeteoriteService:[MeteoriteService new]
                                                                   locationService:[LocationService new]
                                                                           storage:[MeteoriteStorage new]
                                                                        controller:controller
                                                                         meteorite:meteorite];
    controller.viewModel = viewModel;
    [navigationController pushViewController:controller animated:YES];
}

@end
