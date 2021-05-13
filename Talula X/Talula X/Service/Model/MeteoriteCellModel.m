//
//  MeteoriteCellModel.m
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import "MeteoriteCellModel.h"

@implementation MeteoriteCellModel

@synthesize name = _name;
@synthesize mass = _mass;
@synthesize place = _place;

- (NSString *)name
{
    return @"Nejaky meteorit";
}

- (NSNumber *)mass
{
    return @1000;
}

- (NSString *)place
{
    return @"Nejaka krajina";
}

@end
