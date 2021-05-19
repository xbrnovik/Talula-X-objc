//
//  SeenMeteoriteCollectionViewDataSourceDelegate.m
//  Talula X
//
//  Created by Diana Brnovik on 18/05/2021.
//

#import "SeenMeteoriteCollectionViewDataSourceDelegate.h"

@interface SeenMeteoriteCollectionViewDataSourceDelegate () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation SeenMeteoriteCollectionViewDataSourceDelegate


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SeenMeteoriteCellModel *model = _cellModels[indexPath.row];
    SeenMeteoriteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SEEN_METEORITE_COLLECTIONVIEW_CELL_IDENTIFIER forIndexPath:indexPath];
    cell.nameLabel.text = model.name;
    cell.iconImageView.image = model.icon;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cellModels.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _cellModels[indexPath.row].handler(indexPath);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80.0, 110.0);
}
@end
