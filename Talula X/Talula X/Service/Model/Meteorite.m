//
//  Meteorite.m
//  Talula X
//
//  Created by Diana Brnovik on 12/05/2021.
//

#import "Meteorite.h"

@interface Meteorite ()

@end

@implementation Meteorite

@synthesize name = _name;
@synthesize mass = _mass;
@synthesize place = _place;

- (NSString *)name
{
    return @"Nejaky meteorit";
}

- (NSInteger)mass
{
    return 1000;
}

- (NSString *)place
{
    return @"Nejaka krajina";
}

@end
