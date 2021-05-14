//
//  ViewController.m
//  Talula X
//
//  Created by Diana Brnovik on 10/05/2021.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *meteoritesTableView;
@property (strong, nonatomic) MeteoriteListDataSourceDelegate *meteoriteListDataSourceDelegate;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Meteorites";
    _meteoriteListDataSourceDelegate = [MeteoriteListDataSourceDelegate new];
    [self.meteoritesTableView registerNib:[UINib nibWithNibName:@"MeteoriteTableViewCell" bundle:nil] forCellReuseIdentifier:@"MeteoriteTableViewCell"];
    self.meteoritesTableView.dataSource = _meteoriteListDataSourceDelegate;
    self.meteoritesTableView.delegate = _meteoriteListDataSourceDelegate;
    [_viewModel updateMeteorites];
}

-(void)reloadMeteorites
{
    if (_meteoritesTableView != nil) {
        NSArray<MeteoriteCellModel*>* models = [_viewModel meteorites];
        _meteoriteListDataSourceDelegate.cellModels = models;
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        dispatch_async(dispatch_get_main_queue(), ^{
            [[weakSelf meteoritesTableView] reloadData];
        });
    }
}

@end
