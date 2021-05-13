//
//  AppStarter.h
//  Talula X
//
//  Created by Diana Brnovik on 11/05/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MeteoritesDownloader.h"
#import "MasterViewController.h"
#import "MasterViewModel.h"

@interface AppCoordinator : NSObject

- (void)showHomeFromNavigationController:(UINavigationController *)navigationController;

@end
