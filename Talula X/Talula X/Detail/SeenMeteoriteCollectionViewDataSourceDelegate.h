//
//  SeenMeteoriteCollectionViewDataSourceDelegate.h
//  Talula X
//
//  Created by Diana Brnovik on 18/05/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SeenMeteoriteCellModel.h"
#import "SeenMeteoriteCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeenMeteoriteCollectionViewDataSourceDelegate : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray<SeenMeteoriteCellModel*>* cellModels;

@end

NS_ASSUME_NONNULL_END
