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
    [self reloadMeteorites];
}

-(void)reloadMeteorites
{
    if (_meteoritesTableView != nil) {
        NSArray<MeteoriteModel*>* models = [_viewModel meteorites]; //TODO: from view model
        
        _meteoriteListDataSourceDelegate.cellModels = models;
        __weak typeof(self) self = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self meteoritesTableView] reloadData];
        });
    }
}

@end
