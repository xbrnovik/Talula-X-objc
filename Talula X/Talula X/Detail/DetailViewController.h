//
//  DetailViewController.h
//  Talula X
//
//  Created by Diana Brnovik on 17/05/2021.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DetailViewModel.h"
#import "Meteorite.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) DetailViewModel * viewModel;
@property (strong, nonatomic) Meteorite * meteorite;

- (void)setPinnedPlaceName:(NSString *)name
               andDistance:(NSString *)distance;

@end

NS_ASSUME_NONNULL_END
