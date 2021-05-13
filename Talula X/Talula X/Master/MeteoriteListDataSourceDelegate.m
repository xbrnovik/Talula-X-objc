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

- (instancetype)initWithCellModels:(NSArray<Meteorite*>*)cellModels
{
    _cellModels = cellModels;
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Meteorite *model = _cellModels[indexPath.row];
    MeteoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:METEORITE_TABLEVIEW_CELL_IDENTIFIER forIndexPath:indexPath];
    cell.nameLabel.text = model.name;
    cell.massLabel.text = [[self localeFormatter] stringFromNumber:model.mass]; // :( not great, not terrible
    cell.placeLabel.text = model.place;
    cell.iconImageView.image = [UIImage new];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellModels.count;
}

- (NSNumberFormatter *)localeFormatter
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 0;
    return formatter;
}

@end
