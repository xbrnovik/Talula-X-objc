//
//  SeenMeteoriteCollectionViewCell.m
//  Talula X
//
//  Created by Diana Brnovik on 19/05/2021.
//

#import "SeenMeteoriteCollectionViewCell.h"
#import "SeenMeteoriteCollectionViewDataSourceDelegate.h"

NSString *const SEEN_METEORITE_COLLECTIONVIEW_CELL_IDENTIFIER = @"SeenMeteoriteCollectionViewCell";

@implementation SeenMeteoriteCollectionViewCell

@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)deleteTapped:(id)sender
{
    [delegate buttonTappedAtIndexPath:_indexPath];
}

@end
