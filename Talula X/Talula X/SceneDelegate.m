//
//  SceneDelegate.m
//  Talula X
//
//  Created by Diana Brnovik on 10/05/2021.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "AppCoordinator.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions
{
    if (scene != nil) {
        UINavigationController * navigationController = [[UINavigationController alloc] init];
        if (@available(iOS 11.0, *)) {
            navigationController.navigationBar.prefersLargeTitles = YES;
            // alebo [[[self navigationController] navigationBar] setPrefersLargeTitles:YES];
        }
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        _window = [[UIWindow alloc] initWithWindowScene:windowScene];
        _window.rootViewController = navigationController;
        [_window makeKeyAndVisible];
        
        [[AppCoordinator new] showMasterFromNavigationController:navigationController];
    }
}

@end
