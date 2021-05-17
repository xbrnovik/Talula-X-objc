//
//  MeteoriteListDataSourceDelegate.h
//  Talula X
//
//  Created by Diana Brnovik on 12/05/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MeteoriteCellModel.h"
#import "MeteoriteTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteListDataSourceDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray<MeteoriteCellModel*>* cellModels;

@end

NS_ASSUME_NONNULL_END
