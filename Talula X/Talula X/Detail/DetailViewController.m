//
//  DetailViewController.m
//  Talula X
//
//  Created by Diana Brnovik on 17/05/2021.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UICollectionView *seenMeteoriteCollectionView;
@property (weak, nonatomic) IBOutlet UIView *seenMeteoriteView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *coordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *toCurrentPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *toPinnedPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceToCurrentPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceToPinnedPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (weak, nonatomic) IBOutlet UILongPressGestureRecognizer *mapLongGestureRecognizer;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *collectionLongGestureRecognizer;

@property (weak, nonatomic) IBOutlet UIStackView *pinnedPlaceStackView;
@property (weak, nonatomic) MKPointAnnotation *meteoriteAnnotation;
@property (weak, nonatomic) MKPointAnnotation *pinnedAnnotation;

@property (strong, nonatomic) SeenMeteoriteCollectionViewDataSourceDelegate *seenMeteoriteCollectionViewDataSourceDelegate;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray<SeenMeteoriteCellModel *> *seenCellModels = [_viewModel meteoriteCellModels];
    self.title = @"";
    self.nameLabel.text = _viewModel.meteorite.name;
    self.placeLabel.text = _viewModel.meteorite.place;
    self.coordinatesLabel.text = _viewModel.coordinates;
    self.toCurrentPlaceLabel.text = _viewModel.currentPlaceName;
    self.distanceToCurrentPlaceLabel.text = _viewModel.distanceToCurrentPlace;
    self.yearLabel.text = _viewModel.year;
    self.pinnedPlaceStackView.hidden = YES;
    self.seenMeteoriteView.hidden = (!seenCellModels || !seenCellModels.count) ? YES : NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Meteorites" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    _seenMeteoriteCollectionViewDataSourceDelegate = [SeenMeteoriteCollectionViewDataSourceDelegate new];
    [_seenMeteoriteCollectionView registerNib:[UINib nibWithNibName:@"SeenMeteoriteCollectionViewCell" bundle:nil]
                   forCellWithReuseIdentifier:@"SeenMeteoriteCollectionViewCell"];
    _seenMeteoriteCollectionView.dataSource = _seenMeteoriteCollectionViewDataSourceDelegate;
    _seenMeteoriteCollectionView.delegate = _seenMeteoriteCollectionViewDataSourceDelegate;
    _seenMeteoriteCollectionViewDataSourceDelegate.cellModels = seenCellModels;
    
    [self setupMap];
}


- (void)setupMap
{
    CLLocationDegrees latitude = [_viewModel.meteorite.latitude doubleValue];
    CLLocationDegrees longitude = [_viewModel.meteorite.longitude doubleValue];
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(10, 10);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinates, span);
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] initWithCoordinate:coordinates
                                                                           title:_viewModel.meteorite.name
                                                                        subtitle:_viewModel.meteorite.place];
    [_mapView addAnnotation:annotation];
    [_mapView setRegion:region];
    _meteoriteAnnotation = annotation;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (_mapView.annotations.count> 0) {
        [_mapView removeAnnotations:_mapView.annotations];
    }
}

- (IBAction)addPinPressedGesture:(id)sender {
    if (_mapLongGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSMutableArray *annotationsToRemove = [NSMutableArray new];
        for (id annotation in _mapView.annotations){
            if (annotation != _meteoriteAnnotation) {
                [annotationsToRemove addObject:annotation];
            }
        }
        [_mapView removeAnnotations:annotationsToRemove];
        
        CGPoint point = [_mapLongGestureRecognizer locationInView:_mapView];
        CLLocationCoordinate2D coordinates = [_mapView convertPoint:point toCoordinateFromView:_mapView];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] initWithCoordinate:coordinates];
        [_mapView addAnnotation:annotation];
        
        _pinnedAnnotation = annotation;
        CLLocation *pinLocation = [[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
        [_viewModel placePinFromGesture:pinLocation];
    }
}

- (IBAction)cancelSeenMeteoriteEditingTappedGesture:(id)sender
{
    self.seenMeteoriteCollectionViewDataSourceDelegate.isEditing = NO;
    [self.seenMeteoriteCollectionView reloadData];
}

- (IBAction)startSeenMeteoriteEditingPressedGesture:(id)sender
{
    if (_collectionLongGestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    self.seenMeteoriteCollectionViewDataSourceDelegate.isEditing = YES;
    [self.seenMeteoriteCollectionView reloadData];
    
//    CAShapeLayer *borderLayer = [CAShapeLayer layer];
//    borderLayer.strokeColor = [UIColor lightGrayColor].CGColor;
//    borderLayer.fillColor = nil;
//    borderLayer.lineDashPattern = @[@4, @2];
//    borderLayer.frame = self.seenMeteoriteView.bounds;
//    borderLayer.path = [UIBezierPath bezierPathWithRect:self.seenMeteoriteView.bounds].CGPath;
//    [self.seenMeteoriteView.layer addSublayer:borderLayer];
}

- (void)setPinnedPlaceName:(NSString *)name
                andDistance:(NSString *)distance
{
    _toPinnedPlaceLabel.text = name;
    _distanceToPinnedPlaceLabel.text = distance;
    _pinnedAnnotation.title = name;
    [UIView animateWithDuration:1.0 animations:^{
        __weak typeof(self) weakSelf = self; // :( not great not terrible
        weakSelf.pinnedPlaceStackView.hidden = NO;
    } completion:nil];
}


- (void)setCurrentPlaceName:(NSString *)name
                andDistance:(NSString *)distance
{
    _toCurrentPlaceLabel.text = name;
    _distanceToCurrentPlaceLabel.text = distance;
}

- (void)reloadSeenMeteorites
{
    NSArray<SeenMeteoriteCellModel *> *seenCellModels = [_viewModel meteoriteCellModels];
    _seenMeteoriteCollectionViewDataSourceDelegate.cellModels = seenCellModels;
    __weak typeof(self) weakSelf = self; // :( not great not terrible
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.seenMeteoriteCollectionView performBatchUpdates:^{
            [self.seenMeteoriteCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                weakSelf.seenMeteoriteView.hidden = (!seenCellModels || !seenCellModels.count) ? YES : NO;
            } completion:nil];
        }];
    });
}

@end
