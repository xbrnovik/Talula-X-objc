//
//  SeenMeteoriteCollectionViewCell.h
//  Talula X
//
//  Created by Diana Brnovik on 19/05/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const SEEN_METEORITE_COLLECTIONVIEW_CELL_IDENTIFIER;

@protocol CollectionViewButtonDelegate;

@interface SeenMeteoriteCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *subcontentView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, weak) id <CollectionViewButtonDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
