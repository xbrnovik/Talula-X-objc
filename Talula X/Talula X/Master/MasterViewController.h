//
//  ViewController.h
//  Talula X
//
//  Created by Diana Brnovik on 10/05/2021.
//

#import <UIKit/UIKit.h>
#import "MeteoriteListDataSourceDelegate.h"
#import "Meteorite.h"
#import "MasterViewModel.h"

@class MasterViewModel;

@interface MasterViewController : UIViewController

@property (strong, nonatomic) MasterViewModel * viewModel;

-(void)reloadMeteorites;
- (void)startLoading;
- (void)endLoadingWithSuccess:(BOOL)success;

@end

