//
//  DetailViewController.h
//  Talula X
//
//  Created by Diana Brnovik on 17/05/2021.
//

#import <UIKit/UIKit.h>
#import "DetailViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) DetailViewModel * viewModel;

@end

NS_ASSUME_NONNULL_END
