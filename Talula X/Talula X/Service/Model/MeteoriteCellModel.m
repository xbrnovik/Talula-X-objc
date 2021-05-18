//
//  MeteoriteCellModel.m
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import "MeteoriteCellModel.h"

@interface MeteoriteCellModel ()

    @property (strong, nonatomic) NSNumber *mass;
    @property (strong, nonatomic) NSNumber *lastDistance;

@end

@implementation MeteoriteCellModel

@synthesize massRounded = _massRounded;
@synthesize icon = _icon;
@synthesize distance = _distance;

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

- (NSString *)distance
{
    MKDistanceFormatter *distanceFormatter = [[MKDistanceFormatter alloc]init];
    distanceFormatter.unitStyle = MKDistanceFormatterUnitStyleFull;
    NSString *distancePretty = [distanceFormatter stringFromDistance:[_lastDistance doubleValue]];
    return distancePretty;
}

#pragma mark - Setup

- (void)setupFromMeteorite:(Meteorite *)meteorite
{
    _name = meteorite.name;
    _mass = meteorite.mass;
    _place = meteorite.place;
    _latitude = meteorite.latitude;
    _longitude = meteorite.longitude;
    _lastDistance = meteorite.lastDistance;
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
