//
//  DetailViewController.m
//  Talula X
//
//  Created by Diana Brnovik on 17/05/2021.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *coordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *toCurrentPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *toPinnedPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceToCurrentPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceToPinnedPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"";
    
    self.nameLabel.text = _viewModel.meteorite.name;
    self.placeLabel.text = _viewModel.meteorite.place;
    
    self.coordinatesLabel.text = _viewModel.coordinates;
    
    self.toCurrentPlaceLabel.text = _viewModel.currentPlace;
    self.toPinnedPlaceLabel.text = _viewModel.pinnedPlace;
    self.distanceToCurrentPlaceLabel.text = _viewModel.distanceToCurrentPlaceLabel;
    self.distanceToPinnedPlaceLabel.text = _viewModel.distanceToPinnedPlaceLabel;
    
    self.yearLabel.text = _viewModel.year;
    
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
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (_mapView.annotations.count> 0) {
        [_mapView removeAnnotations:_mapView.annotations];
    }
}

@end
