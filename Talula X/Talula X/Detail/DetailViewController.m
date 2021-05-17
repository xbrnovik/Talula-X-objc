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
    self.title = @"Detail";
}

@end
