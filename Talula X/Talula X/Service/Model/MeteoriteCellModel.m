//
//  MeteoriteCellModel.m
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import "MeteoriteCellModel.h"

@interface MeteoriteCellModel ()

    @property (strong, nonatomic) NSNumber *mass;

@end

@implementation MeteoriteCellModel

@synthesize massRounded = _massRounded;
@synthesize icon = _icon;

- (NSString *)massRounded
{
    NSString *massRoundedText = [self.localeFormatter stringFromNumber:_mass]; // :( not great, not terrible;
    return [NSString stringWithFormat:@"%@ g", massRoundedText];
}

- (UIImage *)icon
{
    if ([_mass doubleValue] >= 10000) {
        return [UIImage imageNamed:@"BigMeteorite"];
    } else if ([_mass doubleValue] >= 1000) {
        return [UIImage imageNamed:@"SmallMeteorite"];
    } else {
        return [UIImage imageNamed:@"OtherMeteorite"];
    }
}

#pragma mark - Setup

- (void)setupFromCDMeteorite:(CDMeteorite *)meteorite
{
    _name = meteorite.name;
    _mass = [NSNumber numberWithDouble:meteorite.mass];
    _place = meteorite.place ? meteorite.place : @"-";
    _latitude = [[NSNumber alloc] initWithDouble:meteorite.latitude];
    _longitude = [[NSNumber alloc] initWithDouble:meteorite.longitude];
}

- (void)setupFromMeteorite:(Meteorite *)meteorite
{
    _name = meteorite.name;
    _mass = meteorite.mass;
    _place = meteorite.place ? meteorite.place : @"-";
    _latitude = meteorite.latitude;
    _longitude = meteorite.longitude;
}

#pragma mark - Calculate

- (NSNumber *)distanceFromLocation:(CLLocation *)location
{
    CLLocation *meteoriteLocation = [[CLLocation alloc] initWithLatitude:[_latitude doubleValue] longitude:[_longitude doubleValue]];
    double distanceDouble = [meteoriteLocation distanceFromLocation:location];
    NSNumber *distance = [[NSNumber alloc] initWithDouble:distanceDouble];
    MKDistanceFormatter *distanceFormatter = [[MKDistanceFormatter alloc]init];
    distanceFormatter.unitStyle = MKDistanceFormatterUnitStyleFull;
    NSString *distancePretty = [distanceFormatter stringFromDistance:distanceDouble];
    _lastDistance = distancePretty;
    return distance;
}

#pragma mark - Formatters

- (NSNumberFormatter *)localeFormatter
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 0;
    return formatter;
}

- (NSNumberFormatter *)localeDecimal
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 0;
    return formatter;
}

@end
