//
//  SeenMeteoriteCellModel.h
//  Talula X
//
//  Created by Diana Brnovik on 18/05/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Meteorite.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectedRowHandler)(NSIndexPath *indexPath);

@interface SeenMeteoriteCellModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *icon;
@property (nonatomic) SelectedRowHandler navigateHandler;
@property (nonatomic) SelectedRowHandler deleteHandler;

- (instancetype)initFromCDMeteorite:(CDMeteorite *)meteorite;

@end

NS_ASSUME_NONNULL_END
