//
//  ViewController.m
//  Talula X
//
//  Created by Diana Brnovik on 10/05/2021.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UITableView *meteoritesTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) MeteoriteListDataSourceDelegate *meteoriteListDataSourceDelegate;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Meteorites";
    self.errorLabel.text = @"Prepáč, nastala chyba. Zobrazované dáta sú offline.";
    self.errorView.hidden = YES;
    _meteoriteListDataSourceDelegate = [MeteoriteListDataSourceDelegate new];
    [self.meteoritesTableView registerNib:[UINib nibWithNibName:@"MeteoriteTableViewCell" bundle:nil] forCellReuseIdentifier:@"MeteoriteTableViewCell"];
    _refreshControl = [[UIRefreshControl alloc]init];
    [_refreshControl addTarget:self action:@selector(refreshDataTapped) forControlEvents:UIControlEventValueChanged];
    self.meteoritesTableView.refreshControl = _refreshControl;
    self.meteoritesTableView.dataSource = _meteoriteListDataSourceDelegate;
    self.meteoritesTableView.delegate = _meteoriteListDataSourceDelegate;
    [_viewModel updateMeteorites];
}

- (void)reloadMeteoritesWithSuccess:(BOOL)success
{
    if (_meteoritesTableView != nil) {
        NSArray<MeteoriteCellModel*>* models = [_viewModel meteorites];
        _meteoriteListDataSourceDelegate.cellModels = models;
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.meteoritesTableView reloadData];
            [weakSelf.refreshControl endRefreshing];
            weakSelf.errorView.hidden = success;
        });
    }
}

- (void)refreshDataTapped
{
    [_viewModel updateMeteorites];
}

@end
