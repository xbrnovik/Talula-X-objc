//
//  SeenMeteoriteCellCollectionViewCell.h
//  Talula X
//
//  Created by Diana Brnovik on 18/05/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const SEEN_METEORITE_COLLECTIONVIEW_CELL_IDENTIFIER;

@interface SeenMeteoriteCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

NS_ASSUME_NONNULL_END
