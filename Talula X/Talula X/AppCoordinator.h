//
//  AppStarter.h
//  Talula X
//
//  Created by Diana Brnovik on 11/05/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MeteoriteService.h"

#import "MasterViewController.h"
#import "MasterViewModel.h"

#import "Detail/DetailViewModel.h"
#import "Detail/DetailViewController.h"

@interface AppCoordinator : NSObject

- (void)showMasterFromNavigationController:(UINavigationController *)navigationController;
- (void)showDetailFromNavigationController:(UINavigationController *)navigationController;

@end
