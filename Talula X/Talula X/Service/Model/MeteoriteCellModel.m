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
    return [[self localeFormatter] stringFromNumber:_mass]; // :( not great, not terrible;
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

- (void)setupFromCDMeteorite:(CDMeteorite *)meteorite
{
    _name = meteorite.name;
    _mass = [NSNumber numberWithDouble:meteorite.mass];
    _place = meteorite.place;
}

- (void)setupFromMeteorite:(Meteorite *)meteorite
{
    _name = meteorite.name;
    _mass = meteorite.mass;
    _place = meteorite.place ? meteorite.place : @"-";
}

- (NSNumberFormatter *)localeFormatter
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 0;
    return formatter;
}

- (NSNumberFormatter *)localeDecimal
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 0;
    return formatter;
}

@end
