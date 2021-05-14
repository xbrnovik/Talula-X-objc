//
//  MeteoriteListDataSourceDelegate.m
//  Talula X
//
//  Created by Diana Brnovik on 12/05/2021.
//

#import "MeteoriteListDataSourceDelegate.h"

@interface MeteoriteListDataSourceDelegate () <UITableViewDataSource, UITableViewDelegate>

@end


@implementation MeteoriteListDataSourceDelegate

- (instancetype)initWithCellModels:(NSArray<MeteoriteCellModel*>*)cellModels
{
    _cellModels = cellModels;
    self = [super init];
    return self;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MeteoriteCellModel *model = _cellModels[indexPath.row];
    MeteoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:METEORITE_TABLEVIEW_CELL_IDENTIFIER forIndexPath:indexPath];
    cell.nameLabel.text = model.name;
    cell.massLabel.text = model.massRounded;
    cell.placeLabel.text = model.place;
    cell.iconImageView.image = model.icon;
    cell.distanceLabel.text = model.lastDistance;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellModels.count;
}

@end
