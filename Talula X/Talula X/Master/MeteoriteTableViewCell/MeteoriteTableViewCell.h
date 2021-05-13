//
//  MeteoriteTableViewCell.h
//  Talula X
//
//  Created by Diana Brnovik on 12/05/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *massLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@end

NS_ASSUME_NONNULL_END
