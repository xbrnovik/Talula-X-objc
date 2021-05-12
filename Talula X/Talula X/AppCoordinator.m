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


- (void)showHomeFromNavigationController:(UINavigationController *)navigationController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MasterView" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"MasterViewIdentifier"];
    [navigationController pushViewController:controller animated:YES];
}

@end
