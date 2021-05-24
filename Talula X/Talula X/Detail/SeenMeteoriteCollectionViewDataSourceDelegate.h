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

@protocol CollectionViewButtonDelegate <NSObject>

@required
- (void)buttonTappedAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SeenMeteoriteCollectionViewDataSourceDelegate : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CollectionViewButtonDelegate>

@property (strong, nonatomic) NSArray<SeenMeteoriteCellModel*>* cellModels;
@property (nonatomic) BOOL isEditing;

@end

NS_ASSUME_NONNULL_END
