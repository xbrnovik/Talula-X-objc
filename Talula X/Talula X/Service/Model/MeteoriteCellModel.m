//
//  MeteoriteCellModel.m
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import "MeteoriteCellModel.h"

@implementation MeteoriteCellModel

@synthesize mass = _mass;

- (NSNumber *)mass
{
    return @1000;
}

- (void)setupFromCDMeteorite:(CDMeteorite *)meteorite
{
    _name = meteorite.name;
    NSNumber *massNumber = [NSNumber numberWithDouble:meteorite.mass];
    _mass = [[self localeFormatter] stringFromNumber:massNumber]; // :( not great, not terrible
    _place = meteorite.place;
}

- (NSNumberFormatter *)localeFormatter
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 0;
    return formatter;
}

- (void)setupFromMeteorite:(Meteorite *)meteorite
{
    _name = meteorite.name;
    _mass = [[self localeFormatter] stringFromNumber:meteorite.mass]; // :( not great, not terrible
    _place = meteorite.place;
}

@end
