//
//  SeenMeteoriteCollectionViewDataSourceDelegate.m
//  Talula X
//
//  Created by Diana Brnovik on 18/05/2021.
//

#import "SeenMeteoriteCollectionViewDataSourceDelegate.h"

@interface SeenMeteoriteCollectionViewDataSourceDelegate () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CollectionViewButtonDelegate>

@end

@implementation SeenMeteoriteCollectionViewDataSourceDelegate


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SeenMeteoriteCellModel *model = _cellModels[indexPath.row];
    SeenMeteoriteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SEEN_METEORITE_COLLECTIONVIEW_CELL_IDENTIFIER forIndexPath:indexPath];
    cell.nameLabel.text = model.name;
    cell.iconImageView.image = model.icon;
    cell.indexPath = indexPath;
    
    if (_isEditing) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            
        anim.toValue = @(-0.05);
        anim.fromValue = @(0.05);
        anim.duration = 0.1;
        anim.repeatCount = MAXFLOAT;
        anim.autoreverses = YES;
        anim.repeatCount = HUGE_VALF;
        
        [cell.layer addAnimation:anim forKey:@"Shake"];
        cell.deleteButton.hidden = NO;
    } else {
        [cell.layer removeAllAnimations];
        cell.deleteButton.hidden = YES;
    }
    
    cell.delegate = self;
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cellModels.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _cellModels[indexPath.row].navigateHandler(indexPath);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80.0, 100.0);
}

- (void)buttonTappedAtIndexPath:(NSIndexPath *)indexPath
{
    _cellModels[indexPath.row].deleteHandler(indexPath);
}

@end
