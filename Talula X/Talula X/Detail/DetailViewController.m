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
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *coordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *toCurrentPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *toPinnedPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceToCurrentPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceToPinnedPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILongPressGestureRecognizer *gestureRecognizer;

@property (weak, nonatomic) IBOutlet UIStackView *pinnedPlaceStackView;
@property (weak, nonatomic) MKPointAnnotation *meteoriteAnnotation;
@property (weak, nonatomic) MKPointAnnotation *pinnedAnnotation;

@property (strong, nonatomic) SeenMeteoriteCollectionViewDataSourceDelegate *seenMeteoriteCollectionViewDataSourceDelegate;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"";
    self.nameLabel.text = _viewModel.meteorite.name;
    self.placeLabel.text = _viewModel.meteorite.place;
    self.coordinatesLabel.text = _viewModel.coordinates;
    self.toCurrentPlaceLabel.text = _viewModel.currentPlaceName;
    self.distanceToCurrentPlaceLabel.text = _viewModel.distanceToCurrentPlace;
    self.yearLabel.text = _viewModel.year;
    self.pinnedPlaceStackView.hidden = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Meteorites" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    _seenMeteoriteCollectionViewDataSourceDelegate = [SeenMeteoriteCollectionViewDataSourceDelegate new];
    [_seenMeteoriteCollectionView registerNib:[UINib nibWithNibName:@"SeenMeteoriteCollectionViewCell" bundle:nil]
                   forCellWithReuseIdentifier:@"SeenMeteoriteCollectionViewCell"];
    _seenMeteoriteCollectionView.dataSource = _seenMeteoriteCollectionViewDataSourceDelegate;
    _seenMeteoriteCollectionView.delegate = _seenMeteoriteCollectionViewDataSourceDelegate;
    _seenMeteoriteCollectionViewDataSourceDelegate.cellModels = [_viewModel meteoriteCellModels];
    
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

- (IBAction)longPressedGesture:(id)sender {
    if (_gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSMutableArray *annotationsToRemove = [NSMutableArray new];
        for (id annotation in _mapView.annotations){
            if (annotation != _meteoriteAnnotation) {
                [annotationsToRemove addObject:annotation];
            }
        }
        [_mapView removeAnnotations:annotationsToRemove];
        
        CGPoint point = [_gestureRecognizer locationInView:_mapView];
        CLLocationCoordinate2D coordinates = [_mapView convertPoint:point toCoordinateFromView:_mapView];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] initWithCoordinate:coordinates];
        [_mapView addAnnotation:annotation];
        
        _pinnedAnnotation = annotation;
        CLLocation *pinLocation = [[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
        [_viewModel placePinFromGesture:pinLocation];
    }
}

- (void)setPinnedPlaceName:(NSString *)name
                andDistance:(NSString *)distance
{
    _toPinnedPlaceLabel.text = name;
    _distanceToPinnedPlaceLabel.text = distance;
    _pinnedAnnotation.title = name;
    _pinnedPlaceStackView.hidden = NO;
}


- (void)setCurrentPlaceName:(NSString *)name
                andDistance:(NSString *)distance
{
    _toCurrentPlaceLabel.text = name;
    _distanceToCurrentPlaceLabel.text = distance;
}

@end
