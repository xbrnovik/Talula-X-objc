//
//  MeteoriteResponse.m
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import "MeteoriteResponse.h"

@implementation MeteoriteResponse

- (instancetype)initFromData:(NSData *)data
{
    _meteorites = [[NSMutableArray alloc] init];
    NSError* error;
    NSDictionary* meteoritesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    for (NSDictionary* meteoriteValues in meteoritesDictionary) {
        
        NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
        NSString* massText = [meteoriteValues objectForKey:@"mass"];
        NSString* longitudeText = [meteoriteValues objectForKey:@"reclat"];
        NSString* latitudeText = [meteoriteValues objectForKey:@"reclong"];
        
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        NSString* yearText = [meteoriteValues objectForKey:@"year"];
        
        Meteorite* meteorite = [Meteorite new];
        meteorite.identifier = [meteoriteValues objectForKey:@"id"];
        meteorite.name = [meteoriteValues objectForKey:@"name"];
        meteorite.category = [meteoriteValues objectForKey:@"recclass"];
        meteorite.mass = [numberFormatter numberFromString:massText];
        meteorite.longitude = [numberFormatter numberFromString:longitudeText];
        meteorite.latitude = [numberFormatter numberFromString:latitudeText];
        meteorite.year = [dateFormat dateFromString:yearText];
        
        [_meteorites addObject:meteorite];
    }
    self = [super init];
    return self;
}

@end
