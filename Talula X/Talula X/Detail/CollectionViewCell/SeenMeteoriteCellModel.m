//
//  SeenMeteoriteCellModel.m
//  Talula X
//
//  Created by Diana Brnovik on 18/05/2021.
//

#import "SeenMeteoriteCellModel.h"

@interface SeenMeteoriteCellModel ()

@property (strong, nonatomic) NSNumber *mass;

@end

@implementation SeenMeteoriteCellModel

@synthesize icon = _icon;

- (instancetype)initFromCDMeteorite:(CDMeteorite *)meteorite
{
    self = [super init];
    if (self) {
        _name = meteorite.name;
        _mass = [[NSNumber alloc] initWithDouble:meteorite.mass ];
    }
    return self;
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

@end
